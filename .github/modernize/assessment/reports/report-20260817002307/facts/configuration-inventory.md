# Configuration & Externalized Settings Inventory

This project uses a compact configuration model with primary settings in `Web.config`, plus build/package metadata in project and package files. Externalized secrets are expected through the storage connection string value used by the MVC app.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|---|---|---|---|
| Web.config | XML application/runtime config | `WebApp-Storage-DotNet/Web.config` | Main app settings, runtime/binding redirects, compilation/runtime settings |
| Web.Debug.config | XML transform | `WebApp-Storage-DotNet/Web.Debug.config` | Debug transform overrides |
| Web.Release.config | XML transform | `WebApp-Storage-DotNet/Web.Release.config` | Release transform overrides |
| Project file | MSBuild config | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` | Build properties, framework target, references |
| packages.config | NuGet dependency manifest | `WebApp-Storage-DotNet/packages.config` | Declared package versions |

## Build Profiles

| Profile | Activation | Purpose | Key Dependencies/Plugins |
|---|---|---|---|
| Debug | Build configuration selection | Local development build | `<compilation debug="true">`, Debug constants |
| Release | Build configuration selection | Optimized deployment build | Optimized output, Release constants |

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---|---|---|---|
| Default | ASP.NET runtime startup | `Web.config` | Uses configured storage connection string and MVC settings |
| Debug transform | Build/publish transform | `Web.Debug.config` + `Web.config` | Environment-specific transform behavior |
| Release transform | Build/publish transform | `Web.Release.config` + `Web.config` | Environment-specific transform behavior |

## Properties Inventory

| Property Key | Default | Profiles | Source |
|---|---|---|---|
| StorageConnectionString | `UseDevelopmentStorage=true` | Default (overridable by transform/deployment) | `Web.config` appSettings |
| webpages:Version | `3.0.0.0` | Default | `Web.config` appSettings |
| webpages:Enabled | `false` | Default | `Web.config` appSettings |
| ClientValidationEnabled | `true` | Default | `Web.config` appSettings |
| UnobtrusiveJavaScriptEnabled | `true` | Default | `Web.config` appSettings |
| system.web compilation debug | `true` | Debug baseline shown | `Web.config` |
| system.web httpRuntime targetFramework | `4.5.2` | Default | `Web.config` |
| system.web httpRuntime maxRequestLength | `2100000000` | Default | `Web.config` |
| system.web httpRuntime executionTimeout | `12000000` | Default | `Web.config` |

## Startup Parameters & Resource Requirements

| Service | JVM/Runtime Options | Memory | Instance Count |
|---|---|---|---|
| WebApp-Storage-DotNet | ASP.NET .NET Framework runtime under IIS/IIS Express | Not explicitly configured in repository | Not explicitly configured in repository |

## Startup Dependency Chain

1. Web host (IIS/IIS Express) starts the ASP.NET MVC application.
2. `Application_Start` registers routes, filters, and bundles.
3. On first request to `Home/Index`, the app initializes and verifies the blob container using configured storage connection.

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage (masked) |
|---|---|---|
| `StorageConnectionString` | Storage account connection string | `Web.config` appSetting (`[MASKED]`) |

### Secrets Provisioning Workflow

The application reads `StorageConnectionString` from configuration at runtime via `ConfigurationManager.AppSettings`. In local development it defaults to storage emulator format; in deployment the value is expected to be replaced with an environment-specific secure connection string. No in-repository key vault integration or managed identity binding configuration was found.

## Feature Flags

| Flag Name | Default | Controlled By |
|---|---|---|
| No explicit feature flag framework detected | N/A | N/A |

## Framework & Runtime Versions

| Component | Version | Source |
|---|---|---|
| .NET Framework target | v4.8 | `WebApp-Storage-DotNet.csproj` |
| ASP.NET MVC | 5.2.3 | `packages.config` |
| Razor/WebPages | 3.2.3 | `packages.config` |
| Azure.Storage.Blobs | 12.9.1 | `packages.config` |
| Azure.Core | 1.18.0 | `packages.config` |
| Newtonsoft.Json | 6.0.8 | `packages.config` |
| jQuery | 1.10.2 | `packages.config` |
| bootstrap | 3.0.0 | `packages.config` |
