# Configuration & Externalized Settings Inventory

The application uses a single `Web.config` XML configuration file as its only configuration source; there are no profiles, external config servers, or secrets management integrations beyond a plain-text connection string.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|---|---|---|---|
| Web.config | XML application config | `WebApp-Storage-DotNet/Web.config` | Primary and only config file; contains app settings, runtime bindings, and HTTP runtime settings |
| Web.Debug.config | XML transform | `WebApp-Storage-DotNet/Web.Debug.config` | XDT transform applied during Debug builds (file not shown to contain custom transforms) |
| Web.Release.config | XML transform | `WebApp-Storage-DotNet/Web.Release.config` | XDT transform applied during Release builds (file not shown to contain custom transforms) |
| Views/Web.config | XML (Razor view config) | `WebApp-Storage-DotNet/Views/Web.config` | Razor view engine settings; restricts direct URL access to `.cshtml` files |
| packages.config | NuGet package manifest | `WebApp-Storage-DotNet/packages.config` | Declares NuGet package versions; not a runtime config source |

No Spring Cloud Config server, Azure App Configuration, AWS AppConfig, Consul KV, or external configuration repositories are in use.

## Build Profiles

| Profile | Activation | Purpose | Key Dependencies / Plugins |
|---|---|---|---|
| Debug | Default in Visual Studio / `dotnet build` without `-c` | Development build with full debug symbols, no optimization | `<DebugSymbols>true</DebugSymbols>`, `<Optimize>false</Optimize>`, XDT from `Web.Debug.config` |
| Release | `-c Release` or publish pipeline | Production build with optimized output | `<Optimize>true</Optimize>`, `<DebugType>pdbonly</DebugType>`, XDT from `Web.Release.config` |

No MSBuild condition properties, custom build targets, or environment-specific NuGet feeds are defined beyond the two standard Debug / Release configurations.

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---|---|---|---|
| Development | Default — uses `UseDevelopmentStorage=true` | `Web.config` | `StorageConnectionString` points to local Azure Storage Emulator |
| Production | Connection string override via deployment pipeline or App Service app setting | `Web.config` (or environment variable injection) | `StorageConnectionString` must be replaced with a real Azure Storage account connection string |

The application does not use `ASPNETCORE_ENVIRONMENT`, `IHostEnvironment`, or `appsettings.{Environment}.json` files — it targets `System.Web` (IIS pipeline), which does not support the ASP.NET Core environment model. Environment switching relies entirely on manual connection string replacement or Web.config transforms.

## Properties Inventory

### WebApp-Storage-DotNet

| Property Key | Default Value | Profiles | Source |
|---|---|---|---|
| `StorageConnectionString` | `UseDevelopmentStorage=true` | All (override in production) | `Web.config` → `<appSettings>` |
| `webpages:Version` | `3.0.0.0` | All | `Web.config` → `<appSettings>` |
| `webpages:Enabled` | `false` | All | `Web.config` → `<appSettings>` |
| `ClientValidationEnabled` | `true` | All | `Web.config` → `<appSettings>` |
| `UnobtrusiveJavaScriptEnabled` | `true` | All | `Web.config` → `<appSettings>` |
| `compilation debug` | `true` | All | `Web.config` → `<system.web><compilation>` |
| `targetFramework` (compilation) | `4.8` | All | `Web.config` → `<system.web><compilation>` |
| `httpRuntime targetFramework` | `4.5.2` | All | `Web.config` → `<system.web><httpRuntime>` |
| `maxRequestLength` | `2100000000` | All | `Web.config` → `<system.web><httpRuntime>` |
| `executionTimeout` | `12000000` | All | `Web.config` → `<system.web><httpRuntime>` |

> Note: `maxRequestLength` is set to ~2 GB and `executionTimeout` to ~138 days — both are extreme values that suggest the defaults were not reviewed for production use.

## Startup Parameters & Resource Requirements

| Service | Runtime Options | Memory / CPU | Instance Count |
|---|---|---|---|
| WebApp-Storage-DotNet | Standard IIS worker process (w3wp.exe); no custom JVM or .NET CLR startup flags configured | Not specified in project files; relies on IIS / App Service plan defaults | 1 (no scaling configuration present) |

No Docker Compose files, Kubernetes manifests, or cloud deployment descriptors are present in the repository. There are no `ASPNETCORE_ENVIRONMENT` environment variable overrides or cloud-specific startup scripts.

## Startup Dependency Chain

| Order | Service / Component | Waits For | Mechanism |
|---|---|---|---|
| 1 | IIS / IIS Express | — | Starts the ASP.NET application host |
| 2 | WebApp-Storage-DotNet (`Application_Start`) | IIS worker process | `Global.asax.cs` `Application_Start` — registers routes, filters, bundles |
| 3 | Azure Blob Storage container | First HTTP request to `Index` | `CreateIfNotExistsAsync` called lazily on first page load; no readiness probe or health check configured |

There are no explicit startup dependency checks, `dockerize` wait-for-TCP guards, readiness probes, or retry policies. If Azure Blob Storage is unavailable at startup the application will surface a raw exception message to the browser on the first request.

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage |
|---|---|---|
| `StorageConnectionString` | Azure Storage account connection string or SAS token | Plain text in `Web.config` `<appSettings>` — **[MASKED]** in production |

No encryption (Jasypt, DPAPI, sealed secrets) is applied to the connection string value. The file is tracked in source control, meaning any developer or CI runner with repository access can read production credentials if the file is not excluded or the value is not replaced during deployment.

### Secrets Provisioning Workflow

**Current state (development):** The connection string defaults to `UseDevelopmentStorage=true`, which targets the local Azure Storage Emulator. No secrets provisioning workflow is defined in the repository.

**Production gap:** There is no documented mechanism for injecting production credentials. Recommended approaches for an Azure deployment include:

1. **Azure App Service Application Settings** — override `StorageConnectionString` as an environment variable in the App Service configuration panel; this value supersedes `Web.config` at runtime without modifying source code.
2. **Azure Key Vault + Managed Identity** — store the connection string in Key Vault, assign a system-managed identity to the App Service, and reference the secret via the Key Vault reference syntax (`@Microsoft.KeyVault(SecretUri=...)`).
3. **CI/CD secret substitution** — use a Web.config transform or deployment pipeline step (e.g., GitHub Actions `microsoft/variable-substitution`) to replace the placeholder value during release.

No RBAC permissions, managed identity configuration, or Key Vault references are currently configured in the repository.

## Feature Flags

No feature flags, conditional beans, `@ConditionalOnProperty` annotations, or feature management frameworks are in use. The application has no A/B testing or gradual rollout configuration.

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
| System.Web.Optimization | 1.1.3 | `packages.config` `Microsoft.AspNet.Web.Optimization` |
| Azure.Storage.Blobs SDK | 12.9.1 | `packages.config` |
| Azure.Core | 1.18.0 | `packages.config` |
| Newtonsoft.Json | 6.0.8 | `packages.config` |
| Bootstrap | 3.0.0 | `packages.config` |
| jQuery | 1.10.2 | `packages.config` |
| Modernizr | 2.6.2 | `packages.config` |
| C# Language Version | 6 (set via `/langversion:6` in `Web.config` compiler options) | `Web.config` `<system.codedom>` |
| MSBuild ToolsVersion | 14.0 | `WebApp-Storage-DotNet.csproj` |
| NuGet package management | `packages.config` format (legacy) | `WebApp-Storage-DotNet.csproj` |
