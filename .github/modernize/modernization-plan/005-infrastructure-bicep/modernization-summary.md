# Modernization Summary — Task 005: Provision Azure Infrastructure

**Task ID**: 005-infrastructure-bicep  
**Status**: ✅ Complete  
**Completed**: Infrastructure provisioned successfully in Azure

---

## What Was Done

Generated modular Bicep IaC files and provisioned all required Azure resources for the PhotoGallery application to run as a containerized workload on Azure Container Apps.

---

## Files Created

### IaC Files (`infra/`)

| File | Purpose |
|------|---------|
| `infra/main.bicep` | Orchestration template — calls all modules |
| `infra/main.parameters.json` | Parameter file with default values |
| `infra/modules/logAnalytics.bicep` | Log Analytics Workspace module |
| `infra/modules/managedIdentity.bicep` | User-Assigned Managed Identity module |
| `infra/modules/containerRegistry.bicep` | ACR (Basic) + AcrPull role assignment |
| `infra/modules/storageRoleAssignment.bicep` | Storage Blob Data Contributor on existing account |
| `infra/modules/containerAppsEnvironment.bicep` | Container Apps Environment (Log Analytics connected) |
| `infra/modules/containerApp.bicep` | Container App with placeholder image |
| `infra/deploy.ps1` | Windows deployment script |
| `infra/deploy.sh` | Linux/macOS deployment script |
| `infra/README.md` | Infrastructure documentation |
| `infra/compliance.md` | IaC rules compliance report |
| `infra/infra-config.md` | Actual provisioned resource details (post-deployment) |

---

## Resources Provisioned

| Resource Type | Name | Region |
|---------------|------|--------|
| Resource Group | `rg-photogallery` | eastus2 |
| Log Analytics Workspace | `azlaw7yrfua2wocme4` | eastus2 |
| User-Assigned Managed Identity | `azmi7yrfua2wocme4` | eastus2 |
| Azure Container Registry (Basic) | `azacr7yrfua2wocme4` | eastus2 |
| Container Apps Environment | `azace7yrfua2wocme4` | eastus2 |
| Container App | `azca7yrfua2wocme4` | eastus2 |

---

## Role Assignments

| Role | Scope | Assignee |
|------|-------|---------|
| `AcrPull` | `azacr7yrfua2wocme4` | `azmi7yrfua2wocme4` (principal: `af7e99fa-…`) |
| `Storage Blob Data Contributor` | `azstlshxqdyfegr2y` (existing, centralus) | `azmi7yrfua2wocme4` (principal: `af7e99fa-…`) |

---

## Key Outputs (for downstream tasks)

| Key | Value |
|-----|-------|
| Container Registry Login Server | `azacr7yrfua2wocme4.azurecr.io` |
| Container App FQDN | `azca7yrfua2wocme4.wittycoast-d625364c.eastus2.azurecontainerapps.io` |
| Container App URL | `https://azca7yrfua2wocme4.wittycoast-d625364c.eastus2.azurecontainerapps.io` |
| Managed Identity Client ID | `89dc1e32-a5a1-4dcd-b41e-a94c8d172db1` |
| Managed Identity Principal ID | `af7e99fa-1854-4f39-90ce-58b67d59db0a` |

---

## Bicep Design Decisions

- **Modular structure**: One module per resource type for clear separation of concerns and reusability
- **Naming convention**: `az{prefix}{uniqueString(subscriptionId, resourceGroupId, location, environmentName)}` — deterministic, collision-resistant
- **Cross-RG storage role assignment**: Module deployed with `scope: resourceGroup(storageAccountResourceGroup)` to handle the existing storage account in a different resource group
- **AcrPull ordering**: Role assignment is inside `containerRegistry.bicep` and evaluated before the container app module
- **No Key Vault at this stage**: Storage URI is injected as a plain environment variable placeholder; secrets management deferred to Task 006
- **CORS enabled**: All origins permitted on Container App ingress for development; tighten in production
- **Placeholder image**: `mcr.microsoft.com/azuredocs/containerapps-helloworld:latest` — replaced with actual PhotoGallery image in Task 006

---

## Success Criteria Checklist

- [x] `az bicep build infra/main.bicep` completes with no errors
- [x] All 6 Bicep modules validate cleanly
- [x] Deployment script exits 0
- [x] Resource group `rg-photogallery` exists with 5 resources
- [x] Container App is running (`provisioningState: Succeeded`, `runningStatus: Running`)
- [x] `infra/infra-config.md` written with actual resource information
- [x] Managed Identity has `AcrPull` on `azacr7yrfua2wocme4`
- [x] Managed Identity has `Storage Blob Data Contributor` on `azstlshxqdyfegr2y`

---

## Next Step

**Task 006 — Deploy to Azure Container Apps**  
Uses `infra/infra-config.md` to discover:
- ACR login server (`azacr7yrfua2wocme4.azurecr.io`) for Docker push
- Container App name (`azca7yrfua2wocme4`) for image update
- Managed Identity client ID (`89dc1e32-a5a1-4dcd-b41e-a94c8d172db1`) for runtime auth
