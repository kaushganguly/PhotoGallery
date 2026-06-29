# Projects and dependencies analysis

This document provides a comprehensive overview of the projects and their dependencies in the context of upgrading to .NETCoreApp,Version=v10.0.

## Table of Contents

- [Executive Summary](#executive-Summary)
  - [Highlevel Metrics](#highlevel-metrics)
  - [Projects Compatibility](#projects-compatibility)
  - [Package Compatibility](#package-compatibility)
  - [API Compatibility](#api-compatibility)
  - [Binding Redirect Configuration](#binding-redirect-configuration)
- [Aggregate NuGet packages details](#aggregate-nuget-packages-details)
- [Top API Migration Challenges](#top-api-migration-challenges)
  - [Technologies and Features](#technologies-and-features)
  - [Most Frequent API Issues](#most-frequent-api-issues)
- [Projects Relationship Graph](#projects-relationship-graph)
- [Project Details](#project-details)

  - [WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj)


## Executive Summary

### Highlevel Metrics

| Metric | Count | Status |
| :--- | :---: | :--- |
| Total Projects | 1 | All require upgrade |
| Total NuGet Packages | 34 | 17 need upgrade |
| Total Code Files | 10 |  |
| Total Code Files with Incidents | 4 |  |
| Total Lines of Code | 21 |  |
| Total Number of Issues | 51 |  |
| Estimated LOC to modify | 0+ | at least 0.0% of codebase |

### Projects Compatibility

| Project | Target Framework | Difficulty | Package Issues | API Issues | Binding Issues | Est. LOC Impact | Description |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| [WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | net48 | 🟢 Low | 33 | 0 | 14 |  | ClassicClassLibrary, Sdk Style = False |

### Package Compatibility

| Status | Count | Percentage |
| :--- | :---: | :---: |
| ✅ Compatible | 17 | 50.0% |
| ⚠️ Incompatible | 6 | 17.6% |
| 🔄 Upgrade Recommended | 11 | 32.4% |
| ***Total NuGet Packages*** | ***34*** | ***100%*** |

### API Compatibility

| Category | Count | Impact |
| :--- | :---: | :--- |
| 🔴 Binary Incompatible | 0 | High - Require code changes |
| 🟡 Source Incompatible | 0 | Medium - Needs re-compilation and potential conflicting API error fixing |
| 🔵 Behavioral change | 0 | Low - Behavioral changes that may require testing at runtime |
| ✅ Compatible | 0 |  |
| ***Total APIs Analyzed*** | ***0*** |  |

### Binding Redirect Configuration

| Severity | Count | Description |
| :--- | :---: | :--- |
| 🔴Mandatory | 7 | Must be fixed to avoid runtime failures |
| 🟡Potential | 7 | May cause issues in certain scenarios |
| ***Total Binding Issues*** | ***14*** | ***Across 1 project(s)*** |

## Aggregate NuGet packages details

| Package | Current Version | Suggested Version | Projects | Description |
| :--- | :---: | :---: | :--- | :--- |
| Antlr | 3.4.1.9004 |  | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | Needs to be replaced with Replace with new package Antlr4=4.6.6 |
| Azure.Core | 1.18.0 |  | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | ✅Compatible |
| Azure.Storage.Blobs | 12.9.1 | 12.29.1 | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | NuGet package contains security vulnerability |
| Azure.Storage.Common | 12.8.0 |  | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | ✅Compatible |
| bootstrap | 3.0.0 | 5.3.8 | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | NuGet package contains security vulnerability |
| jQuery | 1.10.2 | 3.7.1 | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | NuGet package contains security vulnerability |
| jQuery.Validation | 1.11.1 | 1.21.0 | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | NuGet package contains security vulnerability |
| Microsoft.AspNet.Mvc | 5.2.3 |  | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | NuGet package functionality is included with framework reference |
| Microsoft.AspNet.Razor | 3.2.3 |  | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | NuGet package functionality is included with framework reference |
| Microsoft.AspNet.Web.Optimization | 1.1.3 |  | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | ⚠️NuGet package is incompatible |
| Microsoft.AspNet.WebPages | 3.2.3 |  | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | NuGet package functionality is included with framework reference |
| Microsoft.Bcl.AsyncInterfaces | 1.0.0 | 10.0.9 | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | NuGet package upgrade is recommended |
| Microsoft.CodeDom.Providers.DotNetCompilerPlatform | 1.0.0 |  | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | NuGet package functionality is included with framework reference |
| Microsoft.Data.Edm | 5.6.4 | 5.8.5 | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | ⚠️Replace with Microsoft.OData.Edm: Use OData v4 model types; adjust EDM model builders |
| Microsoft.Data.OData | 5.6.4 | 5.8.5 | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | ⚠️Replace with Microsoft.OData.Core: Align code with OData v4; adjust URI/query conventions |
| Microsoft.Data.Services.Client | 5.6.4 | 5.8.5 | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | ⚠️Replace with Microsoft.OData.Client: Regenerate client proxy for OData v4; adjust entity operations accordingly |
| Microsoft.jQuery.Unobtrusive.Validation | 3.2.3 |  | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | ⚠️NuGet package is deprecated |
| Microsoft.Net.Compilers | 1.0.0 |  | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | NuGet package functionality is included with framework reference |
| Microsoft.Web.Infrastructure | 1.0.0.0 |  | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | NuGet package functionality is included with framework reference |
| Modernizr | 2.6.2 |  | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | ✅Compatible |
| Newtonsoft.Json | 6.0.8 | 13.0.4 | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | NuGet package upgrade is recommended |
| Respond | 1.2.0 |  | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | ✅Compatible |
| System.Buffers | 4.5.1 |  | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | NuGet package functionality is included with framework reference |
| System.Diagnostics.DiagnosticSource | 4.6.0 | 10.0.9 | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | NuGet package upgrade is recommended |
| System.Memory | 4.5.4 |  | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | NuGet package functionality is included with framework reference |
| System.Memory.Data | 1.0.2 | 10.0.9 | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | NuGet package upgrade is recommended |
| System.Numerics.Vectors | 4.5.0 |  | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | NuGet package functionality is included with framework reference |
| System.Runtime.CompilerServices.Unsafe | 4.6.0 | 6.1.2 | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | NuGet package upgrade is recommended |
| System.Spatial | 5.6.4 | 5.8.5 | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | ⚠️Replace with Microsoft.Spatial: Use OData v4 spatial types; adjust namespaces for geography/geometric classes |
| System.Text.Encodings.Web | 4.7.2 | 10.0.9 | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | NuGet package upgrade is recommended |
| System.Text.Json | 4.6.0 | 10.0.9 | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | NuGet package upgrade is recommended |
| System.Threading.Tasks.Extensions | 4.5.2 |  | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | NuGet package functionality is included with framework reference |
| System.ValueTuple | 4.5.0 |  | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | NuGet package functionality is included with framework reference |
| WebGrease | 1.5.2 |  | [WebApp-Storage-DotNet.csproj](#webapp-storage-dotnetwebapp-storage-dotnetcsproj) | ✅Compatible |

## Top API Migration Challenges

### Technologies and Features

| Technology | Issues | Percentage | Migration Path |
| :--- | :---: | :---: | :--- |

### Most Frequent API Issues

| API | Count | Percentage | Category |
| :--- | :---: | :---: | :--- |

## Projects Relationship Graph

Legend:
📦 SDK-style project
⚙️ Classic project

```mermaid
flowchart LR

```

## Project Details

