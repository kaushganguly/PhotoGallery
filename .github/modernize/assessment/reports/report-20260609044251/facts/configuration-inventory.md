# Configuration & Externalized Settings Inventory

This project uses a compact configuration model centered on classic ASP.NET `Web.config` plus MSBuild project settings in the `.csproj`. Externalized settings are minimal, with one primary storage connection setting and no separate environment profile files committed.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|---|---|---|---|
| Web.config | Runtime application config | `WebApp-Storage-DotNet/Web.config` | Contains appSettings and runtime/system.web settings |
| WebApp-Storage-DotNet.csproj | Build config | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` | Contains Debug/Release build properties and IIS Express defaults |
| packages.config | Dependency config | `WebApp-Storage-DotNet/packages.config` | Declares NuGet package versions |
| README deployment instructions | Operational config guidance | `README.md` | Documents replacing storage connection string for cloud deployment |

## Build Profiles

| Profile | Activation | Purpose | Key Dependencies/Plugins |
|---|---|---|---|
| Debug | `Configuration=Debug` (default local) | Local build with symbols and no optimization | `DebugSymbols=true`, `Optimize=false`, `DefineConstants=DEBUG;TRACE` |
| Release | `Configuration=Release` | Optimized production build | `Optimize=true`, `DefineConstants=TRACE` |

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---|---|---|---|
| Default | IIS/IIS Express application startup | `Web.config` | Uses `StorageConnectionString=UseDevelopmentStorage=true` by default |
| Cloud deployment (convention) | Manual config update during deployment | `Web.config` (edited/published) | Replace development storage with Azure Storage account connection string |

## Properties Inventory

### WebApp-Storage-DotNet

| Property Key | Default | Profiles | Source |
|---|---|---|---|
| StorageConnectionString | `UseDevelopmentStorage=true` | Default; overridden manually for cloud deployment | `Web.config` appSettings |
| webpages:Version | `3.0.0.0` | Default | `Web.config` appSettings |
| webpages:Enabled | `false` | Default | `Web.config` appSettings |
| ClientValidationEnabled | `true` | Default | `Web.config` appSettings |
| UnobtrusiveJavaScriptEnabled | `true` | Default | `Web.config` appSettings |
| compilation.debug | `true` | Default | `Web.config` system.web |
| compilation.targetFramework | `4.8` | Default | `Web.config` system.web |
| httpRuntime.targetFramework | `4.5.2` | Default | `Web.config` system.web |
| httpRuntime.maxRequestLength | `2100000000` | Default | `Web.config` system.web |
| httpRuntime.executionTimeout | `12000000` | Default | `Web.config` system.web |

## Startup Parameters & Resource Requirements

| Service | JVM/Runtime Options | Memory | Instance Count |
|---|---|---|---|
| WebApp-Storage-DotNet | ASP.NET on .NET Framework 4.8, IIS Express enabled for local development | Not explicitly configured in repository | Not explicitly configured in repository |

## Startup Dependency Chain

1. Web application starts under IIS/IIS Express.
2. On first request to `HomeController.Index`, the app reads `StorageConnectionString` from configuration.
3. The app connects to Azure Storage endpoint (development emulator or Azure account), creates container if missing, then serves requests.

No explicit orchestrated service startup dependencies (compose/kubernetes health-check chain) were detected.

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage (masked) |
|---|---|---|
| `StorageConnectionString` | Storage account credential or emulator connection string | `Web.config` appSettings (`[MASKED when using real account keys]`) |

### Secrets Provisioning Workflow

Secrets are provided through configuration values, primarily `StorageConnectionString`. In local development, the default uses emulator storage and does not require real cloud secrets. For deployment, operators update configuration with storage account credentials before publish/deploy; no dedicated key vault integration or managed identity workflow is defined in repository files.

## Feature Flags

| Flag Name | Default | Controlled By |
|---|---|---|
| None detected | n/a | n/a |

## Framework & Runtime Versions

| Component | Version | Source |
|---|---|---|
| .NET Framework target | 4.8 | `WebApp-Storage-DotNet.csproj` |
| ASP.NET MVC | 5.2.3 | `packages.config` |
| Razor/WebPages | 3.2.3 | `packages.config` |
| Azure.Storage.Blobs | 12.9.1 | `packages.config` |
| Azure.Core | 1.18.0 | `packages.config` |
| jQuery | 1.10.2 | `packages.config` |
| bootstrap | 3.0.0 | `packages.config` |
| Newtonsoft.Json | 6.0.8 | `packages.config` |
| MSBuild ToolsVersion | 14.0 | `WebApp-Storage-DotNet.csproj` |
