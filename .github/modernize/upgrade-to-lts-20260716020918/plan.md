# .NET Upgrade Plan: WebApp-Storage-DotNet

## Overview

Upgrade the **PhotoGallery** application from **.NET Framework 4.8** to **.NET 10.0 (LTS)**.

The project is an ASP.NET MVC 5 web application using the legacy non-SDK project format. Migrating to .NET 10.0 requires converting the project file to SDK-style format, replacing the ASP.NET MVC 5 stack with ASP.NET Core, updating all NuGet package references, and resolving any API incompatibilities.

## Source Version

- **Framework**: .NET Framework 4.8
- **Project format**: Legacy (non-SDK)
- **Web framework**: ASP.NET MVC 5 (`System.Web.Mvc`)

## Target Version

- **Framework**: .NET 10.0 (`net10.0`) — latest LTS
- **Project format**: SDK-style
- **Web framework**: ASP.NET Core (MVC)

## Projects in Solution

| Project | Path | Current TFM |
|---------|------|-------------|
| WebApp-Storage-DotNet | `WebApp-Storage-DotNet\WebApp-Storage-DotNet.csproj` | net48 (.NET Framework 4.8) |

## Upgrade Scope

1. **Project file conversion**: Convert legacy non-SDK `.csproj` to SDK-style format
2. **Target framework update**: Change `<TargetFrameworkVersion>v4.8</TargetFrameworkVersion>` to `<TargetFramework>net10.0</TargetFramework>`
3. **Web framework migration**: Replace `System.Web` / ASP.NET MVC 5 with ASP.NET Core MVC
4. **NuGet package updates**: Update all packages to versions compatible with `net10.0` (Azure.Storage.Blobs, Azure.Core, etc.)
5. **API compatibility**: Address any breaking changes (e.g., `System.Web` APIs not available in .NET 10)
6. **Configuration migration**: Move from `Web.config` to `appsettings.json` / `Program.cs` / `Startup.cs` patterns
7. **Build validation**: Ensure the project compiles and all existing tests pass

## Tasks

- `001-upgrade-dotnet-to-net10`: Upgrade WebApp-Storage-DotNet from .NET Framework 4.8 to .NET 10.0
