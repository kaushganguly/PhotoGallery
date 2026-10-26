# Configuration & Externalized Settings Inventory

Configuration is held in the legacy project file and a single `Web.config`; no environment-specific configuration profiles or external secret-store integration were found. The checked-in storage setting points to the local development emulator.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|---|---|---|---|
| Web.config | Runtime configuration | `WebApp-Storage-DotNet/Web.config` | App settings, ASP.NET compilation/runtime settings, assembly redirects, and CodeDOM compiler setup |
| Project file | Build and hosting configuration | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` | Target framework, Debug/Release settings, IIS Express development host |
| NuGet package manifest | Dependency configuration | `WebApp-Storage-DotNet/packages.config` | Declared package versions |
| Solution file | Solution configuration | `WebApp-Storage-DotNet.sln` | Contains one web project |
| README | Deployment guidance | `README.md` | Documents replacing the local storage connection with an Azure storage connection string |

## Build Profiles

| Profile | Activation | Purpose | Key Dependencies/Plugins |
|---|---|---|---|
| Debug | MSBuild `Debug` configuration | Debug symbols, no optimization, `DEBUG;TRACE` symbols | Legacy ASP.NET web application targets |
| Release | MSBuild `Release` configuration | Optimized build, PDB-only symbols, `TRACE` symbol | Legacy ASP.NET web application targets |

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---|---|---|---|
| Default | No application-specific environment activation found | `WebApp-Storage-DotNet/Web.config` | Local development storage emulator is the checked-in default |
| IIS Express development | Project launch configuration | `.csproj` | Local development port 20050 |
| Production deployment | Manually configure Azure Web Apps | `Web.config` and deployment settings described in README | Replace storage setting with a real storage account connection string; no profile-specific file is present |

## Properties Inventory

| Property Key | Default | Profiles | Source |
|---|---|---|---|
| `StorageConnectionString` | `UseDevelopmentStorage=true` | Default; replace for cloud deployment | `Web.config` appSettings |
| `webpages:Version` | `3.0.0.0` | Default | `Web.config` appSettings |
| `webpages:Enabled` | `false` | Default | `Web.config` appSettings |
| `ClientValidationEnabled` | `true` | Default | `Web.config` appSettings |
| `UnobtrusiveJavaScriptEnabled` | `true` | Default | `Web.config` appSettings |
| `compilation debug` | `true` | Default runtime configuration | `Web.config` system.web |
| `compilation targetFramework` | `4.8` | Default runtime configuration | `Web.config` system.web |
| `httpRuntime targetFramework` | `4.5.2` | Default runtime configuration | `Web.config` system.web |
| `httpRuntime maxRequestLength` | `2100000000` | Default runtime configuration | `Web.config` system.web |
| `httpRuntime executionTimeout` | `12000000` | Default runtime configuration | `Web.config` system.web |
| `IISExpress DevelopmentServerPort` | `20050` | Local development | `.csproj` project extensions |

## Startup Parameters & Resource Requirements

| Service | JVM/Runtime Options | Memory | Instance Count |
|---|---|---|---|
| WebApp-Storage-DotNet | ASP.NET on .NET Framework 4.8; no JVM settings | Not specified | Not specified |

No CPU, memory, instance-count, container, or process startup resource limits were found.

## Startup Dependency Chain

1. ASP.NET application startup registers MVC areas, global filters, routes, and bundles.
2. There is no storage readiness probe or startup wait configuration. Blob Storage is accessed when a gallery or storage action runs; the request depends on the configured endpoint being available.

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage (masked) |
|---|---|---|
| Storage account connection string | Storage credential in production deployment | No credential is committed; configuration defaults to local emulator. README instructs operators to supply an account connection string. |

### Secrets Provisioning Workflow

The repository does not define an automated secret-provisioning workflow, managed identity, Key Vault reference, or CI secret binding. The README describes manually replacing the storage connection string for deployment. No actual storage account key or password is present in the checked-in configuration.

## Feature Flags

| Flag Name | Default | Controlled By |
|---|---|---|
| None detected | — | No feature-flag framework or conditional runtime toggle was found. |

## Framework & Runtime Versions

| Component | Version | Source |
|---|---|---|
| .NET Framework target | 4.8 | `.csproj` |
| ASP.NET MVC | 5.2.3 | `packages.config` |
| Azure.Storage.Blobs | 12.9.1 | `packages.config` |
| Azure.Core | 1.18.0 | `packages.config` |
| Bootstrap | 3.0.0 | `packages.config` |
| jQuery | 1.10.2 | `packages.config` |
| MSBuild project format | Legacy non-SDK project | `.csproj` and `.sln` |
