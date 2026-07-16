# Configuration & Externalized Settings Inventory

Configuration is concentrated in classic ASP.NET `Web.config` and project build settings, with one primary external dependency setting for Azure Storage. No multi-environment profile system or external configuration server was detected.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|---|---|---|---|
| Web.config | Application settings + runtime config | `WebApp-Storage-DotNet/Web.config` | Defines `StorageConnectionString`, runtime and binding redirects |
| packages.config | Dependency manifest | `WebApp-Storage-DotNet/packages.config` | Declared NuGet package versions |
| WebApp-Storage-DotNet.csproj | Build configuration | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` | Target framework, IIS Express settings, debug/release props |
| RouteConfig.cs / BundleConfig.cs | App startup behavior | `WebApp-Storage-DotNet/App_Start/*` | Route and asset bundle registration |

## Build Profiles

| Profile | Activation | Purpose | Key Dependencies/Plugins |
|---|---|---|---|
| Debug | `Configuration=Debug` | Local debugging with symbols | Standard MVC dependencies; `DEBUG;TRACE` constants |
| Release | `Configuration=Release` | Optimized production build | Same package set; optimized compilation |

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---|---|---|---|
| Default | IIS/IIS Express startup | `Web.config` | `StorageConnectionString=UseDevelopmentStorage=true` by default |

## Properties Inventory

| Property Key | Default | Profiles | Source |
|---|---|---|---|
| StorageConnectionString | `UseDevelopmentStorage=true` | Default | `Web.config` appSettings |
| webpages:Version | `3.0.0.0` | Default | `Web.config` appSettings |
| webpages:Enabled | `false` | Default | `Web.config` appSettings |
| ClientValidationEnabled | `true` | Default | `Web.config` appSettings |
| UnobtrusiveJavaScriptEnabled | `true` | Default | `Web.config` appSettings |
| compilation/debug | `true` | Debug-oriented runtime | `Web.config` system.web |
| httpRuntime/maxRequestLength | `2100000000` | Default | `Web.config` system.web |
| httpRuntime/executionTimeout | `12000000` | Default | `Web.config` system.web |

## Startup Parameters & Resource Requirements

| Service | JVM/Runtime Options | Memory | Instance Count |
|---|---|---|---|
| WebApp-Storage-DotNet | IIS-hosted ASP.NET runtime options not explicitly declared in repo | Not specified | Not specified |

## Startup Dependency Chain

1. IIS/IIS Express starts ASP.NET application.
2. `Application_Start` registers routes, filters, and bundles.
3. First request to `HomeController.Index` initializes blob container client.
4. Blob operations require reachable storage endpoint from `StorageConnectionString`.

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage (masked) |
|---|---|---|
| `StorageConnectionString` | Storage account credential string | `Web.config` appSettings (`[MASKED in production]`) |

### Secrets Provisioning Workflow

Secrets are expected to be injected by replacing the development storage connection string in `Web.config` for non-local environments. No key vault integration, managed identity flow, or automated secret rotation mechanism was found in repository configuration.

## Feature Flags

| Flag Name | Default | Controlled By |
|---|---|---|
| None detected | N/A | N/A |

## Framework & Runtime Versions

| Component | Version | Source |
|---|---|---|
| .NET Framework target | 4.8 | `WebApp-Storage-DotNet.csproj` |
| ASP.NET MVC | 5.2.3 | `packages.config` |
| Razor | 3.2.3 | `packages.config` |
| Azure.Storage.Blobs | 12.9.1 | `packages.config` |
| Azure.Core | 1.18.0 | `packages.config` |
| Newtonsoft.Json | 6.0.8 | `packages.config` |
| jQuery | 1.10.2 | `packages.config` |
| Bootstrap | 3.0.0 | `packages.config` |
