# Modernization Summary: 001-upgrade-dotnet-10

## Task
Upgrade from .NET Framework 4.8 (ASP.NET MVC 5) to .NET 10 (ASP.NET Core MVC).

## Status
COMPLETE - Build passes on .NET 10 with 0 errors and 0 warnings.

## Changes Made

### Project File (WebApp-Storage-DotNet.csproj)
- Replaced legacy MSBuild XML format with SDK-style `<Project Sdk="Microsoft.NET.Sdk.Web">`
- Changed TargetFrameworkVersion v4.8 to net10.0
- Enabled Nullable and ImplicitUsings
- Replaced packages.config/HintPath references with PackageReference (Azure.Storage.Blobs 12.22.0)
- Removed all explicit Reference, Content, Compile item groups (SDK auto-discovers)

### Program.cs (New - replaces Global.asax.cs)
- ASP.NET Core minimal hosting model
- Registers AddControllersWithViews()
- Configures static files middleware for legacy Content/, Scripts/, Images/, fonts/ folders
  using PhysicalFileProvider (preserving existing folder structure)
- Sets up default MVC route: {controller=Home}/{action=Index}/{id?}

### appsettings.json / appsettings.Development.json (New - replaces Web.config)
- StorageConnectionString migrated from Web.config appSettings

### Controllers/HomeController.cs
- Removed System.Web, System.Web.Mvc, System.Configuration imports
- Added Microsoft.AspNetCore.Mvc, Microsoft.AspNetCore.Http, Microsoft.Extensions.Configuration
- Changed ActionResult to IActionResult
- Constructor injects IConfiguration (replaces ConfigurationManager.AppSettings)
- File upload: HttpFileCollectionBase/Request.Files -> IFormFileCollection/Request.Form.Files
- Fixed upload stream: blob.UploadAsync(filename) -> blob.UploadAsync(file.OpenReadStream())
- Added null-safe GetBlobContainer() helper with nullable annotations

### Views/Shared/_Layout.cshtml
- Removed Styles.Render() and Scripts.Render() (System.Web.Optimization - not in ASP.NET Core)
- Replaced with direct <link> and <script> static file references

### Views/_ViewImports.cshtml (New)
- @using WebApp_Storage_DotNet
- @using Microsoft.AspNetCore.Mvc.Rendering
- @addTagHelper *, Microsoft.AspNetCore.Mvc.TagHelpers

### Views/Home/Index.cshtml
- Added @model List<Uri> strongly-typed model declaration

## Files Deleted
| File | Reason |
|------|--------|
| Global.asax / Global.asax.cs | Replaced by Program.cs |
| packages.config | Replaced by PackageReference in csproj |
| Web.config | Replaced by appsettings.json |
| Views/Web.config | Not needed in ASP.NET Core |
| App_Start/BundleConfig.cs | System.Web.Optimization not available in ASP.NET Core |
| App_Start/FilterConfig.cs | Filters configured via middleware in Program.cs |
| App_Start/RouteConfig.cs | Routing configured in Program.cs via MapControllerRoute |
| Properties/AssemblyInfo.cs | SDK-style projects auto-generate assembly attributes |

## Package Replacements
| Old | New |
|-----|-----|
| Microsoft.AspNet.Mvc 5.2.3 | ASP.NET Core MVC (framework-included in net10.0) |
| Microsoft.AspNet.Razor 3.2.3 | Included in framework |
| Microsoft.AspNet.Web.Optimization 1.1.3 | Removed (direct static links) |
| Microsoft.AspNet.WebPages 3.2.3 | Included in framework |
| Microsoft.Web.Infrastructure 1.0.0 | Removed |
| Microsoft.CodeDom.Providers / Microsoft.Net.Compilers | Removed (Roslyn in SDK) |
| Azure.Storage.Blobs 12.9.1 | Azure.Storage.Blobs 12.22.0 |
| Various System.* polyfills | Removed (built into .NET 10) |

## Build Result
Build succeeded. 0 Warning(s). 0 Error(s).
Target: net10.0 | Output: bin\Debug\net10.0\WebApp-Storage-DotNet.dll