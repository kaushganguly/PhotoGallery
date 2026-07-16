# Modernization Summary — Task 006: Deploy to Azure Container Apps

## finalStatus
**SUCCESS**

## successCriteriaStatus

| Criterion | Status | Details |
|---|---|---|
| Dockerfile generated | ✅ Pass | `WebApp-Storage-DotNet/Dockerfile` — multi-stage, .NET 10, non-root user, port 8080 |
| Container image built & pushed to ACR | ✅ Pass | `azacr7yrfua2wocme4.azurecr.io/photogallery:latest` (ACR Run ID: ch3) |
| Container App updated with new image | ✅ Pass | `azca7yrfua2wocme4` running `photogallery:latest` |
| Managed Identity set as registry pull identity | ✅ Pass | `azmi7yrfua2wocme4` attached as ACR pull identity |
| `Storage__ServiceUri` environment variable set | ✅ Pass | `https://azstlshxqdyfegr2y.blob.core.windows.net` |
| Container App healthy (provisioningState: Succeeded) | ✅ Pass | provisioningState=Succeeded, runningStatus=Running |
| Application logs show successful startup | ✅ Pass | "Application started", "Now listening on: http://[::]:8080" |

## summary

The PhotoGallery ASP.NET Core 10 web application has been successfully deployed to Azure Container Apps.

### What was done

1. **Dockerfile created** at `WebApp-Storage-DotNet/Dockerfile` using a multi-stage build:
   - Build stage: `mcr.microsoft.com/dotnet/sdk:10.0` — restores packages and publishes in Release mode
   - Runtime stage: `mcr.microsoft.com/dotnet/aspnet:10.0` — minimal Debian-based runtime image
   - Non-root user (`appuser:appgroup`) for security hardening
   - Listens on port `8080` (ASPNETCORE_URLS=http://+:8080)

2. **Root `.dockerignore`** created to exclude `WebApp-Storage-DotNet/bin/` and `WebApp-Storage-DotNet/obj/` from the build context, preventing Windows-specific NuGet cache files from contaminating the Linux build.

3. **Container image built and pushed** via `az acr build` (remote build on ACR — no local Docker required):
   - Image: `azacr7yrfua2wocme4.azurecr.io/photogallery:latest`
   - Digest: `sha256:54e7d029392133c153a6bf91e8ea6e6fa0b723b3dc2742df4ac1c6d44950ca99`

4. **Container App updated** (`az containerapp registry set` + `az containerapp update`):
   - Registry pull identity: User-Assigned Managed Identity `azmi7yrfua2wocme4` (no registry password)
   - New image deployed: `azacr7yrfua2wocme4.azurecr.io/photogallery:latest`
   - Environment variable: `Storage__ServiceUri=https://azstlshxqdyfegr2y.blob.core.windows.net`
   - The app uses `DefaultAzureCredential` with the MI's `AZURE_CLIENT_ID` for passwordless Blob Storage access

5. **Deployment verified**: Container App is `provisioningState=Succeeded`, `runningStatus=Running`.
   Application logs confirm startup with no errors.

### App URL
**https://azca7yrfua2wocme4.wittycoast-d625364c.eastus2.azurecontainerapps.io**
