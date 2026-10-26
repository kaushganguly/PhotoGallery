# Dependency Map

PhotoGallery declares 34 NuGet dependencies in `WebApp-Storage-DotNet/packages.config`; no lock file is present to resolve a transitive dependency tree.

## Dependencies

```mermaid
flowchart LR
    App["PhotoGallery"]
    subgraph Web["Web Frameworks"]
        Mvc["Microsoft.AspNet.Mvc 5.2.3"]
        Razor["Microsoft.AspNet.Razor 3.2.3"]
        WebPages["Microsoft.AspNet.WebPages 3.2.3"]
        Optimization["Microsoft.AspNet.Web.Optimization 1.1.3"]
        CodeDom["Microsoft.CodeDom.Providers.DotNetCompilerPlatform 1.0.0"]
        WebInfra["Microsoft.Web.Infrastructure 1.0.0.0"]
        WebGrease["WebGrease 1.5.2"]
        Antlr["Antlr 3.4.1.9004"]
    end
    subgraph Storage["Cloud Storage"]
        AzureCore["Azure.Core 1.18.0"]
        Blobs["Azure.Storage.Blobs 12.9.1"]
        StorageCommon["Azure.Storage.Common 12.8.0"]
    end
    subgraph Browser["Browser Libraries"]
        Bootstrap["bootstrap 3.0.0"]
        JQuery["jQuery 1.10.2"]
        JQueryValidation["jQuery.Validation 1.11.1"]
        Unobtrusive["Microsoft.jQuery.Unobtrusive.Validation 3.2.3"]
        Modernizr["Modernizr 2.6.2"]
        Respond["Respond 1.2.0"]
    end
    subgraph OData["Data and OData"]
        Edm["Microsoft.Data.Edm 5.6.4"]
        ODataLib["Microsoft.Data.OData 5.6.4"]
        DataClient["Microsoft.Data.Services.Client 5.6.4"]
        Spatial["System.Spatial 5.6.4"]
    end
    subgraph Utilities["Utilities and Runtime"]
        AsyncInterfaces["Microsoft.Bcl.AsyncInterfaces 1.0.0"]
        Compilers["Microsoft.Net.Compilers 1.0.0"]
        Json["Newtonsoft.Json 6.0.8"]
        Buffers["System.Buffers 4.5.1"]
        Diagnostics["System.Diagnostics.DiagnosticSource 4.6.0"]
        Memory["System.Memory 4.5.4"]
        MemoryData["System.Memory.Data 1.0.2"]
        Vectors["System.Numerics.Vectors 4.5.0"]
        Unsafe["System.Runtime.CompilerServices.Unsafe 4.6.0"]
        Encodings["System.Text.Encodings.Web 4.7.2"]
        TextJson["System.Text.Json 4.6.0"]
        TaskExtensions["System.Threading.Tasks.Extensions 4.5.2"]
        ValueTuple["System.ValueTuple 4.5.0"]
    end
    App -->|"web stack"| Web
    App -->|"object storage"| Storage
    App -->|"browser assets"| Browser
    App -->|"legacy data libraries"| OData
    App -->|"runtime support"| Utilities
```

### Dependency Summary

| Category | Count | Key Libraries | Notes |
|---|---:|---|---|
| Web Frameworks | 8 | ASP.NET MVC, Razor, WebPages | Legacy ASP.NET MVC 5 stack |
| Cloud Storage | 3 | Azure.Storage.Blobs, Azure.Core | Azure object storage integration |
| Browser Libraries | 6 | jQuery, Bootstrap, jQuery.Validation | Older client-side dependencies |
| Data and OData | 4 | Microsoft.Data.OData, Microsoft.Data.Edm | Legacy OData client stack |
| Utilities and Runtime | 13 | Newtonsoft.Json, System.Memory, System.Text.Json | Includes runtime support and compiler tooling |

### Version & Compatibility Risks

The project targets .NET Framework 4.8 and depends on older MVC, browser, and OData libraries. The dependency assessment found high-severity advisories affecting jQuery.Validation 1.11.1, Microsoft.Data.OData 5.6.4, and Newtonsoft.Json 6.0.8; the detailed findings are in `security-assessment.md`.

### Notable Observations

- `Microsoft.Net.Compilers` is marked as a development dependency; it is not a test framework.
- Both Newtonsoft.Json and System.Text.Json are declared.
- Dependency-tree collection could not load the legacy project because Visual Studio WebApplication targets are absent in this Linux environment; the inventory reflects `packages.config` declarations.

## Test Dependencies

| Framework | Version | Notes |
|---|---|---|
| None detected | — | No test-scoped packages are declared in `packages.config`. |

Total test-scope dependencies: 0

No test dependencies or test infrastructure are declared in the project package manifest.
