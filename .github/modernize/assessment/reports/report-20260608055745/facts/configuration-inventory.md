# Configuration & Externalized Settings Inventory

This application relies on a single `Web.config` XML file as its only configuration source, with one externalized property (Azure Storage connection string) and no environment-specific profiles, feature flags, or secrets management integration.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|--------|------|--------------|-------|
| `Web.config` | XML app configuration | `WebApp-Storage-DotNet/Web.config` | Primary configuration file; contains app settings, HTTP runtime, assembly binding redirects, and compiler configuration |
| `Web.Debug.config` | XML transform | `WebApp-Storage-DotNet/Web.Debug.config` | Build-time transform applied in Debug configuration |
| `Web.Release.config` | XML transform | `WebApp-Storage-DotNet/Web.Release.config` | Build-time transform applied in Release configuration |
| `Views/Web.config` | XML Razor config | `WebApp-Storage-DotNet/Views/Web.config` | Razor view engine namespace imports and view handler configuration |
| `packages.config` | NuGet package list | `WebApp-Storage-DotNet/packages.config` | Declares all 36 NuGet package dependencies with versions |
| `AssemblyInfo.cs` | Assembly metadata | `Properties/AssemblyInfo.cs` | Assembly version `1.0.0.0`, product `WebApp_Storage_DotNet` |

No external configuration server (Azure App Configuration, Spring Cloud Config), Kubernetes ConfigMaps, `.env` files, or `appsettings.json` files are present. This is a classic .NET Framework project using `Web.config` exclusively.

## Build Profiles

| Profile | Activation | Purpose | Key Effects |
|---------|-----------|---------|------------|
| Debug | Default / `--configuration Debug` in MSBuild | Local development | Debug symbols enabled (`DebugType=full`), `DEBUG;TRACE` constants, no optimization |
| Release | `-c Release` in MSBuild / CI pipeline | Production build | PDB-only symbols, optimize enabled, `TRACE` constant only, applies `Web.Release.config` transforms |

Web.config transforms (`Web.Debug.config`, `Web.Release.config`) are applied at publish/deploy time via MSBuild XDT transforms but are empty by default in this project — no overrides are currently defined in them, indicating the same `Web.config` values are used across all environments.

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---------|-----------------|--------------|--------------|
| Default (only profile) | Implicit — no `ASPNETCORE_ENVIRONMENT` equivalent in .NET Framework | `Web.config` | `StorageConnectionString=UseDevelopmentStorage=true` (Azure Storage Emulator) |

This is a .NET Framework 4.8 project using classic ASP.NET (not ASP.NET Core) and therefore has no `ASPNETCORE_ENVIRONMENT` support, no `appsettings.{Environment}.json` layering, and no runtime profile switching. All environment-specific overrides must be applied via deployment-time `Web.config` transforms or IIS environment variable injection.

## Properties Inventory

### WebApp-Storage-DotNet (`Web.config` — `<appSettings>`)

| Property Key | Default Value | Profiles | Source |
|-------------|--------------|---------|--------|
| `StorageConnectionString` | `UseDevelopmentStorage=true` | All | `Web.config` `<appSettings>` — **must be overridden in production** with a real Azure Storage connection string |
| `webpages:Version` | `3.0.0.0` | All | `Web.config` — Razor/WebPages version declaration |
| `webpages:Enabled` | `false` | All | `Web.config` — disables WebPages routing (MVC only) |
| `ClientValidationEnabled` | `true` | All | `Web.config` — enables client-side jQuery validation |
| `UnobtrusiveJavaScriptEnabled` | `true` | All | `Web.config` — enables unobtrusive jQuery validation |

### `Web.config` — `<system.web>` / `<httpRuntime>`

| Property | Value | Notes |
|----------|-------|-------|
| Compilation `targetFramework` | `4.8` | .NET Framework 4.8 |
| `httpRuntime targetFramework` | `4.5.2` | Legacy compatibility mode for HTTP runtime behavior |
| `httpRuntime maxRequestLength` | `2100000000` (bytes ~2 GB) | Very large upload limit; consider reducing for security |
| `httpRuntime executionTimeout` | `12000000` (seconds ~139 days) | Extremely large timeout; effectively no timeout — should be reduced |

## Startup Parameters & Resource Requirements

| Service | Runtime Options | Memory | Instance Count |
|---------|----------------|--------|---------------|
| WebApp-Storage-DotNet | Hosted on IIS / IIS Express; no explicit JVM/CLR heap settings configured | Not specified (inherits IIS application pool defaults) | 1 (no horizontal scaling configuration) |

No Docker container, Kubernetes deployment, or cloud hosting configuration (Azure App Service, Azure Container Apps) is present in the repository. No `Dockerfile`, `docker-compose.yml`, `helm/` chart, or deployment YAML files exist. The application is expected to be deployed to IIS or published via Visual Studio/MSBuild.

## Startup Dependency Chain

The application has a simple single-process startup sequence with no inter-service dependencies:

1. **IIS / IIS Express** starts the ASP.NET application pool
2. **`Application_Start`** (`Global.asax.cs`) fires:
   - `AreaRegistration.RegisterAllAreas()` — scans for MVC area registrations
   - `FilterConfig.RegisterGlobalFilters()` — registers `HandleErrorAttribute`
   - `RouteConfig.RegisterRoutes()` — registers the default MVC route
   - `BundleConfig.RegisterBundles()` — registers script/CSS bundles
3. **First HTTP request to `/Home/Index`** initializes `BlobServiceClient` and creates the blob container if it does not exist

There are no readiness probes, health check endpoints, wait-for-service mechanisms, or service registry registrations. The Azure Blob Storage endpoint must be reachable at first request time; if unreachable, the `Index` action catches the exception and returns an error view.

## Secrets & Sensitive Configuration

| Secret Reference | Type | Location | Status |
|-----------------|------|---------|--------|
| `StorageConnectionString` | Azure Storage connection string (account name + key) | `Web.config` `<appSettings>` | **Sensitive** — defaults to `UseDevelopmentStorage=true`; production value must contain account key; stored in plaintext in config file |

### Secrets Provisioning Workflow

No secrets management integration is implemented. The Azure Storage connection string is stored as a plaintext value in `Web.config`. In production deployments, this must be replaced via one of these mechanisms (none currently configured):

- **Web.config transform**: Define a `Web.Release.config` XDT transform to replace the connection string value at publish time (the transform files exist but are empty)
- **IIS Environment Variables**: Set the value as an IIS application-level environment variable and reference via `%ENV_VAR%` syntax
- **Azure App Service Application Settings**: If deployed to Azure App Service, the `StorageConnectionString` app setting can be overridden in the portal and injected into `Web.config` automatically
- **Azure Key Vault**: No Key Vault integration is configured; adding the `Azure.Extensions.AspNetCore.Configuration.Secrets` package would require migrating to ASP.NET Core

**Current risk**: If the `Web.config` file is committed with a real storage connection string (account key), it would expose write/delete access to all blobs. The `.gitignore` does not exclude `Web.config`.

## Feature Flags

No feature flag framework (LaunchDarkly, Unleash, .NET `Microsoft.FeatureManagement`, custom `@ConditionalOnProperty`) is implemented. No conditional configuration, A/B testing, or gradual rollout mechanisms are present.

| Flag Name | Default | Controlled By |
|-----------|---------|--------------|
| None detected | — | — |

## Framework & Runtime Versions

| Component | Version | Source |
|-----------|---------|--------|
| Target Framework | .NET Framework 4.8 | `WebApp-Storage-DotNet.csproj` `<TargetFrameworkVersion>v4.8</TargetFrameworkVersion>` |
| ASP.NET MVC | 5.2.3 | `packages.config` — `Microsoft.AspNet.Mvc 5.2.3` |
| ASP.NET Razor | 3.2.3 | `packages.config` — `Microsoft.AspNet.Razor 3.2.3` |
| ASP.NET WebPages | 3.2.3 | `packages.config` — `Microsoft.AspNet.WebPages 3.2.3` |
| Azure.Storage.Blobs SDK | 12.9.1 | `packages.config` |
| Azure.Core | 1.18.0 | `packages.config` |
| Azure.Storage.Common | 12.8.0 | `packages.config` |
| Newtonsoft.Json | 6.0.8 | `packages.config` |
| Bootstrap | 3.0.0 | `packages.config` |
| jQuery | 1.10.2 | `packages.config` |
| Modernizr | 2.6.2 | `packages.config` |
| C# Language Version | 6 | `Web.config` `<compiler compilerOptions="/langversion:6">` |
| MSBuild Tools | 14.0 | `WebApp-Storage-DotNet.csproj` `ToolsVersion="14.0"` |
| Assembly Version | 1.0.0.0 | `Properties/AssemblyInfo.cs` |
| IIS Express Dev Port | 20050 | `WebApp-Storage-DotNet.csproj` `<DevelopmentServerPort>` |
