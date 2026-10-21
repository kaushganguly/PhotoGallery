# Dependency Map

The `WebApp-Storage-DotNet` project declares 34 NuGet dependencies in `WebApp-Storage-DotNet/packages.config`. The list includes application, browser, Azure Storage, and framework support packages; no test-only packages are declared.

## Dependencies

```mermaid
flowchart LR
    App["WebApp-Storage-DotNet"]
    subgraph Web["Web Frameworks"]
        Mvc["Microsoft.AspNet.Mvc 5.2.3"]
        Razor["Microsoft.AspNet.Razor 3.2.3"]
        WebPages["Microsoft.AspNet.WebPages 3.2.3"]
        Optimization["Microsoft.AspNet.Web.Optimization 1.1.3"]
        CodeDom["Microsoft.CodeDom.Providers.DotNetCompilerPlatform 1.0.0"]
    end
    subgraph Azure["Azure Storage"]
        AzureCore["Azure.Core 1.18.0"]
        Blobs["Azure.Storage.Blobs 12.9.1"]
        StorageCommon["Azure.Storage.Common 12.8.0"]
    end
    subgraph Browser["Browser UI"]
        Bootstrap["bootstrap 3.0.0"]
        JQuery["jQuery 1.10.2"]
        JQueryValidation["jQuery.Validation 1.11.1"]
        Unobtrusive["Microsoft.jQuery.Unobtrusive.Validation 3.2.3"]
        Modernizr["Modernizr 2.6.2"]
        Respond["Respond 1.2.0"]
    end
    subgraph OData["Legacy OData Support"]
        Edm["Microsoft.Data.Edm 5.6.4"]
        OData["Microsoft.Data.OData 5.6.4"]
        DataClient["Microsoft.Data.Services.Client 5.6.4"]
        Spatial["System.Spatial 5.6.4"]
    end
    subgraph Runtime["Utilities and Runtime Support"]
        Antlr["Antlr 3.4.1.9004"]
        Async["Microsoft.Bcl.AsyncInterfaces 1.0.0"]
        Compilers["Microsoft.Net.Compilers 1.0.0"]
        WebInfrastructure["Microsoft.Web.Infrastructure 1.0.0.0"]
        JsonNet["Newtonsoft.Json 6.0.8"]
        Buffers["System.Buffers 4.5.1"]
        Diagnostics["System.Diagnostics.DiagnosticSource 4.6.0"]
        Memory["System.Memory 4.5.4"]
        MemoryData["System.Memory.Data 1.0.2"]
        Vectors["System.Numerics.Vectors 4.5.0"]
        Unsafe["System.Runtime.CompilerServices.Unsafe 4.6.0"]
        Encodings["System.Text.Encodings.Web 4.7.2"]
        Json["System.Text.Json 4.6.0"]
        Tasks["System.Threading.Tasks.Extensions 4.5.2"]
        Tuples["System.ValueTuple 4.5.0"]
        WebGrease["WebGrease 1.5.2"]
    end
    App -->|"web"| Web
    App -->|"blob operations"| Azure
    App -->|"browser assets"| Browser
    App -->|"legacy support"| OData
    App -->|"runtime support"| Runtime
```

### Dependency Summary

| Category | Count | Key Libraries | Notes |
|---|---:|---|---|
| Web Frameworks | 5 | ASP.NET MVC 5.2.3, Razor 3.2.3 | Legacy ASP.NET MVC application |
| Azure Storage | 3 | Azure.Storage.Blobs 12.9.1 | Blob client and shared Azure SDK support |
| Browser UI | 6 | jQuery 1.10.2, Bootstrap 3.0.0 | Older browser libraries and validation scripts |
| Legacy OData Support | 4 | Microsoft.Data.OData 5.6.4 | Legacy OData-era components |
| Utilities and Runtime Support | 16 | Newtonsoft.Json 6.0.8, System.Text.Json 4.6.0 | Compiler, framework, and low-level support packages |

### Version & Compatibility Risks

The project targets .NET Framework 4.8 and uses an older MVC 5 stack. Several declared browser and utility packages are dated, including jQuery 1.10.2, Bootstrap 3.0.0, Newtonsoft.Json 6.0.8, and Microsoft.Data.OData 5.6.4. The classic non-SDK project format and Visual Studio Web Application targets also constrain cross-platform assessment and modernization.

### Notable Observations

- The dependencies are declared through `packages.config`; there is no central package management or lock file.
- The project includes both Newtonsoft.Json and System.Text.Json support assemblies.
- The declared Azure Blob SDK is a later-generation package than the older MVC and OData components.
- The package list includes no test frameworks or test-scoped dependencies.

## Test Dependencies

| Framework | Version | Notes |
|---|---|---|
| None detected | — | No test project or test-scoped package is declared |

Total test-scope dependencies: 0

No test dependencies are declared in the project package manifest.
