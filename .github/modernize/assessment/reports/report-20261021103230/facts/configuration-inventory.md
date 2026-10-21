# Configuration & Externalized Settings Inventory

Configuration is defined primarily in the web application's `Web.config`, with project and NuGet metadata controlling compilation and dependency resolution. No environment-specific runtime profiles or external secret-provider integration were found.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|---|---|---|---|
| Application configuration | ASP.NET configuration | `WebApp-Storage-DotNet/Web.config` | Defines application settings, framework compilation/runtime settings, assembly redirects, and compiler providers |
| View configuration | ASP.NET MVC view configuration | `WebApp-Storage-DotNet/Views/Web.config` | View-specific configuration |
| Project file | MSBuild project | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` | Target framework, build configurations, IIS Express settings, and dependencies |
| NuGet manifest | Package configuration | `WebApp-Storage-DotNet/packages.config` | Declared package versions |
| Solution | Visual Studio solution | `WebApp-Storage-DotNet.sln` | Contains the application project |

## Build Profiles

| Profile | Activation | Purpose | Key Dependencies/Plugins |
|---|---|---|---|
| Debug | MSBuild `Debug` configuration | Development build with debug symbols and `DEBUG;TRACE` compilation symbols | No profile-specific dependencies |
| Release | MSBuild `Release` configuration | Optimized build with `TRACE` compilation symbol | No profile-specific dependencies |

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---|---|---|---|
| Default | No environment-specific activation detected | `Web.config` | Single configuration applies to the application |

No `Web.{Environment}.config` runtime profile is defined beyond the standard Web.Debug.config and Web.Release.config transformation files.

## Properties Inventory

### WebApp-Storage-DotNet

| Property Key | Default | Profiles | Source |
|---|---|---|---|
| `StorageConnectionString` | `UseDevelopmentStorage=true` | Default | `WebApp-Storage-DotNet/Web.config` |
| `webpages:Version` | `3.0.0.0` | Default | `WebApp-Storage-DotNet/Web.config` |
| `webpages:Enabled` | `false` | Default | `WebApp-Storage-DotNet/Web.config` |
| `ClientValidationEnabled` | `true` | Default | `WebApp-Storage-DotNet/Web.config` |
| `UnobtrusiveJavaScriptEnabled` | `true` | Default | `WebApp-Storage-DotNet/Web.config` |
| ASP.NET compilation target | .NET Framework `4.8` | Default | `WebApp-Storage-DotNet/Web.config` |
| ASP.NET HTTP runtime target | .NET Framework `4.5.2` | Default | `WebApp-Storage-DotNet/Web.config` |
| Maximum request length | `2100000000` KB | Default | `WebApp-Storage-DotNet/Web.config` |
| Request execution timeout | `12000000` seconds | Default | `WebApp-Storage-DotNet/Web.config` |

No environment-variable placeholders or external configuration references were found.

## Startup Parameters & Resource Requirements

| Service | JVM/Runtime Options | Memory | Instance Count |
|---|---|---|---|
| WebApp-Storage-DotNet | No JVM settings or explicit runtime launch parameters found; project enables IIS Express for local development | Not specified | Not specified |

The project configures local IIS Express to use port 20050. No CPU or memory allocations are specified.

## Startup Dependency Chain

1. The ASP.NET application starts and registers routes, global filters, and bundles.
2. A storage connection is established when a gallery action accesses Azure Blob Storage; no separate service startup dependency or readiness wait mechanism is configured.

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage (masked) |
|---|---|---|
| `StorageConnectionString` | Storage connection string | Checked-in value is `UseDevelopmentStorage=true` (local emulator; no account credential present) |

### Secrets Provisioning Workflow

No Key Vault, Vault, environment-variable secret injection, or other provisioning workflow is configured in the inspected repository. Production storage credentials would need to be supplied through an external deployment configuration mechanism; no identity/access model or binding is defined here.

## Feature Flags

| Flag Name | Default | Controlled By |
|---|---|---|
| None detected | — | No feature-flag framework or application feature toggles found |

## Framework & Runtime Versions

| Component | Version | Source |
|---|---|---|
| .NET Framework target | 4.8 | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` |
| ASP.NET MVC | 5.2.3 | `WebApp-Storage-DotNet/packages.config` |
| ASP.NET Razor | 3.2.3 | `WebApp-Storage-DotNet/packages.config` |
| Azure.Storage.Blobs | 12.9.1 | `WebApp-Storage-DotNet/packages.config` |
| MSBuild project tools version | 14.0 | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` |
