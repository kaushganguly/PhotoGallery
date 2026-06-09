# Configuration & Externalized Settings Inventory

The repository uses a small set of configuration sources centered on classic ASP.NET `Web.config` and project-level IIS Express settings. There are no environment-specific config files committed, no remote config provider, and only one clearly sensitive setting: the storage connection string.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|---|---|---|---|
| Primary app settings | XML config | `WebApp-Storage-DotNet/Web.config` | Holds storage connection string, MVC settings, runtime limits, binding redirects, and compiler provider config |
| MVC view settings | XML config | `WebApp-Storage-DotNet/Views/Web.config` | Controls Razor view compilation behavior |
| Project hosting metadata | MSBuild project file | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` | Stores IIS Express URL/port and build configuration defaults |
| Repository runbook | Markdown | `README.md` | Documents local emulator setup and manual cloud connection string replacement |

## Build Profiles

| Profile | Activation | Purpose | Key Dependencies/Plugins |
|---|---|---|---|
| Debug | Default local build configuration | Enables debug symbols and disables optimization | Uses the classic web application project system and CodeDom compiler provider |
| Release | Explicit `Release|AnyCPU` build | Produces optimized output with PDB-only debug info | Same dependency set as Debug, optimized compilation enabled |

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---|---|---|---|
| Default / local | `Web.config` checked into source | `Web.config` | `StorageConnectionString=UseDevelopmentStorage=true` for local emulator usage |
| Cloud deployment | Manual edit before publish, per README | `Web.config` | Replace `StorageConnectionString` with a real Azure Storage account connection string |

## Properties Inventory

| Property Key | Default | Profiles | Source |
|---|---|---|---|
| `StorageConnectionString` | `UseDevelopmentStorage=true` | Default/local, cloud override | `Web.config` |
| `webpages:Version` | `3.0.0.0` | Default | `Web.config` |
| `webpages:Enabled` | `false` | Default | `Web.config` |
| `ClientValidationEnabled` | `true` | Default | `Web.config` |
| `UnobtrusiveJavaScriptEnabled` | `true` | Default | `Web.config` |
| `system.web/compilation@debug` | `true` | Default | `Web.config` |
| `system.web/compilation@targetFramework` | `4.8` | Default | `Web.config` |
| `system.web/httpRuntime@targetFramework` | `4.5.2` | Default | `Web.config` |
| `system.web/httpRuntime@maxRequestLength` | `2100000000` | Default | `Web.config` |
| `system.web/httpRuntime@executionTimeout` | `12000000` | Default | `Web.config` |
| `IISUrl` | `http://localhost:20050/` | Local development | `WebApp-Storage-DotNet.csproj` |

## Startup Parameters & Resource Requirements

| Service | JVM/Runtime Options | Memory | Instance Count |
|---|---|---|---|
| WebApp-Storage-DotNet | No explicit startup flags or environment variables defined in source | Not specified | 1 in local IIS Express development |

## Startup Dependency Chain

1. `MvcApplication.Application_Start` registers routes, filters, and bundles before the first request is served.
2. The application expects Azure Storage availability before gallery actions can succeed.
3. For local execution, the README requires the Azure Storage emulator to be started before running the web app.
4. For cloud execution, the storage account connection string must be provisioned before the app is published.

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage (masked) |
|---|---|---|
| `StorageConnectionString` | Azure Storage account connection string | `Web.config` value masked; defaults locally to emulator connection |

### Secrets Provisioning Workflow

The application reads its storage credential from `Web.config`. In local development, the workflow is simple: start the Azure Storage emulator and use the built-in `UseDevelopmentStorage=true` value. For cloud deployment, the README instructs the operator to retrieve a real storage account key from Azure and manually replace the connection string before publishing; no Key Vault, configuration builder, managed identity, or secret rotation workflow is defined in the repository.

## Feature Flags

| Flag Name | Default | Controlled By |
|---|---|---|
| None detected | - | No feature flag framework or conditional application feature toggle is configured |

## Framework & Runtime Versions

| Component | Version | Source |
|---|---:|---|
| .NET Framework target | 4.8 | `WebApp-Storage-DotNet.csproj` |
| ASP.NET MVC | 5.2.3 | `packages.config` |
| Razor / WebPages | 3.2.3 | `packages.config` |
| Azure.Storage.Blobs | 12.9.1 | `packages.config` |
| Azure.Core | 1.18.0 | `packages.config` |
| jQuery | 1.10.2 | `packages.config` |
| bootstrap | 3.0.0 | `packages.config` |
| Microsoft.Net.Compilers | 1.0.0 | `packages.config` |
