# Configuration & Externalized Settings Inventory

The application uses a small set of classic ASP.NET configuration sources, with most runtime settings centralized in `Web.config` and project behavior controlled by standard Debug/Release MSBuild configurations. Secrets handling is basic and file-based by default, with the storage connection string supplied through application configuration.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|---|---|---|---|
| Web.config | ASP.NET runtime config | `WebApp-Storage-DotNet/Web.config` | Primary application settings, runtime behavior, compiler config, and assembly binding redirects |
| Web.Debug.config | Build transform | `WebApp-Storage-DotNet/Web.Debug.config` | Environment-specific transform for Debug builds |
| Web.Release.config | Build transform | `WebApp-Storage-DotNet/Web.Release.config` | Environment-specific transform for Release builds |
| Views/Web.config | Razor view config | `WebApp-Storage-DotNet/Views/Web.config` | Configures the MVC/Razor view engine environment |
| WebApp-Storage-DotNet.csproj | Build configuration | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` | Declares target framework, output paths, IIS Express settings, and package import behavior |
| packages.config | Dependency manifest | `WebApp-Storage-DotNet/packages.config` | Declares NuGet package versions used by the app |

## Build Profiles

| Profile | Activation | Purpose | Key Dependencies/Plugins |
|---|---|---|---|
| Debug | Default local build configuration | Enables full debug symbols and disables optimization | Standard ASP.NET MVC and Azure SDK dependency set |
| Release | Manual build configuration selection | Produces optimized build with pdb-only debugging | Same dependency set with optimized compilation |

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---|---|---|---|
| Default | Application startup with deployed `Web.config` | `Web.config` | Uses configured `StorageConnectionString`, MVC validation flags, and runtime settings |
| Debug transform | Build/publish selecting Debug | `Web.Debug.config` + `Web.config` | Intended to adjust runtime settings for debug publishing |
| Release transform | Build/publish selecting Release | `Web.Release.config` + `Web.config` | Intended to adjust runtime settings for release publishing |

## Properties Inventory

| Property Key | Default | Profiles | Source |
|---|---|---|---|
| StorageConnectionString | `UseDevelopmentStorage=true` | Default unless transformed | `Web.config` |
| webpages:Version | `3.0.0.0` | Default | `Web.config` |
| webpages:Enabled | `false` | Default | `Web.config` |
| ClientValidationEnabled | `true` | Default | `Web.config` |
| UnobtrusiveJavaScriptEnabled | `true` | Default | `Web.config` |
| compilation debug | `true` | Default / transformable | `Web.config` |
| compilation targetFramework | `4.8` | Default | `Web.config` |
| httpRuntime targetFramework | `4.5.2` | Default | `Web.config` |
| httpRuntime maxRequestLength | `2100000000` | Default | `Web.config` |
| httpRuntime executionTimeout | `12000000` | Default | `Web.config` |

## Startup Parameters & Resource Requirements

| Service | JVM/Runtime Options | Memory | Instance Count |
|---|---|---|---|
| WebApp-Storage-DotNet | IIS Express / ASP.NET MVC runtime; no explicit command-line runtime options detected | Not specified | Not specified |

## Startup Dependency Chain

1. `Global.asax` starts the MVC application and registers routes, filters, and bundles.
2. `HomeController.Index` reads `StorageConnectionString` on first request.
3. The application then creates or accesses the configured blob container before listing stored images.

No Docker health checks, Kubernetes probes, config server bootstrap steps, or explicit wait-for dependency mechanisms were detected.

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage (masked) |
|---|---|---|
| `StorageConnectionString` | Storage account / emulator connection string | `Web.config` (`UseDevelopmentStorage=true` in source; production value should be externalized) |

### Secrets Provisioning Workflow

The repository uses a file-based secret workflow. During development, the application reads `StorageConnectionString` directly from `Web.config`; for cloud deployment, the README instructs operators to replace the placeholder with a real storage account connection string. No Key Vault, managed identity, environment-variable injection, or deployment-time secret automation is configured in the codebase.

## Feature Flags

| Flag Name | Default | Controlled By |
|---|---|---|

No feature flags or conditional configuration toggles were detected.

## Framework & Runtime Versions

| Component | Version | Source |
|---|---:|---|
| .NET Framework target | 4.8 | `WebApp-Storage-DotNet.csproj` |
| ASP.NET MVC | 5.2.3 | `packages.config` |
| Razor / Web Pages | 3.2.3 | `packages.config` |
| Azure.Storage.Blobs | 12.9.1 | `packages.config` |
| Azure.Core | 1.18.0 | `packages.config` |
| jQuery | 1.10.2 | `packages.config` |
| Bootstrap | 3.0.0 | `packages.config` |
| Microsoft.CodeDom.Providers.DotNetCompilerPlatform | 1.0.0 | `packages.config` |
| Newtonsoft.Json | 6.0.8 | `packages.config` |
