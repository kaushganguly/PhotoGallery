#!/usr/bin/env bash
# ============================================================
# PhotoGallery — Azure Infrastructure Deployment Script
# deploy.sh — Linux/macOS
# ============================================================
# Usage:
#   ./deploy.sh \
#       --storage-account-name <name> \
#       [--resource-group rg-photogallery] \
#       [--storage-account-rg <rg>] \
#       [--location eastus2] \
#       [--environment-name prod]
# ============================================================

set -euo pipefail

# ── Defaults ─────────────────────────────────────────────────
RESOURCE_GROUP="rg-photogallery"
LOCATION="eastus2"
ENVIRONMENT_NAME="prod"
STORAGE_ACCOUNT_NAME=""
STORAGE_ACCOUNT_RG=""

# ── Argument parsing ─────────────────────────────────────────
while [[ $# -gt 0 ]]; do
  case "$1" in
    --storage-account-name)   STORAGE_ACCOUNT_NAME="$2";  shift 2 ;;
    --resource-group)         RESOURCE_GROUP="$2";         shift 2 ;;
    --storage-account-rg)     STORAGE_ACCOUNT_RG="$2";    shift 2 ;;
    --location)               LOCATION="$2";               shift 2 ;;
    --environment-name)       ENVIRONMENT_NAME="$2";       shift 2 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

if [[ -z "$STORAGE_ACCOUNT_NAME" ]]; then
  echo "ERROR: --storage-account-name is required."
  echo "Usage: ./deploy.sh --storage-account-name <name> [--resource-group rg-photogallery] [--location eastus2]"
  exit 1
fi

STORAGE_ACCOUNT_RG="${STORAGE_ACCOUNT_RG:-$RESOURCE_GROUP}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ""
echo "========================================================"
echo " PhotoGallery — Azure Infrastructure Deployment"
echo "========================================================"
echo " Resource Group   : $RESOURCE_GROUP"
echo " Location         : $LOCATION"
echo " Environment      : $ENVIRONMENT_NAME"
echo " Storage Account  : $STORAGE_ACCOUNT_NAME (RG: $STORAGE_ACCOUNT_RG)"
echo "========================================================"
echo ""

# ── Step 1: Verify Azure CLI login ───────────────────────────
echo "[1/5] Verifying Azure CLI login..."
ACCOUNT=$(az account show --query "{name:name, id:id}" -o json 2>/dev/null) || {
  echo "ERROR: Not logged in to Azure. Run: az login"
  exit 1
}
echo "  Subscription: $(echo "$ACCOUNT" | grep -o '"name": "[^"]*"' | head -1 | cut -d'"' -f4)"
echo "  ID          : $(echo "$ACCOUNT" | grep -o '"id": "[^"]*"' | cut -d'"' -f4)"

# ── Step 2: Verify storage account exists ────────────────────
echo ""
echo "[2/5] Verifying existing storage account '$STORAGE_ACCOUNT_NAME'..."
az storage account show \
  --name "$STORAGE_ACCOUNT_NAME" \
  --resource-group "$STORAGE_ACCOUNT_RG" \
  --query "id" -o tsv > /dev/null || {
  echo "ERROR: Storage account '$STORAGE_ACCOUNT_NAME' not found in resource group '$STORAGE_ACCOUNT_RG'."
  exit 1
}
echo "  Found storage account: $STORAGE_ACCOUNT_NAME"

# ── Step 3: Create resource group ────────────────────────────
echo ""
echo "[3/5] Creating resource group '$RESOURCE_GROUP' in '$LOCATION'..."
az group create \
  --name "$RESOURCE_GROUP" \
  --location "$LOCATION" \
  --tags project=photogallery managedBy=bicep environment="$ENVIRONMENT_NAME" \
  --output none
echo "  Resource group ready."

# ── Step 4: Deploy Bicep template ────────────────────────────
echo ""
echo "[4/5] Deploying Bicep template..."
DEPLOYMENT_NAME="photogallery-infra-$(date +%Y%m%d%H%M%S)"

DEPLOYMENT_OUTPUT=$(az deployment group create \
  --name "$DEPLOYMENT_NAME" \
  --resource-group "$RESOURCE_GROUP" \
  --template-file "$SCRIPT_DIR/main.bicep" \
  --parameters \
      location="$LOCATION" \
      environmentName="$ENVIRONMENT_NAME" \
      storageAccountName="$STORAGE_ACCOUNT_NAME" \
      storageAccountResourceGroup="$STORAGE_ACCOUNT_RG" \
  --query "properties.outputs" \
  -o json)

if [[ $? -ne 0 ]]; then
  echo "ERROR: Bicep deployment failed."
  exit 1
fi

echo "  Deployment successful."

# ── Step 5: Extract outputs and write infra-config.md ────────
echo ""
echo "[5/5] Writing infra-config.md..."

SUBSCRIPTION_ID=$(az account show --query id -o tsv)
LOG_ANALYTICS_NAME=$(echo "$DEPLOYMENT_OUTPUT"    | grep -o '"logAnalyticsWorkspaceName"[^}]*"value": "[^"]*"' | grep -o '"value": "[^"]*"' | cut -d'"' -f4)
MI_NAME=$(echo "$DEPLOYMENT_OUTPUT"               | grep -o '"managedIdentityName"[^}]*"value": "[^"]*"' | grep -o '"value": "[^"]*"' | cut -d'"' -f4)
MI_CLIENT_ID=$(echo "$DEPLOYMENT_OUTPUT"          | grep -o '"managedIdentityClientId"[^}]*"value": "[^"]*"' | grep -o '"value": "[^"]*"' | cut -d'"' -f4)
ACR_NAME=$(echo "$DEPLOYMENT_OUTPUT"              | grep -o '"containerRegistryName"[^}]*"value": "[^"]*"' | grep -o '"value": "[^"]*"' | cut -d'"' -f4)
ACR_LOGIN_SERVER=$(echo "$DEPLOYMENT_OUTPUT"      | grep -o '"containerRegistryLoginServer"[^}]*"value": "[^"]*"' | grep -o '"value": "[^"]*"' | cut -d'"' -f4)
ACE_NAME=$(echo "$DEPLOYMENT_OUTPUT"              | grep -o '"containerAppsEnvironmentName"[^}]*"value": "[^"]*"' | grep -o '"value": "[^"]*"' | cut -d'"' -f4)
CA_NAME=$(echo "$DEPLOYMENT_OUTPUT"               | grep -o '"containerAppName"[^}]*"value": "[^"]*"' | grep -o '"value": "[^"]*"' | cut -d'"' -f4)
CA_FQDN=$(echo "$DEPLOYMENT_OUTPUT"              | grep -o '"containerAppFqdn"[^}]*"value": "[^"]*"' | grep -o '"value": "[^"]*"' | cut -d'"' -f4)

cat > "$SCRIPT_DIR/infra-config.md" <<EOF
# Azure Resources Config

## Environment Info

| Property | Value |
|----------|-------|
| Subscription ID | \`$SUBSCRIPTION_ID\` |
| Resource Group | \`$RESOURCE_GROUP\` |
| Location | \`$LOCATION\` |

## Resource List

| Resource Type | Name | Region | Config Details |
|---------------|------|---------|----------------|
| Log Analytics Workspace | \`$LOG_ANALYTICS_NAME\` | $LOCATION | Log aggregation for Container Apps |
| User-Assigned Managed Identity | \`$MI_NAME\` | $LOCATION | Client ID: \`$MI_CLIENT_ID\` |
| Azure Container Registry | \`$ACR_NAME\` | $LOCATION | Login server: \`$ACR_LOGIN_SERVER\` |
| Container Apps Environment | \`$ACE_NAME\` | $LOCATION | Connected to Log Analytics |
| Container App | \`$CA_NAME\` | $LOCATION | FQDN: \`$CA_FQDN\` |
| Storage Account (existing) | \`$STORAGE_ACCOUNT_NAME\` | (existing) | Storage Blob Data Contributor assigned to MI |
EOF

echo "  infra-config.md written."
echo ""
echo "========================================================"
echo " Deployment Complete!"
echo "========================================================"
echo " Container App URL : https://$CA_FQDN"
echo " ACR Login Server  : $ACR_LOGIN_SERVER"
echo " Managed Identity  : $MI_CLIENT_ID"
echo "========================================================"
