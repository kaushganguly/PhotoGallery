# Configuration & Externalized Settings Inventory

Configuration is centered on the legacy `Web.config`, with project build settings and IIS Express development settings. No runtime profiles or external secret-management integration were found; the storage setting defaults to the local emulator.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|---|---|---|---|
| Web.config | Runtime XML configuration | `WebApp-Storage-DotNet/Web.config` | App settings, compilation, HTTP runtime, assembly redirects |
| Web.Debug.config | Transform | `WebApp-Storage-DotNet/Web.Debug.config` | Debug build transform |
| Web.Release.config | Transform | `WebApp-Storage-DotNet/Web.Release.config` | Release build transform |
| Project file | Build configuration | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` | .NET Framework version and Debug/Release settings |
| packages.config | Dependency configuration | `WebApp-Storage-DotNet/packages.config` | NuGet package versions |

## Build Profiles

| Profile | Activation | Purpose | Key Dependencies/Plugins |
|---|---|---|---|
| Debug | MSBuild Configuration=Debug | Debug symbols and non-optimized build | Existing legacy project imports |
| Release | MSBuild Configuration=Release | Optimized build and PDB-only symbols | Existing legacy project imports |

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---|---|---|---|
| Default | IIS / Web.config | Web.config | Storage endpoint defaults to local development storage |
| Debug / Release transforms | Build and deployment transform | Web.Debug.config, Web.Release.config | No environment-specific values detected |

## Properties Inventory

### WebApp-Storage-DotNet

| Property Key | Default | Profiles | Source |
|---|---|---|---|
| `StorageConnectionString` | `UseDevelopmentStorage=true` | Default | Web.config appSettings |
| `webpages:Version` | `3.0.0.0` | Default | Web.config appSettings |
| `webpages:Enabled` | `false` | Default | Web.config appSettings |
| `ClientValidationEnabled` | `true` | Default | Web.config appSettings |
| `UnobtrusiveJavaScriptEnabled` | `true` | Default | Web.config appSettings |
| `system.web/compilation/@debug` | `true` | Default | Web.config |
| `system.web/compilation/@targetFramework` | `4.8` | Default | Web.config |
| `system.web/httpRuntime/@targetFramework` | `4.5.2` | Default | Web.config |
| `system.web/httpRuntime/@maxRequestLength` | `2100000000` | Default | Web.config |
| `system.web/httpRuntime/@executionTimeout` | `12000000` | Default | Web.config |

No environment-variable placeholders or property override chain was found.

## Startup Parameters & Resource Requirements

| Service | JVM/Runtime Options | Memory | Instance Count |
|---|---|---|---|
| WebApp-Storage-DotNet | No JVM options; IIS Express development port 20050 | Not specified | Not specified |

## Startup Dependency Chain

1. IIS/IIS Express hosts the MVC application.
2. The application reads `StorageConnectionString` when the gallery action initializes its blob client.
3. Azure Blob Storage must be reachable for gallery listing, upload, and delete operations. No readiness wait, health check, or retry mechanism is configured.

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage (masked) |
|---|---|---|
| `StorageConnectionString` | Storage connection setting | `UseDevelopmentStorage=true` (local emulator; no credential value present) |

### Secrets Provisioning Workflow

No Key Vault, Vault, AWS Secrets Manager, managed identity, or deployment-time secret binding is configured in the repository. The default setting targets local development storage. No production credential provisioning sequence is documented.

## Feature Flags

| Flag Name | Default | Controlled By |
|---|---|---|
| None detected | — | No feature-flag framework or conditional feature configuration found |

## Framework & Runtime Versions

| Component | Version | Source |
|---|---|---|
| .NET Framework target | 4.8 | WebApp-Storage-DotNet.csproj |
| ASP.NET MVC | 5.2.3 | packages.config |
| ASP.NET Razor / WebPages | 3.2.3 | packages.config |
| Azure.Storage.Blobs | 12.9.1 | packages.config |
| IIS Express development port | 20050 | WebApp-Storage-DotNet.csproj |
| AppCAT execution | 1.0.1127 | Installed CLI; core analysis could not load legacy web MSBuild targets |
