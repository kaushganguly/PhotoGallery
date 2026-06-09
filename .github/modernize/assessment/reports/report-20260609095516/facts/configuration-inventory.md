# Configuration & Externalized Settings Inventory

The project has a compact configuration surface based on ASP.NET Web.config settings and build-time project properties. Environment-specific configuration is minimal and secrets are expected to come from external storage connection string values.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|---|---|---|---|
| Web.config | Application config | `D:\a\PhotoGallery\PhotoGallery\WebApp-Storage-DotNet\Web.config` | Primary runtime settings including `StorageConnectionString` |
| Web.Debug.config | Transform file | `D:\a\PhotoGallery\PhotoGallery\WebApp-Storage-DotNet\Web.Debug.config` | Debug transform placeholder |
| Web.Release.config | Transform file | `D:\a\PhotoGallery\PhotoGallery\WebApp-Storage-DotNet\Web.Release.config` | Release transform placeholder |
| Project file | Build config | `D:\a\PhotoGallery\PhotoGallery\WebApp-Storage-DotNet\WebApp-Storage-DotNet.csproj` | Framework target, IIS Express settings, build conditions |

## Build Profiles

| Profile | Activation | Purpose | Key Dependencies/Plugins |
|---|---|---|---|
| Debug | Default local build configuration | Debug symbols and non-optimized build | Standard project references from csproj/packages.config |
| Release | Explicit release build selection | Optimized build with pdb-only debug type | Standard project references from csproj/packages.config |

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---|---|---|---|
| Default | IIS/IIS Express application startup | Web.config | Blob storage connection string and MVC app settings |
| Debug Transform | Build/publish transform | Web.Debug.config + Web.config | Potential debug-time Web.config substitutions |
| Release Transform | Build/publish transform | Web.Release.config + Web.config | Potential release-time Web.config substitutions |

## Properties Inventory

| Property Key | Default | Profiles | Source |
|---|---|---|---|
| StorageConnectionString | `UseDevelopmentStorage=true` | Default, transformed via Web.*.config if configured | Web.config appSettings |
| webpages:Version | `3.0.0.0` | Default | Web.config appSettings |
| webpages:Enabled | `false` | Default | Web.config appSettings |
| ClientValidationEnabled | `true` | Default | Web.config appSettings |
| UnobtrusiveJavaScriptEnabled | `true` | Default | Web.config appSettings |
| compilation@debug | `true` | Default | Web.config system.web |
| compilation@targetFramework | `4.8` | Default | Web.config system.web |
| httpRuntime@targetFramework | `4.5.2` | Default | Web.config system.web |
| httpRuntime@maxRequestLength | `2100000000` | Default | Web.config system.web |
| httpRuntime@executionTimeout | `12000000` | Default | Web.config system.web |

## Startup Parameters & Resource Requirements

| Service | JVM/Runtime Options | Memory | Instance Count |
|---|---|---|---|
| WebApp-Storage-DotNet | ASP.NET on .NET Framework 4.8 under IIS/IIS Express | Not explicitly configured in repository | 1 (implicit single instance local profile) |

## Startup Dependency Chain

1. WebApp-Storage-DotNet starts under IIS/IIS Express.
2. First request to `Home/Index` initializes `BlobServiceClient` using `StorageConnectionString`.
3. Application accesses blob container and creates it if needed before listing images.

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage (masked) |
|---|---|---|
| `StorageConnectionString` | Storage account credentials or emulator connection | Web.config (`[MASKED]` in production expected) |

### Secrets Provisioning Workflow

The repository uses a placeholder local storage connection string by default. In real environments, operators are expected to replace `StorageConnectionString` with actual account credentials or equivalent secure value before deployment. No dedicated secret manager integration is declared in repository configuration files.

## Feature Flags

| Flag Name | Default | Controlled By |
|---|---|---|
| webpages:Enabled | false | Web.config appSettings |
| ClientValidationEnabled | true | Web.config appSettings |
| UnobtrusiveJavaScriptEnabled | true | Web.config appSettings |

## Framework & Runtime Versions

| Component | Version | Source |
|---|---|---|
| .NET Framework target | 4.8 | WebApp-Storage-DotNet.csproj |
| ASP.NET MVC | 5.2.3 | packages.config |
| Razor/WebPages | 3.2.3 | packages.config |
| Azure.Storage.Blobs | 12.9.1 | packages.config |
| jQuery | 1.10.2 | packages.config |
| bootstrap | 3.0.0 | packages.config |
