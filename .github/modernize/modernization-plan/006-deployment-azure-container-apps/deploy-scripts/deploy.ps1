# deploy.ps1
# ─────────────────────────────────────────────────────────────────
# PhotoGallery – Deploy to Azure Container Apps
# Task: 006-deployment-azure-container-apps
# ─────────────────────────────────────────────────────────────────

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# ── Variables ────────────────────────────────────────────────────
$SUBSCRIPTION_ID      = "0dc80431-5546-4681-a92a-2a799ade5139"
$RESOURCE_GROUP       = "rg-photogallery"
$ACR_NAME             = "azacr7yrfua2wocme4"
$ACR_LOGIN_SERVER     = "azacr7yrfua2wocme4.azurecr.io"
$CONTAINER_APP_NAME   = "azca7yrfua2wocme4"
$MANAGED_IDENTITY_RID = "/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.ManagedIdentity/userAssignedIdentities/azmi7yrfua2wocme4"
$MI_CLIENT_ID         = "89dc1e32-a5a1-4dcd-b41e-a94c8d172db1"
$STORAGE_URI          = "https://azstlshxqdyfegr2y.blob.core.windows.net"
$IMAGE_NAME           = "photogallery"
$IMAGE_TAG            = "latest"
$FULL_IMAGE           = "$ACR_LOGIN_SERVER/${IMAGE_NAME}:${IMAGE_TAG}"
$REPO_ROOT            = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)

# ── Step 1: Set subscription ──────────────────────────────────────
Write-Host "`n[1/4] Setting active subscription..." -ForegroundColor Cyan
az account set --subscription $SUBSCRIPTION_ID
Write-Host "Subscription set to $SUBSCRIPTION_ID"

# ── Step 2: Build & push image via ACR remote build ───────────────
Write-Host "`n[2/4] Building and pushing image via az acr build..." -ForegroundColor Cyan
az acr build `
    --registry $ACR_NAME `
    --image "${IMAGE_NAME}:${IMAGE_TAG}" `
    --file "$REPO_ROOT\WebApp-Storage-DotNet\Dockerfile" `
    --platform linux/amd64 `
    "$REPO_ROOT"
Write-Host "Image pushed: $FULL_IMAGE"

# ── Step 3: Update Container App ──────────────────────────────────
Write-Host "`n[3/4] Updating Container App..." -ForegroundColor Cyan

# Attach the user-assigned MI as the registry pull identity
az containerapp registry set `
    --name $CONTAINER_APP_NAME `
    --resource-group $RESOURCE_GROUP `
    --server $ACR_LOGIN_SERVER `
    --identity $MANAGED_IDENTITY_RID

# Update the container image and set environment variable
az containerapp update `
    --name $CONTAINER_APP_NAME `
    --resource-group $RESOURCE_GROUP `
    --image $FULL_IMAGE `
    --set-env-vars "Storage__ServiceUri=$STORAGE_URI"

Write-Host "Container App updated with image: $FULL_IMAGE"

# ── Step 4: Verify running status ────────────────────────────────
Write-Host "`n[4/4] Verifying Container App health..." -ForegroundColor Cyan
$appJson = az containerapp show `
    --name $CONTAINER_APP_NAME `
    --resource-group $RESOURCE_GROUP `
    --output json | ConvertFrom-Json

$provisioningState = $appJson.properties.provisioningState
$runningStatus     = $appJson.properties.runningStatus
$fqdn              = $appJson.properties.configuration.ingress.fqdn

Write-Host "  provisioningState : $provisioningState"
Write-Host "  runningStatus     : $runningStatus"
Write-Host "  FQDN              : $fqdn"

if ($provisioningState -eq "Succeeded" -and $runningStatus -eq "Running") {
    Write-Host "`n✅ Deployment successful! App is running at: https://$fqdn" -ForegroundColor Green
} else {
    Write-Warning "Container App is not yet in Running state. provisioningState=$provisioningState, runningStatus=$runningStatus"
    exit 1
}
