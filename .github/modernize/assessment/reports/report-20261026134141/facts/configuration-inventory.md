# Configuration & Externalized Settings Inventory

Configuration is held in the legacy ASP.NET `Web.config` and project manifests. The checked-in application uses the local storage emulator connection value and does not define environment-specific runtime profiles or a secrets provider.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|---|---|---|---|
| Web application configuration | XML | `WebApp-Storage-DotNet/Web.config` | App settings, ASP.NET runtime options, assembly binding redirects |
| Razor view configuration | XML | `WebApp-Storage-DotNet/Views/Web.config` | Razor host and view namespace configuration |
| Project file | MSBuild XML | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` | Framework, build configurations, references, IIS Express development settings |
| Package manifest | NuGet XML | `WebApp-Storage-DotNet/packages.config` | Explicit package versions |
| Solution | Visual Studio solution | `WebApp-Storage-DotNet.sln` | Contains the single web application project |

No `Web.Debug.config` or `Web.Release.config` transform files, external config server, or secret-store integration were found.

## Build Profiles

| Profile | Activation | Purpose | Key Dependencies/Plugins |
|---|---|---|---|
| Debug | MSBuild `Debug` configuration | Development build, defines `DEBUG;TRACE` | Same project dependencies as Release |
| Release | MSBuild `Release` configuration | Optimized build, defines `TRACE` | Same project dependencies as Debug |

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---|---|---|---|
| Default | ASP.NET application startup | `Web.config` | Local development storage connection value; no environment-specific overrides found |

## Properties Inventory

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
| `system.web/compilation/@debug` | `false` | Release project configuration | Project file build properties do not define a Web.config transform |

The application configuration also contains assembly binding redirects for Newtonsoft.Json, ASP.NET MVC, and System.* libraries.

## Startup Parameters & Resource Requirements

| Service | Runtime Options | Memory | Instance Count |
|---|---|---|---|
| WebApp-Storage-DotNet | IIS Express development port 20050; no JVM or explicit .NET runtime flags found | Not specified | Not specified |

## Startup Dependency Chain

1. IIS/IIS Express loads the ASP.NET application.
2. `Application_Start` registers MVC areas, filters, routes, and bundles.
3. The first gallery request constructs the Azure storage service client and resolves the blob container.

No readiness probe, startup wait mechanism, or dependency health-check chain was found.

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage (masked) |
|---|---|---|
| `StorageConnectionString` | Storage account connection string | Current checked-in value selects the local emulator; no account key is present |

### Secrets Provisioning Workflow

No secret manager, managed identity, or deployment-time secret-binding workflow is configured. The Web.config comment directs a developer to insert a storage account name and key for a real account; no such credential is present in the checked-in value.

## Feature Flags

No feature flag framework, application toggles, or conditional runtime feature configuration was identified.

## Framework & Runtime Versions

| Component | Version | Source |
|---|---|---|
| .NET Framework | 4.8 | Project file |
| ASP.NET MVC | 5.2.3 | `packages.config` |
| Razor / WebPages | 3.2.3 | `packages.config` |
| Azure.Storage.Blobs | 12.9.1 | `packages.config` |
| Azure.Core | 1.18.0 | `packages.config` |
| IIS Express development port | 20050 | Project file |
| NuGet packages | Legacy `packages.config` management | Project file and package manifest |
