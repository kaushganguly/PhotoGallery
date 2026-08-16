# Configuration & Externalized Settings Inventory

Configuration is concentrated in the ASP.NET `Web.config`, the legacy project file, and Visual Studio solution build configurations. No environment-specific config files, secret stores, or feature flag frameworks were detected in the repository.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|---|---|---|---|
| Web.config | ASP.NET application configuration | `WebApp-Storage-DotNet/Web.config` | Contains app settings, target framework settings, HTTP runtime limits, assembly binding redirects, and CodeDom compiler settings |
| WebApp-Storage-DotNet.csproj | MSBuild project configuration | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` | Defines target framework, Debug and Release property groups, IIS Express development port, references, and content items |
| WebApp-Storage-DotNet.sln | Visual Studio solution | `WebApp-Storage-DotNet.sln` | Defines Debug and Release solution configurations for the single web project |
| packages.config | NuGet package inventory | `WebApp-Storage-DotNet/packages.config` | Declares package versions and target frameworks |
| Views Web.config | Razor view configuration | `WebApp-Storage-DotNet/Views/Web.config` | Configures Razor view namespaces and view compilation behavior |

## Build Profiles

| Profile | Activation | Purpose | Key Dependencies/Plugins |
|---|---|---|---|
| Debug AnyCPU | Default when `Configuration` is unset | Produces debug symbols and enables `DEBUG;TRACE` constants | Uses legacy MSBuild web application targets and CodeDom compiler packages |
| Release AnyCPU | Manual `Configuration=Release` | Optimized release build with `TRACE` constant | Uses the same NuGet package references and web application targets |

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---|---|---|---|
| Default | ASP.NET application startup | `Web.config` | Uses development storage connection string, MVC web pages settings, client validation settings, and HTTP runtime limits |

No `Web.Debug.config` or `Web.Release.config` files are present even though the project file references them as content items.

## Properties Inventory

### WebApp-Storage-DotNet

| Property Key | Default | Profiles | Source |
|---|---|---|---|
| StorageConnectionString | `UseDevelopmentStorage=true` | Default | `Web.config` appSettings |
| webpages:Version | `3.0.0.0` | Default | `Web.config` appSettings |
| webpages:Enabled | `false` | Default | `Web.config` appSettings |
| ClientValidationEnabled | `true` | Default | `Web.config` appSettings |
| UnobtrusiveJavaScriptEnabled | `true` | Default | `Web.config` appSettings |
| compilation targetFramework | `4.8` | Default | `Web.config` system.web |
| httpRuntime targetFramework | `4.5.2` | Default | `Web.config` system.web |
| httpRuntime maxRequestLength | `2100000000` | Default | `Web.config` system.web |
| httpRuntime executionTimeout | `12000000` | Default | `Web.config` system.web |
| DevelopmentServerPort | `20050` | Debug and Release | `.csproj` WebProjectProperties |
| IISUrl | `http://localhost:20050/` | Debug and Release | `.csproj` WebProjectProperties |

## Startup Parameters & Resource Requirements

| Service | JVM/Runtime Options | Memory | Instance Count |
|---|---|---|---|
| WebApp-Storage-DotNet | ASP.NET on .NET Framework 4.8 under IIS or IIS Express; no command-line runtime options found | Not specified | Not specified |

## Startup Dependency Chain

1. WebApp-Storage-DotNet → waits for → ASP.NET hosting environment to load application startup registrations through `Global.asax.cs`.
2. WebApp-Storage-DotNet → depends on → configured Azure Blob Storage endpoint becoming reachable when gallery actions execute.

No Docker Compose, Kubernetes readiness probes, health checks, or explicit wait mechanisms were detected.

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage (masked) |
|---|---|---|
| StorageConnectionString | Azure Storage connection string | `Web.config` appSettings, value masked for real deployments; repository default is development storage |

### Secrets Provisioning Workflow

No external secrets provisioning workflow is defined in the repository. The storage connection string is read directly from `Web.config`; production deployments would need to replace or transform this setting through hosting configuration, deployment transforms, or a secret store outside the checked-in files.

## Feature Flags

| Flag Name | Default | Controlled By |
|---|---|---|
| None detected | N/A | N/A |

## Framework & Runtime Versions

| Component | Version | Source |
|---|---:|---|
| .NET Framework target | 4.8 | `.csproj` TargetFrameworkVersion |
| ASP.NET MVC | 5.2.3 | `packages.config` |
| ASP.NET Razor | 3.2.3 | `packages.config` |
| ASP.NET WebPages | 3.2.3 | `packages.config` |
| Azure.Storage.Blobs | 12.9.1 | `packages.config` |
| Azure.Core | 1.18.0 | `packages.config` |
| Newtonsoft.Json | 6.0.8 | `packages.config` |
| System.Text.Json | 4.6.0 | `packages.config` |
| Bootstrap | 3.0.0 | `packages.config` |
| jQuery | 1.10.2 | `packages.config` |
| Microsoft.Net.Compilers | 1.0.0 | `packages.config` |
| Visual Studio solution format | Visual Studio 14 | `.sln` |
