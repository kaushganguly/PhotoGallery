# .NET Upgrade Plan: WebApp-Storage-DotNet

## Overview

Upgrade the **WebApp-Storage-DotNet** project from **.NET Framework 4.8** to **.NET 10.0** (latest LTS), as explicitly requested by the user.

## Source and Target Versions

| | Version |
|---|---|
| **Source** | .NET Framework 4.8 (`v4.8`) |
| **Target** | .NET 10.0 (`net10.0`) |

## Projects in Solution

| Project | Path | Current Framework |
|---------|------|-------------------|
| WebApp-Storage-DotNet | `WebApp-Storage-DotNet\WebApp-Storage-DotNet.csproj` | .NET Framework 4.8 |

## Upgrade Scope

This upgrade involves migrating a legacy ASP.NET MVC 5 web application from .NET Framework 4.8 to .NET 10.0. The key areas of change include:

1. **SDK-style project file conversion**: The current `.csproj` uses the legacy non-SDK format (MSBuild `ToolsVersion="14.0"`). It must be converted to the modern SDK-style format.

2. **ASP.NET MVC → ASP.NET Core**: The application uses `System.Web`-based ASP.NET MVC 5 (`Microsoft.AspNet.Mvc 5.2.3`), which is not available on .NET 10. Migration to ASP.NET Core MVC is required.

3. **NuGet package updates**: Legacy packages (e.g., `Newtonsoft.Json 6.0.8`, `WebGrease`, `Antlr`, ASP.NET WebPages/Razor/Optimization) must be replaced or removed. Azure Storage SDK references (`Azure.Storage.Blobs`, `Azure.Core`) should be updated to their latest versions.

4. **`System.Web` dependency removal**: All references to `System.Web`, `System.Web.Mvc`, `System.Web.Optimization`, `Global.asax`, and related types must be replaced with ASP.NET Core equivalents.

5. **Configuration migration**: `Web.config` must be migrated to `appsettings.json` / `Program.cs` / `Startup` patterns for ASP.NET Core.

6. **API compatibility fixes**: Update any code using .NET Framework APIs that differ or are unavailable in .NET 10.

## Tasks

- **001-upgrade-dotnet-to-net10**: Upgrade WebApp-Storage-DotNet from .NET Framework 4.8 to .NET 10.0
