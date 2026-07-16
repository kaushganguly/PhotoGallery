# Configuration & Externalized Settings Inventory

This project uses a compact configuration model centered on `Web.config` and classic ASP.NET build/runtime settings. Configuration externalization is limited to app settings and environment-specific transform files.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|---|---|---|---|
| Web.config | Runtime app config | `WebApp-Storage-DotNet/Web.config` | Contains app settings, runtime, binding redirects |
| Web.Debug.config | Transform profile | `WebApp-Storage-DotNet/Web.Debug.config` | Debug transform for local/dev builds |
| Web.Release.config | Transform profile | `WebApp-Storage-DotNet/Web.Release.config` | Release transform for deployment |
| project file | Build config | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` | Debug/Release build properties and IIS Express settings |

## Build Profiles

| Profile | Activation | Purpose | Key Dependencies/Plugins |
|---|---|---|---|
| Debug | Default/local build | Development build with symbols | Standard ASP.NET MVC dependencies |
| Release | Manual/CI build selection | Optimized build | Standard ASP.NET MVC dependencies |

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---|---|---|---|
| Default | IIS/IIS Express startup | Web.config | Storage connection string and runtime options |
| Debug transform | Build transform | Web.Debug.config + Web.config | Debug-specific web.config substitutions |
| Release transform | Build transform | Web.Release.config + Web.config | Release-specific web.config substitutions |

## Properties Inventory

| Property Key | Default | Profiles | Source |
|---|---|---|---|
| StorageConnectionString | `UseDevelopmentStorage=true` | Default | Web.config appSettings |
| webpages:Version | `3.0.0.0` | Default | Web.config appSettings |
| webpages:Enabled | `false` | Default | Web.config appSettings |
| ClientValidationEnabled | `true` | Default | Web.config appSettings |
| UnobtrusiveJavaScriptEnabled | `true` | Default | Web.config appSettings |

## Startup Parameters & Resource Requirements

| Service | JVM/Runtime Options | Memory | Instance Count |
|---|---|---|---|
| WebApp-Storage-DotNet | .NET Framework app under IIS/IIS Express; no explicit startup flags | Not specified in repo | 1 (assumed single instance) |

## Startup Dependency Chain

1. Web application starts in IIS/IIS Express.
2. On first request, controller initializes BlobServiceClient using `StorageConnectionString`.
3. Blob container is created or opened before listing and serving images.

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage (masked) |
|---|---|---|
| `StorageConnectionString` | Storage connection string | Web.config (`UseDevelopmentStorage=true` in sample) |

### Secrets Provisioning Workflow

Secrets are expected to be provided through deployment-time configuration updates to `Web.config` (or transforms) before runtime. The sample value points to local development storage; production deployments should replace this with secure secret management outside source control.

## Feature Flags

| Flag Name | Default | Controlled By |
|---|---|---|
| None detected | N/A | N/A |

## Framework & Runtime Versions

| Component | Version | Source |
|---|---|---|
| .NET Framework target | 4.8 | WebApp-Storage-DotNet.csproj |
| ASP.NET MVC | 5.2.3 | packages.config |
| Azure.Storage.Blobs | 12.9.1 | packages.config |
| Azure.Core | 1.18.0 | packages.config |
| Newtonsoft.Json | 6.0.8 | packages.config |
