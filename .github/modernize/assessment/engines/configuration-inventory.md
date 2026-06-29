# Configuration & Externalized Settings Inventory

The application has a minimal configuration landscape consisting of two XML-based config files (`Web.config` and `Views/Web.config`) with no external configuration server, environment-specific overrides, secret store integration, or feature flags.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|---|---|---|---|
| `Web.config` | ASP.NET application configuration (XML) | `WebApp-Storage-DotNet/Web.config` | Primary configuration file. Contains `<appSettings>` (StorageConnectionString and MVC flags), `<system.web>` (compilation + httpRuntime), and assembly binding redirects |
| `Views/Web.config` | MVC Razor view engine configuration (XML) | `WebApp-Storage-DotNet/Views/Web.config` | Configures the Razor view engine host factory, default namespaces imported in all views, and blocks direct HTTP access to `.cshtml` files via `HttpNotFoundHandler` |
| `WebApp-Storage-DotNet.csproj` | MSBuild project file (XML) | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` | Declares target framework (`v4.8`), NuGet package references, and build configuration (Debug/Release) |
| `packages.config` | NuGet package manifest (XML) | `WebApp-Storage-DotNet/packages.config` | Records all NuGet package IDs and versions resolved at the package level |

No `appsettings.json`, `launchSettings.json`, `.env` files, Spring Cloud Config server, Azure App Configuration, Azure Key Vault, or Kubernetes ConfigMaps/Secrets were found.

## Build Profiles

| Profile | Activation | Purpose | Key Properties |
|---|---|---|---|
| Debug | Default (manual selection in Visual Studio or MSBuild `-p:Configuration=Debug`) | Development build with debug symbols, no optimization | `<DebugSymbols>true</DebugSymbols>`, `<Optimize>false</Optimize>`, `<DefineConstants>DEBUG;TRACE</DefineConstants>` |
| Release | Manual selection (`-p:Configuration=Release`) | Production-ready build with optimization, PDB-only symbols | `<DebugType>pdbonly</DebugType>`, `<Optimize>true</Optimize>`, `<DefineConstants>TRACE</DefineConstants>` |

Both configurations output to `bin\` and produce `AnyCPU` binaries. There are no Maven/Gradle build profiles, Docker build targets, or npm build scripts.

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---|---|---|---|
| (Default — single profile) | None — the application has only one runtime configuration | `Web.config` | All settings are in the single `Web.config`; no environment-specific overrides exist |

The application does not use `ASPNETCORE_ENVIRONMENT`, `appsettings.{Environment}.json`, Spring profiles, or any environment-switching mechanism. There is no `appsettings.Development.json` or `appsettings.Production.json`. The `StorageConnectionString` defaults to the Azurite/Azure Storage Emulator (`UseDevelopmentStorage=true`) and must be manually changed in `Web.config` before deploying to a real Azure environment.

## Properties Inventory

### WebApp-Storage-DotNet — `Web.config` `<appSettings>`

| Property Key | Default Value | Profiles | Source |
|---|---|---|---|
| `StorageConnectionString` | `UseDevelopmentStorage=true` | All | `Web.config` `<appSettings>` — must be changed to a real Azure Storage connection string for production |
| `webpages:Version` | `3.0.0.0` | All | `Web.config` `<appSettings>` — pins the ASP.NET WebPages version |
| `webpages:Enabled` | `false` | All | `Web.config` `<appSettings>` — disables ASP.NET WebPages direct access |
| `ClientValidationEnabled` | `true` | All | `Web.config` `<appSettings>` — enables unobtrusive client-side validation |
| `UnobtrusiveJavaScriptEnabled` | `true` | All | `Web.config` `<appSettings>` — enables unobtrusive JavaScript helpers |

### WebApp-Storage-DotNet — `Web.config` `<system.web>`

| Property Key | Value | Notes |
|---|---|---|
| `compilation[@debug]` | `true` | Debug compilation is hardcoded to `true` — should be `false` in production builds |
| `httpRuntime[@targetFramework]` | `4.5.2` | Runtime target framework for `System.Web` compatibility shims |
| `httpRuntime[@maxRequestLength]` | `2100000000` (~2 GB) | Extremely large upload limit; allows very large image file uploads |
| `httpRuntime[@executionTimeout]` | `12000000` seconds (~139 days) | Effectively disables execution timeout — a potential resource exhaustion risk |

### Views/Web.config `<appSettings>`

| Property Key | Value | Notes |
|---|---|---|
| `webpages:Enabled` | `false` | Redundant override scoped to the Views directory to prevent direct `.cshtml` execution |

## Startup Parameters & Resource Requirements

| Service | Runtime Options | Memory | Instance Count | Notes |
|---|---|---|---|---|
| WebApp-Storage-DotNet | No explicit JVM/CLR startup parameters configured | Not specified | 1 (IIS-managed) | Runs as an IIS-hosted ASP.NET application; the CLR is loaded by the IIS worker process (`w3wp.exe`). No container, no Kubernetes resource limits, and no scaling configuration are defined |

## Startup Dependency Chain

The application has a single component with one external dependency:

1. **IIS worker process starts** → loads the .NET Framework CLR
2. **First HTTP request arrives** → `MvcApplication.Application_Start()` fires
   - `AreaRegistration.RegisterAllAreas()`
   - `FilterConfig.RegisterGlobalFilters()` (registers `HandleErrorAttribute`)
   - `RouteConfig.RegisterRoutes()` (registers default `{controller}/{action}/{id}` route)
   - `BundleConfig.RegisterBundles()` (registers script/CSS bundles)
3. **First call to `HomeController.Index()`** → `BlobServiceClient` is created from `StorageConnectionString`; `CreateIfNotExistsAsync` is called on the blob container. **If Azure Blob Storage is unreachable at this point, the error is surfaced in the UI — there is no retry or wait mechanism.**

No Docker Compose `depends_on`, Kubernetes readiness probes, `dockerize` wait-for-TCP, or Spring Cloud Config retry are used.

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage |
|---|---|---|
| `StorageConnectionString` | Azure Storage account connection string (includes account name and account key or SAS token) | Hardcoded in `Web.config` as `UseDevelopmentStorage=true` (development emulator). For production, the full connection string — which contains the storage account key — must be placed in `Web.config` in plaintext |

### Secrets Provisioning Workflow

There is no secrets management workflow. The Azure Storage connection string is stored directly in `Web.config` in plaintext. For production deployments:

1. The deployment engineer manually edits `Web.config` (or uses a Web Deploy parameter transform) to replace `UseDevelopmentStorage=true` with a real Azure Storage connection string containing the account key.
2. No Azure Key Vault integration, no managed identity, no environment variable injection, and no CI/CD secrets pipeline are configured.

**Risk**: The storage account key grants full control over the storage account. Embedding it in `Web.config` risks accidental exposure in source control, application logs, or error pages (which display stack traces containing the configuration reader call chain). Recommended remediation: use a managed identity with the `Storage Blob Data Contributor` role and remove the key from configuration entirely.

## Feature Flags

No feature flag framework (LaunchDarkly, Microsoft.FeatureManagement, `@ConditionalOnProperty`, etc.) is configured. There are no conditional beans, A/B testing toggles, or gradual rollout mechanisms.

| Flag Name | Default | Controlled By |
|---|---|---|
| (none detected) | — | — |

## Framework & Runtime Versions

| Component | Version | Source |
|---|---|---|
| .NET Framework (runtime) | 4.8 | `WebApp-Storage-DotNet.csproj` `<TargetFrameworkVersion>v4.8</TargetFrameworkVersion>` |
| ASP.NET MVC | 5.2.3 | `packages.config` `Microsoft.AspNet.Mvc` |
| ASP.NET Razor | 3.2.3 | `packages.config` `Microsoft.AspNet.Razor` |
| ASP.NET WebPages | 3.2.3 | `packages.config` `Microsoft.AspNet.WebPages` |
| System.Web.Optimization (bundling) | 1.1.3 | `packages.config` `Microsoft.AspNet.Web.Optimization` |
| Azure.Storage.Blobs | 12.9.1 | `packages.config` |
| Azure.Storage.Common | 12.8.0 | `packages.config` |
| Azure.Core | 1.18.0 | `packages.config` |
| Newtonsoft.Json | 6.0.8 | `packages.config` |
| Bootstrap | 3.0.0 | `packages.config` |
| jQuery | 1.10.2 | `packages.config` |
| Modernizr | 2.6.2 | `packages.config` |
| C# language version | 6.0 | `Web.config` `<compilerOptions>/langversion:6</compilerOptions>` |
| MSBuild ToolsVersion | 14.0 | `WebApp-Storage-DotNet.csproj` `ToolsVersion="14.0"` |
| NuGet packages format | `packages.config` style | `packages.config` (legacy format; not SDK-style `PackageReference`) |
| Hosting | IIS / IIS Express | `WebApp-Storage-DotNet.csproj` `<UseIISExpress>true</UseIISExpress>` |
