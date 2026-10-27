# Dependency Map

PhotoGallery declares 34 NuGet packages in `WebApp-Storage-DotNet/packages.config`. The dependency list reflects declared versions; resolution of transitive packages was unavailable because the legacy WebApplication MSBuild targets are missing on this runner.

## Dependencies

```mermaid
flowchart LR
    App["PhotoGallery"]
    subgraph Web["Web Frameworks"]
        MVC["Microsoft.AspNet.Mvc 5.2.3"]
        Razor["Microsoft.AspNet.Razor 3.2.3"]
        WebPages["Microsoft.AspNet.WebPages 3.2.3"]
        Optimization["Microsoft.AspNet.Web.Optimization 1.1.3"]
        Infrastructure["Microsoft.Web.Infrastructure 1.0.0.0"]
        CodeDom["Microsoft.CodeDom.Providers.DotNetCompilerPlatform 1.0.0"]
    end
    subgraph Azure["Cloud Storage"]
        Blobs["Azure.Storage.Blobs 12.9.1"]
        AzureCommon["Azure.Storage.Common 12.8.0"]
        AzureCore["Azure.Core 1.18.0"]
    end
    subgraph UI["Client UI and Validation"]
        Bootstrap["bootstrap 3.0.0"]
        JQuery["jQuery 1.10.2"]
        JQueryValidation["jQuery.Validation 1.11.1"]
        Unobtrusive["Microsoft.jQuery.Unobtrusive.Validation 3.2.3"]
        Modernizr["Modernizr 2.6.2"]
        Respond["Respond 1.2.0"]
    end
    subgraph Data["Data and Serialization"]
        Newtonsoft["Newtonsoft.Json 6.0.8"]
        TextJson["System.Text.Json 4.6.0"]
        Edm["Microsoft.Data.Edm 5.6.4"]
        OData["Microsoft.Data.OData 5.6.4"]
        DataClient["Microsoft.Data.Services.Client 5.6.4"]
        Spatial["System.Spatial 5.6.4"]
    end
    subgraph Runtime["Runtime Support"]
        Antlr["Antlr 3.4.1.9004"]
        Compilers["Microsoft.Net.Compilers 1.0.0"]
        Async["Microsoft.Bcl.AsyncInterfaces 1.0.0"]
        Buffers["System.Buffers 4.5.1"]
        Diagnostic["System.Diagnostics.DiagnosticSource 4.6.0"]
        Memory["System.Memory 4.5.4"]
        MemoryData["System.Memory.Data 1.0.2"]
        Vectors["System.Numerics.Vectors 4.5.0"]
        Unsafe["System.Runtime.CompilerServices.Unsafe 4.6.0"]
        Encodings["System.Text.Encodings.Web 4.7.2"]
        Tasks["System.Threading.Tasks.Extensions 4.5.2"]
        Tuples["System.ValueTuple 4.5.0"]
        WebGrease["WebGrease 1.5.2"]
    end

    App -->|"MVC stack"| Web
    App -->|"photo storage"| Azure
    App -->|"browser UI"| UI
    App -->|"data libraries"| Data
    App -->|"runtime libraries"| Runtime
```

### Dependency Summary

| Category | Count | Key Libraries | Notes |
|---|---:|---|---|
| Web Frameworks | 6 | ASP.NET MVC 5.2.3, Razor 3.2.3 | Legacy .NET Framework MVC stack |
| Cloud Storage | 3 | Azure.Storage.Blobs 12.9.1 | External object storage integration |
| Client UI and Validation | 6 | Bootstrap 3.0.0, jQuery 1.10.2 | Legacy browser libraries |
| Data and Serialization | 6 | Newtonsoft.Json 6.0.8, System.Text.Json 4.6.0 | JSON and OData support |
| Runtime Support | 13 | System.Memory, System.Buffers, WebGrease | Compatibility and compiler/runtime support |

### Version & Compatibility Risks

The application targets .NET Framework 4.8 and uses an older MVC 5 stack. Several client libraries and JSON packages are old; the dependency scan found known advisories affecting declared package versions. The full transitive dependency graph could not be resolved on this Linux runner because Visual Studio WebApplication MSBuild targets are unavailable.

### Notable Observations

- Both Newtonsoft.Json and System.Text.Json are declared.
- Microsoft.Net.Compilers and the CodeDom provider are old build-time compiler dependencies.
- No test-scoped packages are declared in `packages.config`.

## Test Dependencies

| Framework | Version | Notes |
|---|---|---|
| None detected | — | No test-scoped packages or test project found |

Total test-scope dependencies: 0

No test dependencies were detected in the solution.
