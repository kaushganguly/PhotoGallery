# Dependency Map

The WebApp-Storage-DotNet project declares 34 NuGet packages in `packages.config`. The package CLI could not load the legacy web project on Linux, so this inventory reflects declared package versions and does not include a resolved transitive tree.

## Dependencies

```mermaid
flowchart LR
    App["WebApp-Storage-DotNet"]
    subgraph Web["Web Framework"]
        Mvc["Microsoft.AspNet.Mvc 5.2.3"]
        Razor["Microsoft.AspNet.Razor 3.2.3"]
        Optimization["Microsoft.AspNet.Web.Optimization 1.1.3"]
        WebPages["Microsoft.AspNet.WebPages 3.2.3"]
        Infrastructure["Microsoft.Web.Infrastructure 1.0.0.0"]
        CodeDom["Microsoft.CodeDom.Providers.DotNetCompilerPlatform 1.0.0.0"]
    end
    subgraph Storage["Azure Storage and Data"]
        AzureCore["Azure.Core 1.18.0"]
        Blobs["Azure.Storage.Blobs 12.9.1"]
        StorageCommon["Azure.Storage.Common 12.8.0"]
        Edm["Microsoft.Data.Edm 5.6.4"]
        OData["Microsoft.Data.OData 5.6.4"]
        DataServices["Microsoft.Data.Services.Client 5.6.4"]
        Spatial["System.Spatial 5.6.4"]
    end
    subgraph Browser["Browser UI"]
        Bootstrap["bootstrap 3.0.0"]
        JQuery["jQuery 1.10.2"]
        JQueryValidation["jQuery.Validation 1.11.1"]
        Unobtrusive["Microsoft.jQuery.Unobtrusive.Validation 3.2.3"]
        Modernizr["Modernizr 2.6.2"]
        Respond["Respond 1.2.0"]
    end
    subgraph Runtime["Runtime Support"]
        Async["Microsoft.Bcl.AsyncInterfaces 1.0.0"]
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
    subgraph Utilities["Build and Utilities"]
        Antlr["Antlr 3.4.1.9004"]
        Compilers["Microsoft.Net.Compilers 1.0.0"]
        Newtonsoft["Newtonsoft.Json 6.0.8"]
        WebGrease["WebGrease 1.5.2"]
    end

    App -->|"web"| Web
    App -->|"storage"| Storage
    App -->|"browser assets"| Browser
    App -->|"runtime support"| Runtime
    App -->|"build and utilities"| Utilities
```

### Dependency Summary

| Category | Count | Key Libraries | Notes |
|---|---:|---|---|
| Web Framework | 6 | ASP.NET MVC, Razor, WebPages, Web Optimization | Classic `System.Web` MVC stack |
| Azure Storage and Data | 7 | Azure.Storage.Blobs, Azure.Core, Azure.Storage.Common | Blob storage SDK plus legacy OData-related packages |
| Browser UI | 6 | Bootstrap, jQuery, jQuery Validation | Browser libraries are substantially dated |
| Runtime Support | 11 | System.Memory, System.Text.Json, System.Buffers | Compatibility libraries declared for .NET Framework |
| Build and Utilities | 4 | Newtonsoft.Json, Microsoft.Net.Compilers, Antlr, WebGrease | Includes an old compiler package and JSON library |

### Version & Compatibility Risks

The package set contains multiple known vulnerable versions: `Microsoft.Data.OData` 5.6.4, jQuery Validation 1.11.1, Newtonsoft.Json 6.0.8, Bootstrap 3.0.0, jQuery 1.10.2, and Azure.Storage.Blobs 12.9.1. The separate advisory report records the applicable GitHub Security Advisories and patched versions. The project targets .NET Framework 4.8 and uses legacy non-SDK project infrastructure, which limits modern cross-platform build and upgrade tooling.

### Notable Observations

- Dependency resolution could not run because `Microsoft.WebApplication.targets` is unavailable in the Linux environment; transitive dependency coverage is therefore incomplete.
- The app's storage behavior is built around Azure Blob Storage rather than a relational database or ORM.
- No test-scoped package dependencies are declared.
- The project references both Newtonsoft.Json and System.Text.Json packages.

## Test Dependencies

| Framework | Version | Notes |
|---|---|---|
| None detected | — | No test-scoped packages are declared in `packages.config`. |

Total test-scope dependencies: 0

No test dependencies or test project were detected in the solution.
