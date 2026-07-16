# Compliance Report — PhotoGallery Bicep IaC

Generated against `appmod-get-iac-rules` output (deploymentTool=azcli, iacType=bicep).

---

## Rules Applied

### Deployment Tool: azcli

| Rule | Status | Implementation |
|------|--------|---------------|
| Use `.ps1` for PowerShell scripts | ✅ Applied | `deploy.ps1` |
| Use `.sh` for Bash scripts | ✅ Applied | `deploy.sh` |
| Ensure all steps executed successfully; fix and rerun on failure | ✅ Applied | Both scripts use `$ErrorActionPreference = "Stop"` / `set -euo pipefail` and exit on any error |
| Validate PowerShell syntax (brace matching, string termination) | ✅ Applied | Validated — no unterminated strings or mismatched braces |

---

### IaC Type: Bicep

| Rule | Status | Implementation |
|------|--------|---------------|
| Expected files: `main.bicep`, `main.parameters.json` | ✅ Applied | Both files generated |
| Resource token: `uniqueString(subscription().id, resourceGroup().id, location, environmentName)` | ✅ Applied | `var resourceToken = toLower(uniqueString(subscription().id, resourceGroup().id, location, environmentName))` in `main.bicep` |
| All resource names: `az{resourcePrefix}{resourceToken}` (≤3 char prefix, alphanumeric only) | ✅ Applied | `azlaw`, `azmi`, `azacr`, `azace`, `azca` prefixes used across all modules |

---

### Container Apps

| Rule | Status | Implementation |
|------|--------|---------------|
| Attach User-Assigned Managed Identity | ✅ Applied | `identity.type = 'UserAssigned'` with MI resource ID in `containerApp.bicep` |
| Add `AcrPull` role assignment (7f951dda-…) for User-Assigned MI | ✅ Applied | `acrPullRoleAssignment` in `containerRegistry.bicep` — defined BEFORE any container app module |
| Use identity (NOT system) to connect to container registry | ✅ Applied | `configuration.registries[].identity = managedIdentityId` |
| Registry connection created even with placeholder base image | ✅ Applied | `registries` block always present in container app config |
| Base image: `mcr.microsoft.com/azuredocs/containerapps-helloworld:latest` | ✅ Applied | `var placeholderImage` in `containerApp.bicep` |
| Use `properties.configuration.registries` for registry connection | ✅ Applied | `configuration.registries` block defined |
| Enable CORS via `properties.configuration.ingress.corsPolicy` | ✅ Applied | `corsPolicy` with `allowedOrigins: ['*']` in `containerApp.bicep` |
| Container App Environment connected to Log Analytics (`logAnalyticsConfiguration`) | ✅ Applied | `customerId` and `sharedKey` from Log Analytics outputs in `containerAppsEnvironment.bicep` |

---

### Storage Accounts

| Rule | Status | Implementation |
|------|--------|---------------|
| Disable local auth (key access) | ✅ N/A | Storage account is **existing** — not provisioned here. Role assignment only. |
| Disable anonymous blob access | ✅ N/A | Storage account is **existing** — not provisioned here. Role assignment only. |

---

### Additional Notes

- No Key Vault is provisioned (no application secrets to store at this infrastructure stage; Storage URI is injected as an environment variable placeholder)
- `AcrPull` role assignment is defined inside `containerRegistry.bicep` and the container app module has an explicit `dependsOn: [containerRegistry]` to guarantee ordering
- `Storage Blob Data Contributor` role assignment uses a separate module (`storageRoleAssignment.bicep`) scoped to the existing storage account
