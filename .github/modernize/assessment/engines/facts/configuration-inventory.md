# Configuration & Externalized Settings Inventory

Configuration is primarily stored in the ASP.NET `Web.config` and legacy project files. The checked-in storage setting points to a development emulator; no profile system or secret-store integration is configured.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|---|---|---|---|
| Web application settings | XML runtime configuration | `WebApp-Storage-DotNet/Web.config` | Contains storage connection setting, MVC settings, runtime limits, and binding redirects |
| Web transforms | XML environment/build transforms | `WebApp-Storage-DotNet/Web.Debug.config`, `WebApp-Storage-DotNet/Web.Release.config` | Present as standard transform files; no separate runtime profile files identified |
| Project manifest | MSBuild project | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` | Legacy project format; targets .NET Framework 4.8 |
| NuGet manifest | NuGet package configuration | `WebApp-Storage-DotNet/packages.config` | Lists explicit package versions |
| Solution | Visual Studio solution | `WebApp-Storage-DotNet.sln` | Contains one web project |
| MVC startup configuration | C# configuration | `App_Start/` and `Global.asax.cs` | Registers routes, global error filter, and asset bundles |

No external configuration repository, Azure App Configuration, Key Vault, Vault, or other secret store was found.

## Build Profiles

| Profile | Activation | Purpose | Key Dependencies/Plugins |
|---|---|---|---|
| Debug | Build configuration `Debug` | Development build with debug symbols and no optimization | Existing legacy MSBuild project |
| Release | Build configuration `Release` | Optimized release build with PDB-only symbols | Existing legacy MSBuild project |

The project file enables `DEBUG;TRACE` only for Debug and `TRACE` for Release.

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---|---|---|---|
| Default | ASP.NET host configuration | `Web.config` | `StorageConnectionString` selects development storage |
| Debug/Release transforms | Build/deployment transform | `Web.Debug.config`, `Web.Release.config` | No additional values established from the project files |

No `ASPNETCORE_ENVIRONMENT` or application-specific runtime profile mechanism is configured.

## Properties Inventory

### WebApp-Storage-DotNet

| Property Key | Default | Profiles | Source |
|---|---|---|---|
| `StorageConnectionString` | `UseDevelopmentStorage=true` | Default | `Web.config` |
| `webpages:Version` | `3.0.0.0` | Default | `Web.config` |
| `webpages:Enabled` | `false` | Default | `Web.config` |
| `ClientValidationEnabled` | `true` | Default | `Web.config` |
| `UnobtrusiveJavaScriptEnabled` | `true` | Default | `Web.config` |
| `system.web/compilation/@debug` | `true` | Default | `Web.config` |
| `system.web/compilation/@targetFramework` | `4.8` | Default | `Web.config` |
| `system.web/httpRuntime/@targetFramework` | `4.5.2` | Default | `Web.config` |
| `system.web/httpRuntime/@maxRequestLength` | `2100000000` | Default | `Web.config` |
| `system.web/httpRuntime/@executionTimeout` | `12000000` | Default | `Web.config` |

The project itself declares target framework version `v4.8`; the runtime `httpRuntime` target framework attribute is separately set to `4.5.2`.

## Startup Parameters & Resource Requirements

| Service | JVM/Runtime Options | Memory | Instance Count |
|---|---|---|---|
| WebApp-Storage-DotNet | No explicit runtime command-line options found | Not specified | Not specified |

No CPU or container resource limits are declared.

## Startup Dependency Chain

1. ASP.NET invokes `MvcApplication.Application_Start`.
2. The application registers routes, global error handling, and script/style bundles.
3. The first gallery request creates a Blob Storage client, gets the configured container, and creates the container if missing.
4. No explicit readiness probe or dependency-wait mechanism is configured.

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage (masked) |
|---|---|---|
| `StorageConnectionString` | Storage connection string | Development-emulator value is checked in; no account key or production credential is included |

### Secrets Provisioning Workflow

No production secret provisioning workflow, managed identity, or secret-store binding is present in the repository. A deployed environment must provide a real storage connection string through its hosting configuration; no actual credential value is documented here.

## Feature Flags

| Flag Name | Default | Controlled By |
|---|---|---|
| None detected | — | No feature-flag framework or conditional feature configuration found |

## Framework & Runtime Versions

| Component | Version | Source |
|---|---|---|
| .NET Framework target | 4.8 | `WebApp-Storage-DotNet.csproj` |
| ASP.NET MVC | 5.2.3 | `packages.config` |
| Razor / ASP.NET WebPages | 3.2.3 | `packages.config` |
| Azure Storage Blobs SDK | 12.9.1 | `packages.config` |
| Azure.Core | 1.18.0 | `packages.config` |
| jQuery | 1.10.2 | `packages.config` |
| Bootstrap | 3.0.0 | `packages.config` |
| NuGet package format | `packages.config` | Project configuration |
| Visual Studio solution format | Visual Studio 14.0 | `.sln` file |
