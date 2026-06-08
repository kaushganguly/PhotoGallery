# Configuration & Externalized Settings Inventory

The project uses a small set of ASP.NET configuration sources centered on `Web.config` and build-time project settings, with one storage connection secret-like setting externalized.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|---|---|---|---|
| Web.config | Application config | `WebApp-Storage-DotNet/Web.config` | Contains appSettings, runtime binding redirects, compilation/runtime settings |
| Web.Debug.config | Transform | `WebApp-Storage-DotNet/Web.Debug.config` | Debug-time config transform scaffold |
| Web.Release.config | Transform | `WebApp-Storage-DotNet/Web.Release.config` | Release-time config transform scaffold |
| .csproj properties | Build config | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` | Build configuration and IIS Express settings |

## Build Profiles

| Profile | Activation | Purpose | Key Dependencies/Plugins |
|---|---|---|---|
| Debug | `Configuration=Debug` | Local development build with symbols | Standard MSBuild + legacy WebApplication targets |
| Release | `Configuration=Release` | Optimized release build | Standard MSBuild + legacy WebApplication targets |

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---|---|---|---|
| Default | IIS/IIS Express app startup | `Web.config` | `StorageConnectionString`, MVC validation toggles, runtime limits |

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
| WebApp-Storage-DotNet | ASP.NET runtime via IIS/IIS Express; no explicit CLI startup flags | Not declared | 1 (implicit) |

## Startup Dependency Chain

1. IIS/IIS Express starts the ASP.NET MVC application.
2. On first `Index` request, the app initializes `BlobServiceClient` from `StorageConnectionString`.
3. Blob container `webappstoragedotnet-imagecontainer` is created if missing before normal request handling continues.

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage (masked) |
|---|---|---|
| StorageConnectionString | Storage account credential/connection string | Web.config (`[MASKED OR DEV STORAGE]`) |

### Secrets Provisioning Workflow

The storage connection string is read from `Web.config` appSettings at runtime. In local development it defaults to development storage; in real deployments this value must be replaced with a real Azure Storage account connection string and managed through deployment configuration controls.

## Feature Flags

| Flag Name | Default | Controlled By |
|---|---|---|
| None detected | N/A | N/A |

## Framework & Runtime Versions

| Component | Version | Source |
|---|---|---|
| .NET Framework Target | v4.8 | `WebApp-Storage-DotNet.csproj` |
| ASP.NET MVC | 5.2.3 | `packages.config` |
| Razor/WebPages | 3.2.3 | `packages.config` |
| Azure.Storage.Blobs | 12.9.1 | `packages.config` |
| Newtonsoft.Json | 6.0.8 | `packages.config` |
