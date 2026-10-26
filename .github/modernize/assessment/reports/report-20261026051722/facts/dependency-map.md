# Dependency Map

The `WebApp-Storage-DotNet` project declares 34 packages in `packages.config`. This map focuses on the direct NuGet package declarations; the project uses legacy package references rather than a lock file.

## Dependencies

```mermaid
flowchart LR
    App["WebApp-Storage-DotNet"]
    subgraph Web["Web Frameworks"]
        MVC["Microsoft.AspNet.Mvc 5.2.3"]
        Razor["Microsoft.AspNet.Razor 3.2.3"]
        Pages["Microsoft.AspNet.WebPages 3.2.3"]
        Optimization["Microsoft.AspNet.Web.Optimization 1.1.3"]
    end
    subgraph Azure["Cloud Storage"]
        Blob["Azure.Storage.Blobs 12.9.1"]
        Core["Azure.Core 1.18.0"]
        Common["Azure.Storage.Common 12.8.0"]
    end
    subgraph Runtime["Runtime Compatibility"]
        Async["Microsoft.Bcl.AsyncInterfaces 1.0.0"]
        Json["Newtonsoft.Json 6.0.8"]
        Buffers["System.Buffers 4.5.1"]
        Diagnostics["System.Diagnostics.DiagnosticSource 4.6.0"]
        Memory["System.Memory 4.5.4"]
        MemoryData["System.Memory.Data 1.0.2"]
        Vectors["System.Numerics.Vectors 4.5.0"]
        Unsafe["System.Runtime.CompilerServices.Unsafe 4.6.0"]
        Encodings["System.Text.Encodings.Web 4.7.2"]
        JsonCore["System.Text.Json 4.6.0"]
        Tasks["System.Threading.Tasks.Extensions 4.5.2"]
        Tuple["System.ValueTuple 4.5.0"]
    end
    subgraph UI["Client UI"]
        Bootstrap["bootstrap 3.0.0"]
        JQuery["jQuery 1.10.2"]
        Validation["jQuery.Validation 1.11.1"]
        Unobtrusive["Microsoft.jQuery.Unobtrusive.Validation 3.2.3"]
        Modernizr["Modernizr 2.6.2"]
        Respond["Respond 1.2.0"]
    end
    subgraph DataClients["Legacy Data Client Packages"]
        Edm["Microsoft.Data.Edm 5.6.4"]
        OData["Microsoft.Data.OData 5.6.4"]
        ServicesClient["Microsoft.Data.Services.Client 5.6.4"]
        Spatial["System.Spatial 5.6.4"]
    end
    subgraph Build["Build and Compiler Support"]
        WebGrease["WebGrease 1.5.2"]
        Antlr["Antlr 3.4.1.9004"]
        CodeDom["Microsoft.CodeDom.Providers.DotNetCompilerPlatform 1.0.0"]
        Compilers["Microsoft.Net.Compilers 1.0.0"]
        Infrastructure["Microsoft.Web.Infrastructure 1.0.0.0"]
    end

    App -->|"web framework"| Web
    App -->|"cloud storage"| Azure
    App -->|"runtime support"| Runtime
    App -->|"browser UI"| UI
    App -->|"data client compatibility"| DataClients
    App -->|"build and compiler"| Build
    Blob -.->|"SDK dependency"| Core
    Blob -.->|"SDK dependency"| Common
```

### Dependency Summary

| Category | Count | Key Libraries | Notes |
|---|---:|---|---|
| Web Frameworks | 4 | ASP.NET MVC 5.2.3, Razor 3.2.3, WebPages 3.2.3 | Classic ASP.NET MVC stack |
| Cloud Storage | 3 | Azure.Storage.Blobs 12.9.1, Azure.Core 1.18.0 | Azure SDK is the application’s persistence client |
| Runtime Compatibility | 12 | Newtonsoft.Json 6.0.8, System.Memory 4.5.4, System.Text.Json 4.6.0 | Includes compatibility packages for .NET Framework |
| Client UI | 6 | Bootstrap 3.0.0, jQuery 1.10.2, jQuery.Validation 1.11.1 | Legacy browser assets |
| Legacy Data Client Packages | 4 | Microsoft.Data.Edm 5.6.4, Microsoft.Data.OData 5.6.4, System.Spatial 5.6.4 | Declared packages; no corresponding relational data layer is used by this app |
| Build and Compiler Support | 5 | WebGrease 1.5.2, Antlr 3.4.1.9004, CodeDom provider 1.0.0 | Build, bundling, and compiler support |

### Version & Compatibility Risks

The application targets .NET Framework 4.8 and uses older MVC, Razor, JSON, jQuery, and Bootstrap package versions. The legacy non-SDK project format and Visual Studio Web Application targets also constrain cross-platform builds and modernization to newer .NET versions.

### Notable Observations

- `packages.config` lists 34 package declarations; all 34 are shown in the diagram. No test-scoped dependencies or package lock file were found.
- Azure Blob Storage is the only application-specific persistence dependency.
- Legacy jQuery 1.10.2, Bootstrap 3.0.0, and Newtonsoft.Json 6.0.8 are notable modernization and maintenance risks.

## Test Dependencies

| Framework | Version | Notes |
|---|---|---|
| None detected | — | No test project or test-scoped package declarations were found. |

Total test-scope dependencies: 0

No test dependencies detected.
