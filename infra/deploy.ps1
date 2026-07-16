# ============================================================
# PhotoGallery — Azure Infrastructure Deployment Script
# deploy.ps1 — Windows (PowerShell)
# ============================================================
# Usage:
#   .\deploy.ps1 `
#       -StorageAccountName "<name>" `
#       [-ResourceGroupName "rg-photogallery"] `
#       [-StorageAccountResourceGroup "<rg>"] `
#       [-Location "eastus2"] `
#       [-EnvironmentName "prod"]
# ============================================================

param(
    [Parameter(Mandatory = $true)]
    [string]$StorageAccountName,

    [Parameter(Mandatory = $false)]
    [string]$ResourceGroupName = "rg-photogallery",

    [Parameter(Mandatory = $false)]
    [string]$StorageAccountResourceGroup = "",

    [Parameter(Mandatory = $false)]
    [string]$Location = "eastus2",

    [Parameter(Mandatory = $false)]
    [string]$EnvironmentName = "prod"
)

$ErrorActionPreference = "Stop"

# Default storage account RG to deployment RG if not provided
if ([string]::IsNullOrWhiteSpace($StorageAccountResourceGroup)) {
    $StorageAccountResourceGroup = $ResourceGroupName
}

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host ""
Write-Host "========================================================"
Write-Host " PhotoGallery — Azure Infrastructure Deployment"
Write-Host "========================================================"
Write-Host " Resource Group   : $ResourceGroupName"
Write-Host " Location         : $Location"
Write-Host " Environment      : $EnvironmentName"
Write-Host " Storage Account  : $StorageAccountName (RG: $StorageAccountResourceGroup)"
Write-Host "========================================================"
Write-Host ""

# ── Step 1: Verify Azure CLI login ───────────────────────────
Write-Host "[1/5] Verifying Azure CLI login..."
try {
    $Account = az account show --query "{name:name, id:id}" -o json 2>$null | ConvertFrom-Json
    if (-not $Account) { throw "Not logged in" }
    Write-Host "  Subscription: $($Account.name)"
    Write-Host "  ID          : $($Account.id)"
} catch {
    Write-Error "ERROR: Not logged in to Azure. Run: az login"
    exit 1
}

# ── Step 2: Verify storage account exists ────────────────────
Write-Host ""
Write-Host "[2/5] Verifying existing storage account '$StorageAccountName'..."
$StorageCheck = az storage account show `
    --name $StorageAccountName `
    --resource-group $StorageAccountResourceGroup `
    --query "id" -o tsv 2>$null
if (-not $StorageCheck) {
    Write-Error "ERROR: Storage account '$StorageAccountName' not found in resource group '$StorageAccountResourceGroup'."
    exit 1
}
Write-Host "  Found storage account: $StorageAccountName"

# ── Step 3: Create resource group ────────────────────────────
Write-Host ""
Write-Host "[3/5] Creating resource group '$ResourceGroupName' in '$Location'..."
az group create `
    --name $ResourceGroupName `
    --location $Location `
    --tags project=photogallery managedBy=bicep environment=$EnvironmentName `
    --output none
if ($LASTEXITCODE -ne 0) { Write-Error "Failed to create resource group."; exit 1 }
Write-Host "  Resource group ready."

# ── Step 4: Deploy Bicep template ────────────────────────────
Write-Host ""
Write-Host "[4/5] Deploying Bicep template..."
$DeploymentName = "photogallery-infra-$(Get-Date -Format 'yyyyMMddHHmmss')"

$DeploymentOutput = az deployment group create `
    --name $DeploymentName `
    --resource-group $ResourceGroupName `
    --template-file "$ScriptDir\main.bicep" `
    --parameters `
        location=$Location `
        environmentName=$EnvironmentName `
        storageAccountName=$StorageAccountName `
        storageAccountResourceGroup=$StorageAccountResourceGroup `
    --query "properties.outputs" `
    -o json | ConvertFrom-Json

if ($LASTEXITCODE -ne 0) {
    Write-Error "ERROR: Bicep deployment failed."
    exit 1
}
Write-Host "  Deployment successful."

# ── Step 5: Extract outputs and write infra-config.md ────────
Write-Host ""
Write-Host "[5/5] Writing infra-config.md..."

$SubscriptionId      = az account show --query id -o tsv
$LogAnalyticsName    = $DeploymentOutput.logAnalyticsWorkspaceName.value
$MiName              = $DeploymentOutput.managedIdentityName.value
$MiClientId          = $DeploymentOutput.managedIdentityClientId.value
$AcrName             = $DeploymentOutput.containerRegistryName.value
$AcrLoginServer      = $DeploymentOutput.containerRegistryLoginServer.value
$AceName             = $DeploymentOutput.containerAppsEnvironmentName.value
$CaName              = $DeploymentOutput.containerAppName.value
$CaFqdn              = $DeploymentOutput.containerAppFqdn.value

$InfraConfigContent = @"
# Azure Resources Config

## Environment Info

| Property | Value |
|----------|-------|
| Subscription ID | ``$SubscriptionId`` |
| Resource Group | ``$ResourceGroupName`` |
| Location | ``$Location`` |

## Resource List

| Resource Type | Name | Region | Config Details |
|---------------|------|---------|----------------|
| Log Analytics Workspace | ``$LogAnalyticsName`` | $Location | Log aggregation for Container Apps |
| User-Assigned Managed Identity | ``$MiName`` | $Location | Client ID: ``$MiClientId`` |
| Azure Container Registry | ``$AcrName`` | $Location | Login server: ``$AcrLoginServer`` |
| Container Apps Environment | ``$AceName`` | $Location | Connected to Log Analytics |
| Container App | ``$CaName`` | $Location | FQDN: ``$CaFqdn`` |
| Storage Account (existing) | ``$StorageAccountName`` | (existing) | Storage Blob Data Contributor assigned to MI |
"@

Set-Content -Path "$ScriptDir\infra-config.md" -Value $InfraConfigContent -Encoding UTF8
Write-Host "  infra-config.md written."

Write-Host ""
Write-Host "========================================================"
Write-Host " Deployment Complete!"
Write-Host "========================================================"
Write-Host " Container App URL : https://$CaFqdn"
Write-Host " ACR Login Server  : $AcrLoginServer"
Write-Host " Managed Identity  : $MiClientId"
Write-Host "========================================================"
