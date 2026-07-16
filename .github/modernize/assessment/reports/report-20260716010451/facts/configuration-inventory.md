# Configuration & Externalized Settings Inventory

The project uses classic ASP.NET configuration files with a small set of app settings and runtime bindings, with storage connectivity externalized through a connection string.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|---|---|---|---|
| Web.config | Runtime app config | `WebApp-Storage-DotNet/Web.config` | Contains app settings, runtime, binding redirects, compiler config |
| Web.Debug.config | Transform config | `WebApp-Storage-DotNet/Web.Debug.config` | Environment-specific transform for debug builds |
| Web.Release.config | Transform config | `WebApp-Storage-DotNet/Web.Release.config` | Environment-specific transform for release builds |
| packages.config | Dependency config | `WebApp-Storage-DotNet/packages.config` | Declares NuGet package versions |
| Project file | Build/runtime config | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` | Target framework, IIS Express URL, build properties |

## Build Profiles

| Profile | Activation | Purpose | Key Dependencies/Plugins |
|---|---|---|---|
| Debug|AnyCPU | Default local build | Enables debug symbols and diagnostics | MVC/Web tooling imports, legacy compiler packages |
| Release|AnyCPU | Explicit release build | Optimized build output | Same dependency graph with optimization enabled |

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---|---|---|---|
| Default IIS/IIS Express runtime | Hosting environment + Web.config | `Web.config` + optional transforms | Connection string, request limits, assembly binding redirects |

## Properties Inventory

| Property Key | Default | Profiles | Source |
|---|---|---|---|
| `StorageConnectionString` | `UseDevelopmentStorage=true` | Default | Web.config appSettings |
| `webpages:Version` | `3.0.0.0` | Default | Web.config appSettings |
| `webpages:Enabled` | `false` | Default | Web.config appSettings |
| `ClientValidationEnabled` | `true` | Default | Web.config appSettings |
| `UnobtrusiveJavaScriptEnabled` | `true` | Default | Web.config appSettings |

## Startup Parameters & Resource Requirements

| Service | JVM/Runtime Options | Memory | Instance Count |
|---|---|---|---|
| WebApp-Storage-DotNet | ASP.NET runtime via IIS/IIS Express; no explicit command-line runtime flags in repo | Not specified in repository | 1 (implicit local host process) |

## Startup Dependency Chain

1. IIS/IIS Express starts the ASP.NET application domain.
2. `Application_Start` registers filters, routes, and bundles.
3. First request to `Home/Index` initializes blob clients and ensures container existence.
4. Storage operations depend on valid `StorageConnectionString` and reachable Azure Storage endpoint.

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage (masked) |
|---|---|---|
| `StorageConnectionString` | Storage credential/connection string | Web.config (`[MASKED OR EMULATOR VALUE]`) |

### Secrets Provisioning Workflow

The application reads storage credentials from `Web.config` app settings at runtime. In production, this value is expected to be replaced during deployment/environment configuration. No managed identity or external secret-store integration is declared in this repository.

## Feature Flags

| Flag Name | Default | Controlled By |
|---|---|---|
| None detected | N/A | N/A |

## Framework & Runtime Versions

| Component | Version | Source |
|---|---|---|
| .NET Framework | 4.8 | `WebApp-Storage-DotNet.csproj` |
| ASP.NET MVC | 5.2.3 | `packages.config` |
| Razor | 3.2.3 | `packages.config` |
| Azure.Storage.Blobs | 12.9.1 | `packages.config` |
| Newtonsoft.Json | 6.0.8 | `packages.config` |
| C# language version | 6 | `Web.config` compiler options |
