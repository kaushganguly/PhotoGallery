# .NET Upgrade Plan: WebApp-Storage-DotNet

## Overview

Upgrade the **WebApp-Storage-DotNet** project from **.NET Framework 4.8** to **.NET 10** (`net10.0`), the current Long-Term Support (LTS) release.

## Source and Target Versions

| | Version |
|---|---|
| **Source** | .NET Framework 4.8 (`v4.8`) |
| **Target** | .NET 10 (`net10.0`) |

## Projects in Solution

| Project | Path | Current Framework |
|---|---|---|
| WebApp-Storage-DotNet | `WebApp-Storage-DotNet\WebApp-Storage-DotNet.csproj` | .NET Framework 4.8 |

## Upgrade Scope

The upgrade involves the following changes:

1. **SDK-Style Project Conversion**: The current project uses the legacy `.csproj` format (`Microsoft.Common.props` style). It must be converted to the modern SDK-style project format (`<Project Sdk="Microsoft.NET.Sdk.Web">`).

2. **Target Framework Update**: Update `<TargetFrameworkVersion>v4.8</TargetFrameworkVersion>` to `<TargetFramework>net10.0</TargetFramework>`.

3. **ASP.NET MVC to ASP.NET Core**: The project uses ASP.NET MVC 5 (`System.Web.Mvc`), which is not available on modern .NET. Migrate to ASP.NET Core MVC.

4. **NuGet Package Updates**: Update all NuGet packages to their latest versions compatible with `net10.0`, including:
   - `Azure.Storage.Blobs` (upgrade to latest)
   - `Azure.Core` (upgrade to latest)
   - Remove legacy packages (`WebGrease`, `Antlr`, `Microsoft.AspNet.Mvc`, `Microsoft.AspNet.WebPages`, etc.)

5. **API Compatibility Fixes**: Address any breaking changes between .NET Framework 4.8 and .NET 10, including `System.Web` removal, configuration system changes, and Global.asax replacement with `Program.cs`/`Startup.cs`.

6. **Web.config → appsettings.json**: Migrate application configuration from `Web.config` to `appsettings.json`.

## Tasks

1. **001-upgrade-dotnet-to-net10**: Upgrade WebApp-Storage-DotNet from .NET Framework 4.8 to .NET 10
