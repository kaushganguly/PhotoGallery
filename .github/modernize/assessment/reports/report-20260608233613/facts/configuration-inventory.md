# Configuration & Externalized Settings Inventory

This application has a compact configuration surface centered on classic ASP.NET configuration files and project metadata. Most behavior is driven by a single `Web.config` file plus build settings in the legacy web application project.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|---|---|---|---|
| Web.config | Runtime configuration | `WebApp-Storage-DotNet/Web.config` | Primary app settings, ASP.NET runtime settings, assembly binding redirects, and CodeDOM compiler configuration |
| Project file | Build and hosting metadata | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` | Defines Debug/Release builds, target framework, IIS Express URL, and legacy web application targets |
| packages.config | Dependency manifest | `WebApp-Storage-DotNet/packages.config` | Declares NuGet package versions used by the application |
| README.md | Deployment guidance | `README.md` | Documents replacing the development storage connection string with a real Azure Storage account for Azure deployment |

## Build Profiles

| Profile | Activation | Purpose | Key Dependencies/Plugins |
|---|---|---|---|
| Debug | Default local build configuration | Enables symbols, full debug information, and `DEBUG;TRACE` constants | Standard project dependencies; output path `bin\` |
| Release | Explicit build configuration | Produces optimized output with `TRACE` constant | Standard project dependencies; output path `bin\` |

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---|---|---|---|
| Default | `Web.config` loaded by ASP.NET | `WebApp-Storage-DotNet/Web.config` | Uses `StorageConnectionString=UseDevelopmentStorage=true`; enables client and unobtrusive validation |
| Cloud deployment | Manual edit during deployment per README | `WebApp-Storage-DotNet/Web.config` | Replace development storage connection string with an Azure Storage account connection string |

No environment-specific transform files were found in the working tree, even though the project file references `Web.Debug.config` and `Web.Release.config`.

## Properties Inventory

| Property Key | Default | Profiles | Source |
|---|---|---|---|
| StorageConnectionString | `UseDevelopmentStorage=true` | Default; manually replaced for cloud deployment | `Web.config` appSettings |
| webpages:Version | `3.0.0.0` | Default | `Web.config` appSettings |
| webpages:Enabled | `false` | Default | `Web.config` appSettings |
| ClientValidationEnabled | `true` | Default | `Web.config` appSettings |
| UnobtrusiveJavaScriptEnabled | `true` | Default | `Web.config` appSettings |
| compilation.debug | `true` | Default | `Web.config` system.web |
| compilation.targetFramework | `4.8` | Default | `Web.config` system.web |
| httpRuntime.targetFramework | `4.5.2` | Default | `Web.config` system.web |
| httpRuntime.maxRequestLength | `2100000000` | Default | `Web.config` system.web |
| httpRuntime.executionTimeout | `12000000` | Default | `Web.config` system.web |
| IISUrl | `http://localhost:20050/` | Local development | `.csproj` web project properties |

## Startup Parameters & Resource Requirements

| Service | JVM/Runtime Options | Memory | Instance Count |
|---|---|---|---|
| WebApp-Storage-DotNet | ASP.NET runtime under IIS / IIS Express; no custom startup flags declared | Not specified | 1 local IIS Express instance implied by project settings |

## Startup Dependency Chain

1. WebApp-Storage-DotNet starts under IIS or IIS Express.
2. On the first gallery request, `HomeController.Index()` reads `StorageConnectionString` from `Web.config`.
3. The application then connects to either the local Azure Storage Emulator or Azure Blob Storage and creates the target container if it does not already exist.

No explicit readiness probes, wait scripts, startup retries, or service-to-service startup dependencies are configured in the repository.

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage (masked) |
|---|---|---|
| `StorageConnectionString` | Azure Storage connection string | `Web.config` appSettings (`UseDevelopmentStorage=true` by default; production value should be treated as `[MASKED]`) |

### Secrets Provisioning Workflow

The sample keeps its storage connection string in `Web.config` and instructs deployers to replace the development value with a real Azure Storage account connection string before publishing to Azure. No external secret store, managed identity, Key Vault integration, or automated secret injection workflow is configured in the repository.

## Feature Flags

| Flag Name | Default | Controlled By |
|---|---|---|

No feature flags or conditional configuration toggles were detected.

## Framework & Runtime Versions

| Component | Version | Source |
|---|---|---|
| .NET Framework target | 4.8 | `WebApp-Storage-DotNet.csproj` |
| ASP.NET MVC | 5.2.3 | `packages.config` |
| ASP.NET Razor / WebPages | 3.2.3 | `packages.config` |
| Azure.Storage.Blobs | 12.9.1 | `packages.config` |
| Azure.Core | 1.18.0 | `packages.config` |
| jQuery | 1.10.2 | `packages.config` |
| Bootstrap | 3.0.0 | `packages.config` |
| Modernizr | 2.6.2 | `packages.config` |
| Respond | 1.2.0 | `packages.config` |
| MSBuild project system | Legacy Visual Studio web application | `WebApp-Storage-DotNet.csproj` |
