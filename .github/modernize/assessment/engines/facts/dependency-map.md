# Dependency Map

The `WebApp-Storage-DotNet` project declares 34 NuGet packages in `packages.config`; the map summarizes the external libraries used by the single web application.

## Dependencies

```mermaid
flowchart LR
    App["WebApp Storage DotNet"]
    subgraph Web["Web Frameworks"]
        Mvc["Microsoft.AspNet.Mvc 5.2.3"]
        Razor["Microsoft.AspNet.Razor 3.2.3"]
        Pages["Microsoft.AspNet.WebPages 3.2.3"]
        Optimization["Microsoft.AspNet.Web.Optimization 1.1.3"]
    end
    subgraph Storage["Storage and Data Protocols"]
        Blobs["Azure.Storage.Blobs 12.9.1"]
        AzureCommon["Azure.Storage.Common 12.8.0"]
        AzureCore["Azure.Core 1.18.0"]
        Edm["Microsoft.Data.Edm 5.6.4"]
        OData["Microsoft.Data.OData 5.6.4"]
        DataClient["Microsoft.Data.Services.Client 5.6.4"]
        Spatial["System.Spatial 5.6.4"]
    end
    subgraph Browser["Browser UI"]
        Bootstrap["bootstrap 3.0.0"]
        JQuery["jQuery 1.10.2"]
        JQueryValidation["jQuery.Validation 1.11.1"]
        JQueryUnobtrusive["Microsoft.jQuery.Unobtrusive.Validation 3.2.3"]
        Modernizr["Modernizr 2.6.2"]
        Respond["Respond 1.2.0"]
        WebGrease["WebGrease 1.5.2"]
        Antlr["Antlr 3.4.1.9004"]
    end
    subgraph Platform["Build and Framework Support"]
        AsyncInterfaces["Microsoft.Bcl.AsyncInterfaces 1.0.0"]
        CodeDom["Microsoft.CodeDom.Providers.DotNetCompilerPlatform 1.0.0"]
        Compilers["Microsoft.Net.Compilers 1.0.0"]
        WebInfrastructure["Microsoft.Web.Infrastructure 1.0.0.0"]
    end
    subgraph Runtime["System Runtime Libraries"]
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
    end
    subgraph Other["Other Utilities"]
        Newtonsoft["Newtonsoft.Json 6.0.8"]
    end

    App -->|"web framework"| Web
    App -->|"blob storage"| Storage
    App -->|"browser assets"| Browser
    App -->|"build support"| Platform
    App -->|"runtime support"| Runtime
    App -->|"JSON"| Other
```

### Dependency Summary

| Category | Count | Key Libraries | Notes |
|---|---:|---|---|
| Web Frameworks | 4 | ASP.NET MVC 5.2.3, Razor 3.2.3 | Legacy System.Web stack |
| Storage and Data Protocols | 7 | Azure Storage Blobs 12.9.1, Azure.Core 1.18.0 | Azure Blob client and supporting protocol packages |
| Browser UI | 8 | jQuery 1.10.2, Bootstrap 3.0.0 | Older client-side libraries and validation |
| Build and Framework Support | 4 | CodeDom provider 1.0.0 | Includes the development-only compiler package |
| System Runtime Libraries | 10 | System.Memory 4.5.4, System.Text.Json 4.6.0 | Compatibility libraries for .NET Framework |
| Other Utilities | 1 | Newtonsoft.Json 6.0.8 | Legacy JSON library |

### Version & Compatibility Risks

The project targets .NET Framework 4.8 and uses ASP.NET MVC 5, while several NuGet packages are old, including Newtonsoft.Json 6.0.8, jQuery 1.10.2, and the 1.0.0 compiler tooling. Moving to modern .NET requires replacing the System.Web MVC hosting model and reviewing package compatibility; the current package inventory could not be resolved transitively because the legacy project requires Visual Studio Web Application targets unavailable in this Linux environment.

### Notable Observations

- No central package management or lock file is present; versions are declared in `packages.config`.
- `Azure.Storage.Blobs` is the principal data integration and pulls supporting Azure and data-protocol libraries.
- The project declares both Newtonsoft.Json and System.Text.Json assemblies, although no application-level JSON serialization usage was identified.
- No test dependencies are declared.

## Test Dependencies

| Framework | Version | Notes |
|---|---|---|
| None detected | — | No test project or test-scoped NuGet package is present in the solution. |

Total test-scope dependencies: 0

No test dependencies detected.
