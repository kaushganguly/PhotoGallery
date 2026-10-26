# Configuration & Externalized Settings Inventory

The application uses XML configuration in two files, with one local IIS Express development profile and Debug/Release build configurations. A sample local storage setting is checked in; no dedicated secrets store or environment-specific runtime configuration was identified.

## Configuration Sources

| Source | Type | Path/Location | Notes |
|---|---|---|---|
| Application configuration | ASP.NET XML configuration | `WebApp-Storage-DotNet/Web.config` | App settings, runtime options, compiler settings, and assembly binding redirects |
| Razor configuration | ASP.NET XML configuration | `WebApp-Storage-DotNet/Views/Web.config` | Razor host and view namespace configuration |
| Project configuration | MSBuild XML | `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj` | Target framework, Debug/Release settings, and local IIS Express port |
| Solution configuration | Visual Studio solution | `WebApp-Storage-DotNet.sln` | Maps the project to Debug and Release solution configurations |
| Package manifest | NuGet XML | `WebApp-Storage-DotNet/packages.config` | Declares package versions |

No environment-specific `Web.{Environment}.config`, appsettings JSON, external configuration server, container configuration, or secret-store reference was found. The project file references Web.Debug.config and Web.Release.config, but these transform files are not present in the checked-out project.

## Build Profiles

| Profile | Activation | Purpose | Key Dependencies/Plugins |
|---|---|---|---|
| Debug | MSBuild `Debug` configuration | Debug symbols enabled; optimization disabled; defines `DEBUG` and `TRACE` | .NET Framework 4.8 project targets and legacy ASP.NET Web Application targets |
| Release | MSBuild `Release` configuration | Optimized build; defines `TRACE` | Same project references and targets as Debug |

The solution supports `Any CPU`; no additional build-time package profiles were identified.

## Runtime Profiles

| Profile | Activation Method | Config Files | Key Overrides |
|---|---|---|---|
| Local development | IIS Express project settings | `Web.config`, project file | Uses the sample development storage endpoint; IIS Express port is 20050 |
| Other environments | Not specified | No environment-specific transform present | No explicit environment overrides identified |

## Properties Inventory

### WebApp-Storage-DotNet

| Property Key | Default | Profiles | Source |
|---|---|---|---|
| `StorageConnectionString` | `UseDevelopmentStorage=true` | Base configuration | `Web.config` |
| `webpages:Version` | `3.0.0.0` | Base configuration | `Web.config` |
| `webpages:Enabled` | `false` | Base configuration | `Web.config` |
| `ClientValidationEnabled` | `true` | Base configuration | `Web.config` |
| `UnobtrusiveJavaScriptEnabled` | `true` | Base configuration | `Web.config` |
| `system.web/compilation@debug` | `true` | Base configuration | `Web.config` |
| `system.web/compilation@targetFramework` | `4.8` | Base configuration | `Web.config` |
| `system.web/httpRuntime@targetFramework` | `4.5.2` | Base configuration | `Web.config` |
| `system.web/httpRuntime@maxRequestLength` | `2100000000` | Base configuration | `Web.config` |
| `system.web/httpRuntime@executionTimeout` | `12000000` | Base configuration | `Web.config` |
| `DevelopmentServerPort` | `20050` | Local IIS Express | Project file |

`Web.config` also contains assembly binding redirects for ASP.NET MVC, Newtonsoft.Json, WebGrease, and selected System and Azure assemblies. The project file targets .NET Framework 4.8, while the `httpRuntime` setting declares 4.5.2.

## Startup Parameters & Resource Requirements

| Service | JVM/Runtime Options | Memory | Instance Count |
|---|---|---|---|
| WebApp-Storage-DotNet | IIS/IIS Express; no JVM or explicit process startup arguments found | Not specified | Not specified |

## Startup Dependency Chain

1. IIS or IIS Express must host the ASP.NET application.
2. The application requires a reachable Azure Blob Storage endpoint when gallery operations access storage.

No readiness probe, startup wait mechanism, or dependency timeout configuration was identified.

## Secrets & Sensitive Configuration

| Secret Reference | Type | Storage (masked) |
|---|---|---|
| `StorageConnectionString` | Potential storage credential | Checked-in value is the local development emulator setting; production credential source is not specified |

No actual storage account key or credential is present in the inspected configuration. The connection string should be supplied securely for non-local deployments; no encryption mechanism or secret-store integration is configured in the repository.

### Secrets Provisioning Workflow

No deployment or secret provisioning workflow is documented. The application reads its storage connection string from configuration; a deployment must provide a non-development value through a secure configuration mechanism, but no identity model or provisioning sequence is specified here.

## Feature Flags

No feature-flag framework or application feature toggles were identified.

| Flag Name | Default | Controlled By |
|---|---|---|
| None identified | — | — |

## Framework & Runtime Versions

| Component | Version | Source |
|---|---|---|
| .NET Framework | 4.8 | Project file |
| ASP.NET MVC | 5.2.3 | `packages.config` |
| ASP.NET Razor | 3.2.3 | `packages.config` |
| Azure.Storage.Blobs | 12.9.1 | `packages.config` |
| IIS Express | Not specified | Project file |
| Visual Studio solution format | 12.00; Visual Studio version 14.0 declared | Solution file |
| MSBuild Web Application targets | Visual Studio tooling targets | Project file |
