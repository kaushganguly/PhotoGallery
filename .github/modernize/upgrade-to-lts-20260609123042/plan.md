# .NET Upgrade Plan: .NET Framework 4.8 → .NET 10.0

## Overview

Upgrade the **PhotoGallery** application (`WebApp-Storage-DotNet`) from **.NET Framework 4.8** to **.NET 10.0 LTS**.

The user has explicitly requested an upgrade to the latest LTS version. .NET 10.0 is the current latest Long-Term Support (LTS) release, providing long-term support, modern performance improvements, and full compatibility with the latest Azure SDK packages.

## Source and Target

| | Version |
|---|---|
| **Source** | .NET Framework 4.8 (`v4.8`) |
| **Target** | .NET 10.0 (`net10.0`) |

## Projects in Solution

| Project | Path | Type |
|---|---|---|
| `WebApp-Storage-DotNet` | `WebApp-Storage-DotNet\WebApp-Storage-DotNet.csproj` | ASP.NET MVC 5 Web Application (.NET Framework, old-style csproj) |

## What the Upgrade Entails

1. **SDK-style project conversion**: The `.csproj` file uses the legacy non-SDK format. It must be converted to the modern SDK-style format (`<Project Sdk="Microsoft.NET.Sdk.Web">`).

2. **Target Framework Moniker (TFM) update**: Change `<TargetFrameworkVersion>v4.8</TargetFrameworkVersion>` to `<TargetFramework>net10.0</TargetFramework>`.

3. **Web framework migration**: ASP.NET MVC 5 (`System.Web.Mvc`) is not supported on .NET 10. The application must be migrated to **ASP.NET Core MVC**.

4. **NuGet package updates**: All NuGet references must be updated to their .NET 10.0-compatible versions, including:
   - `Azure.Storage.Blobs` and `Azure.Core` (already modern Azure SDK — update to latest)
   - Remove legacy packages: `Microsoft.AspNet.Mvc`, `Microsoft.AspNet.WebPages`, `Microsoft.AspNet.Razor`, `WebGrease`, `Antlr`, `Microsoft.Net.Compilers`, `Microsoft.CodeDom.Providers.DotNetCompilerPlatform`
   - Remove `packages.config` (replaced by SDK-style package references)

5. **API compatibility fixes**: Address any `System.Web` dependencies (e.g., `HttpContext`, `HttpRequest`) by replacing with ASP.NET Core equivalents.

6. **Configuration migration**: Migrate `Web.config` settings to `appsettings.json` / `Program.cs` / `Startup` pattern.

## Tasks

- `001-upgrade-dotnet-to-net10`: Upgrade WebApp-Storage-DotNet from .NET Framework 4.8 to .NET 10.0
