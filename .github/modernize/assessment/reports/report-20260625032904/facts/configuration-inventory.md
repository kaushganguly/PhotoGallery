# Configuration & Externalized Settings Inventory

The application has a minimal configuration surface: a single `Web.config` file with one environment-specific secret (`StorageConnectionString`), two standard MSBuild build profiles (Debug/Release), and no runtime environment profiles or external config server.

## Configuration Sources

| Source | Type | Path / Location | Notes |
|--------|------|-----------------|-------|
| Web.config | XML application config | `WebApp-Storage-DotNet/Web.config` | Primary runtime config; contains app settings, assembly binding redirects, and compiler settings |
| Views/Web.config | XML Razor config | `WebApp-Storage-DotNet/Views/Web.config` | Restricts direct access to `.cshtml` view files; Razor namespace imports |
| WebApp-Storage-DotNet.csproj | MSBuild project file | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` | Build configuration, NuGet references, Debug/Release property groups |
| packages.config | NuGet package manifest | `WebApp-Storage-DotNet/packages.config` | Declares all NuGet package versions (34 packages) |
| AssemblyInfo.cs | Assembly metadata | `WebApp-Storage-DotNet/Properties/AssemblyInfo.cs` | Assembly version (`1.0.0.0`), GUID, copyright |

No Spring Cloud Config, Azure App Configuration, AWS AppConfig, Consul KV, `.env` files, `appsettings.json`, `launchSettings.json`, `docker-compose.yml`, or Kubernetes ConfigMaps are present.

## Build Profiles

| Profile | Activation | Purpose | Key Behavior |
|---------|-----------|---------|--------------|
| Debug | Default; `-p:Configuration=Debug` | Local development | `DebugSymbols=true`, `DebugType=full`, `Optimize=false`, `DefineConstants=DEBUG;TRACE`, output to `bin\` |
| Release | `-p:Configuration=Release` | Production packaging | `DebugType=pdbonly`, `Optimize=true`, `DefineConstants=TRACE`, output to `bin\` |

Both profiles target `AnyCPU` platform and `.NET Framework 4.8`. The C# language version is fixed to **C# 6** via `compilerOptions="/langversion:6"` in `Web.config`. `MvcBuildViews=false` means Razor view compilation errors are not caught at build time — they surface only at runtime.

## Runtime Profiles

| Profile | Activation | Config Files | Key Overrides |
|---------|-----------|-------------|---------------|
| (Single profile — no environment split) | N/A | `Web.config` only | `StorageConnectionString` must be manually changed for each environment |

No `ASPNETCORE_ENVIRONMENT` variable, `appsettings.{Environment}.json`, or `@Profile`-annotated beans are present. The application targets the classic ASP.NET (non-Core) pipeline, which does not support environment-based config file layering natively.

## Properties Inventory

### WebApp-Storage-DotNet (Web.config AppSettings)

| Property Key | Default Value | Profiles | Source |
|-------------|--------------|---------|--------|
| `StorageConnectionString` | `UseDevelopmentStorage=true` | All | `Web.config` (hardcoded — should be externalized) |
| `webpages:Version` | `3.0.0.0` | All | `Web.config` (ASP.NET WebPages framework version lock) |
| `webpages:Enabled` | `false` | All | `Web.config` (disables WebPages routing to avoid conflict with MVC) |
| `ClientValidationEnabled` | `true` | All | `Web.config` (enables jQuery unobtrusive client-side validation) |
| `UnobtrusiveJavaScriptEnabled` | `true` | All | `Web.config` (emits `data-val-*` attributes instead of inline JS) |

### Web.config httpRuntime Settings

| Setting | Value | Notes |
|---------|-------|-------|
| `targetFramework` (compilation) | `4.8` | Compilation target |
| `targetFramework` (httpRuntime) | `4.5.2` | Request processing pipeline target |
| `maxRequestLength` | `2100000000` (≈ 2 GB) | Max file upload size |
| `executionTimeout` | `12000000` seconds (≈ 139 days) | Effectively unlimited request timeout — **security risk** |

## Startup Parameters & Resource Requirements

| Service | Runtime Options | Memory | Instance Count |
|---------|----------------|--------|---------------|
| WebApp-Storage-DotNet | IIS/IIS Express hosted; no explicit JVM/CLR heap flags | Not configured | Not configured |

No Docker containers, Kubernetes deployments, `mem_limit`, CPU quotas, or explicit CLR startup flags (`-Xms`/`-Xmx` equivalent) are configured. The application runs inside an IIS application pool; memory and process recycling are controlled via IIS configuration (not in this repository).

## Startup Dependency Chain

The application has a single startup sequence with no inter-service dependencies:

1. **IIS Application Pool starts** → loads `System.Web` pipeline
2. **`Global.asax Application_Start()`** →
   - `AreaRegistration.RegisterAllAreas()`
   - `FilterConfig.RegisterGlobalFilters()` (registers `HandleErrorAttribute`)
   - `RouteConfig.RegisterRoutes()` (registers default `{controller}/{action}/{id}` route)
   - `BundleConfig.RegisterBundles()` (registers jQuery, Bootstrap, Modernizr CSS/JS bundles)
3. **First HTTP request arrives** → `HomeController.Index()` creates `BlobServiceClient` using `StorageConnectionString` and calls `CreateIfNotExistsAsync()` to provision the container

No readiness probes, health checks, `dockerize` wait-for-TCP, or Spring Cloud Config retry mechanisms are present. If Azure Blob Storage is unreachable at startup, the error surfaces as an unhandled exception on the first request (caught by the controller's `try/catch` and rendered via `Error.cshtml`).

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage |
|-----------------|------|---------|
| `StorageConnectionString` | Azure Storage account connection string (includes account key) | Plaintext in `Web.config` — **[MASKED]** |

The storage connection string includes the Azure Storage account name and a 512-bit account key, granting full control over the storage account. It is currently stored as plaintext in a committed `Web.config` file.

### Secrets Provisioning Workflow

**Current state (insecure)**: The connection string is hardcoded in `Web.config` as `UseDevelopmentStorage=true` (Azure Storage Emulator). For production deployments, this value must be manually replaced with the real connection string before publishing — no automated secrets injection, environment variable binding, or secret store integration is in place.

**Recommended workflow for Azure migration**:
1. Remove the connection string from `Web.config` and replace with a Managed Identity reference
2. Assign a **system-assigned Managed Identity** to the Azure App Service instance
3. Grant the identity **Storage Blob Data Contributor** RBAC role on the target storage account
4. Update `HomeController` to use `new BlobServiceClient(new Uri(...), new DefaultAzureCredential())` instead of the connection string constructor

No HashiCorp Vault, Azure Key Vault, AWS Secrets Manager, Jasypt encryption, or DPAPI-protected values are in use.

## Feature Flags

No feature flag framework, `@ConditionalOnProperty`, `[FeatureGate]`, LaunchDarkly, or Unleash integration is present.

| Flag Name | Default | Controlled By |
|-----------|---------|---------------|
| (none detected) | — | — |

The only conditional behavior is `webpages:Enabled=false` (disables ASP.NET WebPages to avoid route conflicts with MVC), which is a static configuration entry rather than a dynamic feature flag.

## Framework & Runtime Versions

| Component | Version | Source |
|-----------|---------|--------|
| .NET Framework (target) | 4.8 | `WebApp-Storage-DotNet.csproj` `TargetFrameworkVersion` |
| ASP.NET MVC | 5.2.3 | `packages.config` |
| ASP.NET Razor | 3.2.3 | `packages.config` |
| ASP.NET WebPages | 3.2.3 | `packages.config` |
| C# language version | 6.0 | `Web.config` `compilerOptions="/langversion:6"` |
| Microsoft.Net.Compilers (Roslyn) | 1.0.0 | `packages.config` |
| Azure.Storage.Blobs SDK | 12.9.1 | `packages.config` |
| Azure.Core | 1.18.0 | `packages.config` |
| jQuery | 1.10.2 | `packages.config` |
| Bootstrap | 3.0.0 | `packages.config` |
| Newtonsoft.Json | 6.0.8 | `packages.config` |
| MSBuild ToolsVersion | 14.0 | `WebApp-Storage-DotNet.csproj` |
| Assembly version | 1.0.0.0 | `Properties/AssemblyInfo.cs` |
| IIS Express | (system default) | `WebApp-Storage-DotNet.csproj` `UseIISExpress=true` |
