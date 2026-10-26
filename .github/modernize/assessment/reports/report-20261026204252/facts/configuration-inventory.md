# Configuration & Externalized Settings Inventory

The configuration landscape consists primarily of `Web.config`, project-level build properties, and the MVC route setup. One storage connection string is externalizable, and the checked-in setting points to the local development emulator.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|---|---|---|---|
| Web.config | Runtime configuration | `WebApp-Storage-DotNet/Web.config` | App settings, runtime, compilation, and binding redirects |
| Project file | Build and host settings | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` | .NET Framework version, Debug/Release configuration, IIS Express |
| RouteConfig | Application routing | `WebApp-Storage-DotNet/App_Start/RouteConfig.cs` | Default MVC route |
| packages.config | Dependency configuration | `WebApp-Storage-DotNet/packages.config` | Fixed NuGet package versions |

No environment-specific Web.config transforms, launch settings, container manifests, external config service, or secret-store integration were identified.

## Build Profiles

| Profile | Activation | Purpose | Key Dependencies/Plugins |
|---|---|---|---|
| Debug | MSBuild `Debug` configuration | Debug symbols and unoptimized build | Defines `DEBUG;TRACE` |
| Release | MSBuild `Release` configuration | Optimized release build | Defines `TRACE` |

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---|---|---|---|
| Default | No named environment profile | `Web.config` | Uses local development storage as the checked-in connection setting |
| Deployment | External replacement of the storage setting | `Web.config` or deployment-provided app setting | README describes replacing the placeholder/local value with an Azure Storage connection string |

## Properties Inventory

### WebApp-Storage-DotNet

| Property Key | Default | Profiles | Source |
|---|---|---|---|
| `StorageConnectionString` | Local development storage | Default; deployment may override | `Web.config` appSettings |
| `webpages:Version` | `3.0.0.0` | All | `Web.config` |
| `webpages:Enabled` | `false` | All | `Web.config` |
| `ClientValidationEnabled` | `true` | All | `Web.config` |
| `UnobtrusiveJavaScriptEnabled` | `true` | All | `Web.config` |
| `compilation debug` | `true` | All | `Web.config` |
| `compilation targetFramework` | `4.8` | All | `Web.config` |
| `httpRuntime targetFramework` | `4.5.2` | All | `Web.config` |
| `httpRuntime maxRequestLength` | `2100000000` KB | All | `Web.config` |
| `httpRuntime executionTimeout` | `12000000` seconds | All | `Web.config` |

The project file targets .NET Framework 4.8. Assembly binding redirects are also present for MVC, Newtonsoft.Json, and supporting runtime assemblies.

## Startup Parameters & Resource Requirements

| Service | JVM/Runtime Options | Memory | Instance Count |
|---|---|---|---|
| WebApp-Storage-DotNet | IIS/IIS Express-hosted ASP.NET application; no JVM options | Not specified | Not specified |

No container CPU or memory limits or deployment instance counts are included in the repository. Web.config specifies a high request-size ceiling and long execution timeout; effective limits also depend on IIS and deployment configuration.

## Startup Dependency Chain

1. ASP.NET application startup registers areas, global filters, MVC routes, and bundles.
2. The gallery action initializes the blob container client and attempts to create the container if absent.
3. Listing, uploading, and deletion require the configured Azure Storage endpoint or local emulator to be reachable; no startup readiness check or retry configuration is present.

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage (masked) |
|---|---|---|
| `StorageConnectionString` | Storage connection string | Checked-in value references local development storage; production credentials are expected to be supplied during deployment and are not present in the repository. |

### Secrets Provisioning Workflow

No managed identity, Key Vault, Vault, encrypted config, or automated secret provisioning workflow was found. The README instructs operators to provide an Azure storage account connection string for deployment. The checked-in development setting does not contain an account key.

## Feature Flags

| Flag Name | Default | Controlled By |
|---|---|---|
| None detected | — | No feature-flag framework or conditional application feature settings found |

## Framework & Runtime Versions

| Component | Version | Source |
|---|---|---|
| .NET Framework target | 4.8 | `WebApp-Storage-DotNet.csproj` |
| ASP.NET MVC | 5.2.3 | `packages.config` |
| Razor / WebPages | 3.2.3 | `packages.config` |
| Azure Storage Blobs | 12.9.1 | `packages.config` |
| Azure Storage Common | 12.8.0 | `packages.config` |
| IIS Express local port | 20050 | `WebApp-Storage-DotNet.csproj` |
| MSBuild configurations | Debug, Release | `WebApp-Storage-DotNet.csproj` |
