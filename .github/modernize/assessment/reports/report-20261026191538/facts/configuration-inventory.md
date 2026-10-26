# Configuration & Externalized Settings Inventory

The application has one primary runtime configuration file, an MSBuild project file, and a NuGet package manifest. It has Debug and Release build configurations, but no separate runtime profiles, secret store integration, or feature flag framework was detected.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|---|---|---|---|
| Web.config | Runtime XML configuration | `WebApp-Storage-DotNet/Web.config` | Application settings, compilation/runtime settings, binding redirects, and compiler provider |
| Project file | MSBuild configuration | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` | Target framework, build configurations, references, and IIS Express settings |
| NuGet manifest | Package configuration | `WebApp-Storage-DotNet/packages.config` | Package IDs, versions, and target frameworks |
| IIS Express project settings | Development server configuration | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` | Local development server configuration and URL |

## Build Profiles

| Profile | Activation | Purpose | Key Dependencies/Plugins |
|---|---|---|---|
| Debug | MSBuild `Configuration=Debug` (default) | Build with debug symbols and `DEBUG;TRACE` constants | No profile-specific packages |
| Release | MSBuild `Configuration=Release` | Optimized build with `TRACE` constant | No profile-specific packages |

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---|---|---|---|
| Default | Application configuration | `Web.config` | Storage connection, MVC/WebPages behavior, compilation target |
| Development | IIS Express project settings | Project file | Local URL and port; no separate application settings file |

No `appSettings.{Environment}.json`, Web.config transform profiles, or explicit environment-variable-based runtime profile selection were found.

## Properties Inventory

### WebApp-Storage-DotNet

| Property Key | Default | Profiles | Source |
|---|---|---|---|
| `StorageConnectionString` | `UseDevelopmentStorage=true` | Default | `Web.config` |
| `webpages:Version` | `3.0.0.0` | Default | `Web.config` |
| `webpages:Enabled` | `false` | Default | `Web.config` |
| `ClientValidationEnabled` | `true` | Default | `Web.config` |
| `UnobtrusiveJavaScriptEnabled` | `true` | Default | `Web.config` |
| `system.web/compilation@debug` | `true` | Default | `Web.config` |
| `system.web/compilation@targetFramework` | `4.8` | Default | `Web.config` |
| `system.web/httpRuntime@targetFramework` | `4.5.2` | Default | `Web.config` |
| `system.web/httpRuntime@maxRequestLength` | `2100000000` | Default | `Web.config` |
| `system.web/httpRuntime@executionTimeout` | `12000000` | Default | `Web.config` |
| IIS Express URL | `http://localhost:20050/` | Development | Project file |

Assembly binding redirects and compiler language/provider settings are also declared in `Web.config`.

## Startup Parameters & Resource Requirements

| Service | JVM/Runtime Options | Memory | Instance Count |
|---|---|---|---|
| WebApp-Storage-DotNet | .NET Framework 4.8; no JVM options found | Not specified | Not specified |
| Azure Blob Storage | External service; no application startup parameters | Not specified | Not applicable |

No container resource limits, heap settings, or application scale/instance configuration were found in the repository.

## Startup Dependency Chain

1. The web application registers MVC routes, global filters, and bundles during application startup.
2. Gallery operations rely on the configured Azure Blob Storage endpoint being reachable; no explicit startup readiness check or wait mechanism is configured.

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage (masked) |
|---|---|---|
| `StorageConnectionString` | Storage account connection string | `[MASKED/DEVELOPMENT DEFAULT]` — repository default selects local development storage; deployment documentation instructs replacing it with account credentials |

### Secrets Provisioning Workflow

No Key Vault, Vault, cloud secret manager, encrypted configuration, or automated secret provisioning integration was found. The checked-in default uses the local storage emulator. The README describes replacing this setting with an Azure account connection string for deployment; no identity/access binding or environment-variable substitution is configured in the application.

## Feature Flags

| Flag Name | Default | Controlled By |
|---|---|---|
| None detected | — | No feature-flag framework or toggle configuration found |

## Framework & Runtime Versions

| Component | Version | Source |
|---|---|---|
| .NET Framework target | 4.8 | Project file |
| ASP.NET MVC | 5.2.3 | `packages.config` |
| ASP.NET Razor | 3.2.3 | `packages.config` |
| Azure Storage Blobs | 12.9.1 | `packages.config` |
| MSBuild project format | ToolsVersion 14.0 | Project file |
| IIS Express development port | 20050 | Project file |
