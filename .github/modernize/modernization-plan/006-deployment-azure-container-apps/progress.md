# Deployment Progress

## Task: 006-deployment-azure-container-apps

| Step | Status | Notes |
|------|--------|-------|
| Step 1 — Containerization | ✅ Complete | `WebApp-Storage-DotNet/Dockerfile` + `.dockerignore` + root `.dockerignore` created |
| Step 2 — Env Setup | ✅ Complete | az CLI 2.75.0, subscription set, serviceconnector extension installed |
| Step 3 — Provisioning | ✅ Skipped | All resources already provisioned |
| Step 4 — Check Resources | ✅ Complete | ACR ✅, ACA Env ✅, Container App ✅ (Running), MI ✅ |
| Step 5 — Deployment | ✅ Complete | Image pushed (ch3), CA updated, env var set, app Running |
| Step 6 — Summarize | ✅ Complete | `deployment-summary.md` + `modernization-summary.md` generated |

---

### Updates
- Plan created. Starting execution.
- Step 1 complete: Dockerfile generated at `WebApp-Storage-DotNet/Dockerfile` (multi-stage, .NET 10, non-root user, port 8080).
- Step 2 complete: az CLI verified, subscription `0dc80431-5546-4681-a92a-2a799ade5139` active.
- Step 4 complete: All Azure resources exist and are healthy.
- Step 5 attempt 1 (ch1): ❌ Failed — Windows-cached NuGet restore assets in `obj/` folder copied into image.
- Step 5 attempt 2 (ch2): ❌ Failed — Alpine `addgroup`/`adduser` used on Debian base image.
  - Fix: Created root `.dockerignore` to exclude `WebApp-Storage-DotNet/bin/` and `WebApp-Storage-DotNet/obj/`; updated user creation to use Debian `groupadd`/`useradd`.
- Step 5 attempt 3 (ch3): ✅ Success — Image built and pushed: `azacr7yrfua2wocme4.azurecr.io/photogallery:latest`
- Registry pull identity set (azmi7yrfua2wocme4). Container App updated. App is Running.
- Step 6 complete: Summary files written.
