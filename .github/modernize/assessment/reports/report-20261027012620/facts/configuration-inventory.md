# Configuration & Externalized Settings Inventory

The configuration landscape is small: one ASP.NET `Web.config`, one legacy project file, and one NuGet package manifest. No environment-specific settings files, external configuration service, or secret store integration were identified.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|---|---|---|---|
| Web.config | Application configuration | `WebApp-Storage-DotNet/Web.config` | App settings, ASP.NET runtime limits, compiler and binding redirects |
| Project file | Build configuration | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` | Legacy MSBuild project targeting .NET Framework 4.8 |
| NuGet packages | Dependency configuration | `WebApp-Storage-DotNet/packages.config` | Declared package versions |
| Solution | Solution configuration | `WebApp-Storage-DotNet.sln` | Contains one web project |

## Build Profiles

| Profile | Activation | Purpose | Key Dependencies/Plugins |
|---|---|---|---|
| Debug | MSBuild configuration | Development build; debug symbols enabled | CodeDom compiler provider |
| Release | MSBuild configuration | Release build | Same project dependencies |

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---|---|---|---|
| Default | No environment-specific activation found | `Web.config` | Uses local development storage emulator |

## Properties Inventory

### WebApp-Storage-DotNet

| Property Key | Default | Profiles | Source |
|---|---|---|---|
| `StorageConnectionString` | `UseDevelopmentStorage=true` | Default | `Web.config` |
| `webpages:Version` | `3.0.0.0` | Default | `Web.config` |
| `webpages:Enabled` | `false` | Default | `Web.config` |
| `ClientValidationEnabled` | `true` | Default | `Web.config` |
| `UnobtrusiveJavaScriptEnabled` | `true` | Default | `Web.config` |
| `compilation.debug` | `true` | Default | `Web.config` |
| `compilation.targetFramework` | `4.8` | Default | `Web.config` |
| `httpRuntime.targetFramework` | `4.5.2` | Default | `Web.config` |
| `httpRuntime.maxRequestLength` | `2100000000` | Default | `Web.config` |
| `httpRuntime.executionTimeout` | `12000000` seconds | Default | `Web.config` |

## Startup Parameters & Resource Requirements

| Service | JVM/Runtime Options | Memory | Instance Count |
|---|---|---|---|
| WebApp-Storage-DotNet | ASP.NET runtime target 4.5.2 in `httpRuntime`; no explicit startup flags | Not specified | Not specified |

## Startup Dependency Chain

1. ASP.NET initializes the web application and MVC routes.
2. The first gallery request creates/gets the blob container and creates it if missing.
3. Upload and delete actions depend on the controller's static blob container being initialized by a previous gallery request.

No health checks, readiness probes, or explicit external-service startup wait configuration were found.

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage (masked) |
|---|---|---|
| `StorageConnectionString` | Storage connection string | `UseDevelopmentStorage=true`; no production credential is present in the checked-in setting |

### Secrets Provisioning Workflow

No managed identity, Key Vault, vault, cloud secret manager, or deployment-time provisioning workflow was identified. The current checked-in value selects local development storage; the configuration comment tells developers to insert a storage account name and key for a real account.

## Feature Flags

| Flag Name | Default | Controlled By |
|---|---|---|
| None identified | — | No feature-flag framework or toggle configuration found |

## Framework & Runtime Versions

| Component | Version | Source |
|---|---|---|
| .NET Framework target | 4.8 | `WebApp-Storage-DotNet.csproj` |
| ASP.NET MVC | 5.2.3 | `packages.config` |
| ASP.NET Razor | 3.2.3 | `packages.config` |
| Azure.Storage.Blobs | 12.9.1 | `packages.config` |
| MSBuild project format | Legacy ToolsVersion 14.0 | `WebApp-Storage-DotNet.csproj` |
