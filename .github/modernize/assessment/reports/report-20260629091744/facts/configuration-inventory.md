# Configuration & Externalized Settings Inventory

The application uses a single configuration source (`Web.config`) with no externalized secrets store, no environment-specific overrides, and no feature flag framework — all settings are committed directly to the repository.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|--------|------|--------------|-------|
| Web.config | XML application config | `WebApp-Storage-DotNet/Web.config` | Primary config; holds storage connection string, ASP.NET settings, and assembly binding redirects |
| Views/Web.config | XML Razor config | `WebApp-Storage-DotNet/Views/Web.config` | Locks down `.cshtml` view access via `HttpNotFoundHandler`; registers Razor namespaces |
| AssemblyInfo.cs | Build-time metadata | `WebApp-Storage-DotNet/Properties/AssemblyInfo.cs` | Assembly version (`1.0.0.0`), title, copyright |
| packages.config | NuGet package list | `WebApp-Storage-DotNet/packages.config` | Declares NuGet dependencies and target frameworks |
| WebApp-Storage-DotNet.sln | Visual Studio solution | `WebApp-Storage-DotNet.sln` | Solution file referencing the single project |

No `appsettings.json`, `launchSettings.json`, `.env` files, Spring Cloud Config server, Azure App Configuration, Key Vault references, or Kubernetes ConfigMaps/Secrets are present.

## Build Profiles

| Profile | Activation | Purpose | Key Properties |
|---------|------------|---------|----------------|
| Debug | Default (MSBuild `$(Configuration)=Debug`) | Development build with full debug symbols | `<DebugType>full</DebugType>`, `<Optimize>false</Optimize>`, output to `bin\` |
| Release | Manual (`-c Release` or IDE publish) | Optimized production build | `<DebugType>pdbonly</DebugType>`, `<Optimize>true</Optimize>`, output to `bin\` |

No `Web.Debug.config` or `Web.Release.config` XDT transform files exist — there are no per-build-profile config transformations. The same `Web.config` is used regardless of build configuration.

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---------|------------------|-------------|---------------|
| (single / no profiles) | N/A | `Web.config` only | No environment-specific overrides defined |

The application has no `ASPNETCORE_ENVIRONMENT` support (it is .NET Framework, not ASP.NET Core). There are no `appsettings.{Environment}.json` files, no `Web.Staging.config` transforms, and no runtime profile mechanism. All environment differences must be managed by manually replacing `Web.config` during deployment.

## Properties Inventory

### WebApp-Storage-DotNet (Web.config — `<appSettings>`)

| Property Key | Default Value | Profiles | Source |
|-------------|--------------|---------|--------|
| `StorageConnectionString` | `UseDevelopmentStorage=true` | All | `Web.config` (plaintext — should be replaced at deploy time) |
| `webpages:Version` | `3.0.0.0` | All | `Web.config` |
| `webpages:Enabled` | `false` | All | `Web.config` (also set in `Views/Web.config`) |
| `ClientValidationEnabled` | `true` | All | `Web.config` |
| `UnobtrusiveJavaScriptEnabled` | `true` | All | `Web.config` |

### WebApp-Storage-DotNet (Web.config — `<system.web>`)

| Property Key | Value | Notes |
|-------------|-------|-------|
| `compilation debug` | `true` | Debug compilation enabled in the committed config — should be `false` in production |
| `compilation targetFramework` | `4.8` | .NET Framework 4.8 |
| `httpRuntime targetFramework` | `4.5.2` | Legacy compatibility mode |
| `httpRuntime maxRequestLength` | `2100000000` (≈ 2 GB) | Very large upload limit — allows multi-gigabyte file uploads |
| `httpRuntime executionTimeout` | `12000000` seconds (≈ 139 days) | Extremely large timeout — effectively disables server-side request timeout |

### Views/Web.config

| Property Key | Value | Notes |
|-------------|-------|-------|
| `webpages:Enabled` | `false` | Prevents WebPages routing in the Views directory |

## Startup Parameters & Resource Requirements

| Service | Runtime Options | Memory | Instance Count |
|---------|----------------|--------|----------------|
| WebApp-Storage-DotNet | IIS / IIS Express; no JVM | Not specified (IIS managed) | 1 (no scale-out configuration) |

No Docker containers, Kubernetes manifests, or cloud deployment IaC files are present. No explicit memory, CPU, or scaling configuration exists. The application is designed to run under IIS or IIS Express on Windows. No `ASPNETCORE_ENVIRONMENT`, process-level environment variables, or `-D` startup parameters are defined.

## Startup Dependency Chain

The application has a single-service startup sequence with one external dependency:

1. **IIS / IIS Express** starts the ASP.NET application worker process.
2. **`MvcApplication.Application_Start()`** (`Global.asax.cs`) registers routes, bundles, and filters synchronously.
3. **First HTTP request** triggers `HomeController.Index()`, which creates a `BlobServiceClient` and calls `CreateIfNotExistsAsync()` — this is the first network call to Azure Blob Storage.

There is no health check endpoint, no readiness probe, no `dockerize` wait mechanism, and no dependency ordering tool. If Azure Blob Storage is unavailable at startup, the first page request will throw an exception (caught by the controller's `try/catch` and shown in the Error view).

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage |
|-----------------|------|---------|
| `StorageConnectionString` | Azure Storage account name + key (full data-plane access) | Plaintext in `Web.config` — `[MASKED in production; must be replaced at deploy time]` |

No encryption (Jasypt, DPAPI, Azure Key Vault), no environment variable injection, and no secrets management tooling is configured. The default value (`UseDevelopmentStorage=true`) is safe for development but the pattern of storing secrets in `Web.config` is a security risk in production.

### Secrets Provisioning Workflow

There is **no automated secrets provisioning workflow** defined in this repository. The current state is:

1. `StorageConnectionString` is hardcoded in `Web.config` as `UseDevelopmentStorage=true`.
2. For production deployment, a developer must manually edit `Web.config` (or apply a Web Deploy publish profile) to replace the connection string value.
3. No managed identity, service principal, Key Vault reference, or CI/CD secret injection pipeline is configured.

**Recommended path**: Replace the connection string with a system-assigned managed identity on Azure App Service, grant it the `Storage Blob Data Contributor` role on the storage account, and update the SDK client instantiation to use `new BlobServiceClient(new Uri(...), new DefaultAzureCredential())`.

## Feature Flags

No feature flag framework is used. There are no `@ConditionalOnProperty` beans, `.NET FeatureManagement` entries, LaunchDarkly references, or custom toggle mechanisms.

| Flag Name | Default | Controlled By |
|-----------|---------|--------------|
| `webpages:Enabled` | `false` | `Web.config` — disables ASP.NET WebPages (not a feature flag per se, but a framework toggle) |
| `ClientValidationEnabled` | `true` | `Web.config` — enables jQuery Unobtrusive Validation |
| `UnobtrusiveJavaScriptEnabled` | `true` | `Web.config` — enables unobtrusive JavaScript helpers in MVC |
| `MvcBuildViews` | `false` | `.csproj` — disables Razor view pre-compilation at build time |

## Framework & Runtime Versions

| Component | Version | Source |
|-----------|---------|--------|
| .NET Framework | 4.8 | `WebApp-Storage-DotNet.csproj` `<TargetFrameworkVersion>v4.8</TargetFrameworkVersion>` |
| ASP.NET MVC | 5.2.3 | `packages.config` |
| ASP.NET Razor | 3.2.3 | `packages.config` |
| ASP.NET WebPages | 3.2.3 | `packages.config` |
| System.Web.Optimization (bundling) | 1.1.3 | `packages.config` |
| Azure.Storage.Blobs SDK | 12.9.1 | `packages.config` |
| Azure.Core | 1.18.0 | `packages.config` |
| Newtonsoft.Json | 6.0.8 | `packages.config` |
| Bootstrap | 3.0.0 | `packages.config` |
| jQuery | 1.10.2 | `packages.config` |
| C# Language Version | 6 (via compiler options) | `Web.config` `compilerOptions="/langversion:6"` |
| MSBuild ToolsVersion | 14.0 | `WebApp-Storage-DotNet.csproj` |
| NuGet packages.config format | Legacy (non-SDK-style) | `packages.config` |
| Build tool | MSBuild / Visual Studio | `.csproj` (old-style non-SDK project format) |
