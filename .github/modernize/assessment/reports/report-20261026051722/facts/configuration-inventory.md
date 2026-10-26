# Configuration & Externalized Settings Inventory

The application has two web configuration files and one principal storage setting, with no environment-specific runtime profiles or external configuration service. Storage credentials for a deployed account are expected to be supplied by replacing the local-emulator connection string.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|---|---|---|---|
| Application settings and ASP.NET runtime | XML configuration | `WebApp-Storage-DotNet/Web.config` | Includes storage setting, compilation/runtime settings, binding redirects, and code providers |
| Razor view settings | XML configuration | `WebApp-Storage-DotNet/Views/Web.config` | Configures Razor namespaces and blocks direct view-file requests |
| Project configuration | MSBuild XML | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` | Defines target framework, references, build profiles, and IIS Express properties |
| Package declarations | NuGet XML | `WebApp-Storage-DotNet/packages.config` | Lists 34 package versions |
| Deployment guidance | Documentation | `README.md` | Instructs replacing the development storage setting with an Azure account connection string |

The project file references `Web.Debug.config` and `Web.Release.config`, but those transform files were not present in the repository. No config server, Key Vault, Vault, or cloud secret-store integration was found.

## Build Profiles

| Profile | Activation | Purpose | Key Dependencies/Plugins |
|---|---|---|---|
| Debug | MSBuild `Debug` configuration | Development build with symbols and no optimization | No profile-specific dependencies |
| Release | MSBuild `Release` configuration | Optimized build with PDB-only debug information | No profile-specific dependencies |

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---|---|---|---|
| Default | No profile selector detected | `Web.config` | Storage uses local emulator by default |
| Deployment | Manual deployment configuration | `Web.config` | README instructs replacing `StorageConnectionString` with an Azure storage account connection string |

## Properties Inventory

### WebApp-Storage-DotNet

| Property Key | Default | Profiles | Source |
|---|---|---|---|
| `StorageConnectionString` | `UseDevelopmentStorage=true` | Default; replace for deployment | `Web.config` appSettings |
| `webpages:Version` | `3.0.0.0` | All | `Web.config` appSettings |
| `webpages:Enabled` | `false` | All | `Web.config` appSettings; also set in `Views/Web.config` |
| `ClientValidationEnabled` | `true` | All | `Web.config` appSettings |
| `UnobtrusiveJavaScriptEnabled` | `true` | All | `Web.config` appSettings |
| `compilation debug` | `true` | All as checked in | `Web.config` system.web |
| `compilation targetFramework` | `4.8` | All | `Web.config` system.web |
| `httpRuntime targetFramework` | `4.5.2` | All | `Web.config` system.web |
| `httpRuntime maxRequestLength` | `2100000000` | All | `Web.config` system.web |
| `httpRuntime executionTimeout` | `12000000` | All | `Web.config` system.web |

## Startup Parameters & Resource Requirements

| Service | JVM/Runtime Options | Memory | Instance Count |
|---|---|---|---|
| WebApp-Storage-DotNet | .NET Framework 4.8 hosted by IIS/IIS Express | Not specified | Not specified |
| Azure Blob Storage | Azure-managed service | Azure-managed | Azure-managed |

## Startup Dependency Chain

1. IIS or IIS Express starts the ASP.NET application.
2. `Application_Start` registers MVC areas, global filters, routes, and bundles.
3. The first gallery request constructs the Azure storage client and creates the container if needed.

No health-check readiness gate, explicit startup wait, or dependency timeout is configured.

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage (masked) |
|---|---|---|
| `StorageConnectionString` | Storage account connection string | Development emulator value in source; deployment account credentials are expected to replace it. No real secret is included here. |

### Secrets Provisioning Workflow

The repository uses the local storage emulator by default. `README.md` directs operators to replace `StorageConnectionString` with the Azure Storage account connection string when deploying. No managed identity, dedicated secret store, encryption workflow, or automated secret provisioning mechanism is configured.

## Feature Flags

| Flag Name | Default | Controlled By |
|---|---|---|
| None detected | — | No feature-flag framework or toggle configuration was found |

## Framework & Runtime Versions

| Component | Version | Source |
|---|---|---|
| .NET Framework target | 4.8 | `WebApp-Storage-DotNet.csproj` |
| ASP.NET MVC | 5.2.3 | `packages.config` |
| Razor / WebPages | 3.2.3 | `packages.config` |
| Azure.Storage.Blobs | 12.9.1 | `packages.config` |
| Azure.Core | 1.18.0 | `packages.config` |
| Build configurations | Debug, Release | `WebApp-Storage-DotNet.csproj` and solution |
| Hosting | IIS / IIS Express | Project settings and README |
