# .NET Upgrade Plan: WebApp-Storage-DotNet

## Overview

| Item | Value |
|------|-------|
| Source .NET version | .NET Framework 4.8 |
| Target .NET version | .NET 10 (`net10.0`) — latest LTS |
| Solution file | `WebApp-Storage-DotNet.sln` |
| Projects | `WebApp-Storage-DotNet` (ASP.NET MVC 5 web application) |

## Why Upgrade

- The project targets the classic **.NET Framework (non-SDK-style project)**, which is out of mainstream feature development and does not receive modern platform/runtime improvements, cross-platform support, or performance gains available in current .NET releases.
- User explicitly requested upgrading to the latest LTS version.
- Upgrading to **.NET 10 (LTS)** provides long-term support, improved performance, modern tooling, and continued compatibility with current Azure SDK packages (`Azure.Core`, `Azure.Storage.Blobs`, `Azure.Storage.Common`) already referenced by the project.

## Scope of Work

The single project in the solution requires a full modernization pass:

1. **SDK-style project conversion** — convert `WebApp-Storage-DotNet.csproj` from the legacy (non-SDK) MSBuild format to the modern SDK-style format.
2. **Target Framework Moniker (TFM) update** — change from `v4.8` to `net10.0`.
3. **ASP.NET MVC → ASP.NET Core MVC migration** — the project uses `System.Web.Mvc`, `System.Web.Optimization`, `Global.asax`, and `Web.config`-based configuration, none of which are supported on modern .NET. These must be migrated to ASP.NET Core equivalents (`Program.cs`/minimal hosting, ASP.NET Core MVC, `appsettings.json` configuration, built-in bundling/minification or client-side tooling).
4. **NuGet dependency modernization** — replace `packages.config` with `PackageReference`, and update/replace packages incompatible with modern .NET (e.g., `Microsoft.AspNet.Mvc`, `Microsoft.AspNet.WebPages`, `Microsoft.AspNet.Web.Optimization`, `Microsoft.CodeDom.Providers.DotNetCompilerPlatform`), while retaining/upgrading the Azure Storage SDK packages (`Azure.Storage.Blobs`, `Azure.Core`).
5. **API compatibility fixes** — address any breaking API changes surfaced by the framework and library upgrades (e.g., routing, filters, bundling, configuration access, Azure SDK usage).

## Projects in Solution

- `WebApp-Storage-DotNet\WebApp-Storage-DotNet.csproj` — ASP.NET MVC 5 web application (.NET Framework 4.8) → upgrade to net10.0 (ASP.NET Core MVC).

## Execution

A single `upgrade` task (see `.metadata/tasks.json`) encompasses all the above changes. Detailed implementation steps are determined by the `modernize-dotnet-upgrade-engineer` agent during execution.
