# PhotoGallery — Azure Infrastructure

This directory contains all Bicep Infrastructure as Code (IaC) files required to provision the Azure resources for the PhotoGallery ASP.NET Core application running on Azure Container Apps.

---

## Architecture Overview

```
Azure Subscription
└── rg-photogallery (Resource Group — eastus2)
    ├── azlaw{token}   — Log Analytics Workspace
    ├── azmi{token}    — User-Assigned Managed Identity
    │     ├── AcrPull → azacr{token}
    │     └── Storage Blob Data Contributor → (existing storage account)
    ├── azacr{token}   — Azure Container Registry (Basic)
    ├── azace{token}   — Container Apps Environment (→ Log Analytics)
    └── azca{token}    — Container App (placeholder → PhotoGallery image)
```

---

## File Structure

```
infra/
├── main.bicep                    # Orchestration — calls all modules
├── main.parameters.json          # Parameter file — update before deployment
├── modules/
│   ├── logAnalytics.bicep        # Log Analytics Workspace
│   ├── managedIdentity.bicep     # User-Assigned Managed Identity
│   ├── containerRegistry.bicep   # ACR (Basic) + AcrPull role assignment
│   ├── storageRoleAssignment.bicep  # Storage Blob Data Contributor on existing account
│   ├── containerAppsEnvironment.bicep  # Container Apps Environment
│   └── containerApp.bicep        # Container App (placeholder image)
├── deploy.ps1                    # Windows deployment script
├── deploy.sh                     # Linux/macOS deployment script
├── README.md                     # This file
├── compliance.md                 # Rules compliance report
└── infra-config.md               # Written after successful provisioning
```

---

## Prerequisites

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) ≥ 2.50.0
- [Bicep CLI](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/install) (installed automatically by Azure CLI)
- An Azure subscription with permission to create resource groups and resources
- An **existing Azure Blob Storage account** for photo storage

---

## Parameters

| Parameter | Required | Default | Description |
|-----------|----------|---------|-------------|
| `storageAccountName` | ✅ | — | Name of the existing Azure Storage Account |
| `storageAccountResourceGroup` | ✅ | `rg-photogallery` | Resource group of the storage account |
| `location` | ❌ | `eastus2` | Azure region for all new resources |
| `environmentName` | ❌ | `prod` | Environment label (`dev`, `test`, `staging`, `prod`) |
| `tags` | ❌ | `{project: photogallery}` | Tags applied to all resources |

---

## Deployment

### Step 1 — Update parameters

Edit `infra/main.parameters.json`:
```json
{
  "storageAccountName": { "value": "YOUR_STORAGE_ACCOUNT" },
  "storageAccountResourceGroup": { "value": "YOUR_STORAGE_RG" }
}
```

### Step 2 — Login to Azure

```bash
az login
az account set --subscription <subscription-id>
```

### Step 3a — Deploy on Windows (PowerShell)

```powershell
cd infra
.\deploy.ps1 `
    -StorageAccountName "mystorageaccount" `
    -ResourceGroupName "rg-photogallery" `
    -StorageAccountResourceGroup "rg-existing-storage"
```

### Step 3b — Deploy on Linux/macOS (Bash)

```bash
cd infra
chmod +x deploy.sh
./deploy.sh \
    --storage-account-name "mystorageaccount" \
    --resource-group "rg-photogallery" \
    --storage-account-rg "rg-existing-storage"
```

### Step 4 — Verify

After deployment completes:
- `infra/infra-config.md` is written with actual resource names and endpoints
- Container App should be running at the FQDN shown in the deployment output
- All resources visible in the Azure Portal under `rg-photogallery`

---

## Resource Naming Convention

All resources follow: `az{prefix}{uniqueToken}` where:
- `{prefix}` is a 2–3 character abbreviation for the resource type
- `{uniqueToken}` = `uniqueString(subscriptionId, resourceGroupId, location, environmentName)`

| Resource | Prefix | Example Name |
|----------|--------|--------------|
| Log Analytics Workspace | `law` | `azlaw4x7n2k` |
| Managed Identity | `mi` | `azmi4x7n2k` |
| Container Registry | `acr` | `azacr4x7n2k` |
| Container Apps Environment | `ace` | `azace4x7n2k` |
| Container App | `ca` | `azca4x7n2k` |

---

## Security Notes

- Admin user is **disabled** on the Container Registry; the Managed Identity uses `AcrPull` role.
- Storage Account uses Managed Identity (`Storage Blob Data Contributor`) — **no connection strings**.
- Container App uses **User-Assigned Managed Identity** (not system-assigned) for all Azure service access.
- All secrets are managed via environment variables; no credentials are stored in the Bicep files.

---

## Post-Deployment (Task 006)

After infrastructure is provisioned, Task 006 will:
1. Build the PhotoGallery Docker image
2. Push it to the provisioned ACR (`infra-config.md` → `containerRegistryLoginServer`)
3. Update the Container App to use the new image (replacing the `containerapps-helloworld` placeholder)
