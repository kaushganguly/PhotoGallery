# Dependency Map

This project is a single .NET web application with 34 declared NuGet dependencies in `packages.config`. The dependency set is centered on the ASP.NET MVC 5 presentation stack and Azure Blob Storage access, with several older support libraries carried by the legacy .NET Framework application model.

## Dependencies

```mermaid
flowchart LR
    App["WebApp-Storage-DotNet"]

    subgraph Web["Web Frameworks"]
        AspNetMvc["Microsoft.AspNet.Mvc 5.2.3"]
        Razor["Microsoft.AspNet.Razor 3.2.3"]
        WebPages["Microsoft.AspNet.WebPages 3.2.3"]
        Optimization["Microsoft.AspNet.Web.Optimization 1.1.3"]
        Bootstrap["bootstrap 3.0.0"]
        JQuery["jQuery 1.10.2"]
        JQueryVal["jQuery.Validation 1.11.1"]
        Unobtrusive["Microsoft.jQuery.Unobtrusive.Validation 3.2.3"]
        Modernizr["Modernizr 2.6.2"]
        Respond["Respond 1.2.0"]
    end
    subgraph Storage["Database and Storage"]
        AzureCore["Azure.Core 1.18.0"]
        AzureBlobs["Azure.Storage.Blobs 12.9.1"]
        AzureCommon["Azure.Storage.Common 12.8.0"]
        OData["Microsoft.Data.OData 5.6.4"]
        DataEdm["Microsoft.Data.Edm 5.6.4"]
        DataClient["Microsoft.Data.Services.Client 5.6.4"]
        Spatial["System.Spatial 5.6.4"]
    end
    subgraph Logging["Logging and Observability"]
        DiagSource["System.Diagnostics.DiagnosticSource 4.6.0"]
    end
    subgraph Utilities["Utilities"]
        Json["Newtonsoft.Json 6.0.8"]
        CodeDom["Microsoft.CodeDom.Providers.DotNetCompilerPlatform 1.0.0"]
        WebInfra["Microsoft.Web.Infrastructure 1.0.0"]
        BclAsync["Microsoft.Bcl.AsyncInterfaces 1.0.0"]
        SysTextJson["System.Text.Json 4.6.0"]
        SysEnc["System.Text.Encodings.Web 4.7.2"]
        Buffers["System.Buffers 4.5.1"]
        Memory["System.Memory 4.5.4"]
        MemoryData["System.Memory.Data 1.0.2"]
        Vectors["System.Numerics.Vectors 4.5.0"]
        Unsafe["System.Runtime.CompilerServices.Unsafe 4.6.0"]
        TasksExt["System.Threading.Tasks.Extensions 4.5.2"]
        ValueTuple["System.ValueTuple 4.5.0"]
        Antlr["Antlr 3.4.1.9004"]
        WebGrease["WebGrease 1.5.2"]
    end

    App -->|"presentation"| Web
    App -->|"storage access"| Storage
    App -->|"diagnostics"| Logging
    App -->|"support libraries"| Utilities
    Optimization -.->|"minification pipeline"| WebGrease
```

### Dependency Summary

| Category | Count | Key Libraries | Notes |
|---|---:|---|---|
| Web Frameworks | 10 | Microsoft.AspNet.Mvc, Razor, WebPages, jQuery, Bootstrap | Legacy ASP.NET MVC 5 stack running on .NET Framework |
| Database / Storage | 7 | Azure.Storage.Blobs, Azure.Core, Azure.Storage.Common | Blob storage is the only persistence integration; older OData libraries remain referenced |
| Logging / Observability | 1 | System.Diagnostics.DiagnosticSource | Minimal diagnostics support only; no full telemetry stack detected |
| Utilities | 16 | Newtonsoft.Json, System.Text.Json, CodeDom provider, WebGrease | Mix of compiler/runtime shims and legacy utility packages required by the web app model |

### Version & Compatibility Risks

The dependency set is skewed toward older ASP.NET MVC 5 and .NET Framework-era packages, several of which are already flagged in the .NET upgrade assessment for incompatibility, deprecation, or replacement. In particular, MVC 5/WebPages bundling, the CodeDom compiler provider, and old front-end packages such as jQuery 1.10.2 and Bootstrap 3.0.0 will require modernization when moving to a current .NET target.

### Notable Observations

- Both `Newtonsoft.Json` and `System.Text.Json` are referenced, which suggests overlapping JSON functionality during migration planning.
- `Microsoft.AspNet.Web.Optimization` depends on `WebGrease`, and the upgrade assessment explicitly calls out bundling/minification as unsupported in modern .NET.
- Storage integration is already on the newer Azure SDK (`Azure.Storage.Blobs` v12), which reduces one migration concern compared with older `Microsoft.WindowsAzure.Storage` packages.
- No dedicated security, authentication, or resilience libraries are declared; the application relies on platform defaults and direct SDK calls.

## Test Dependencies

| Framework | Version | Notes |
|---|---:|---|

Total test-scope dependencies: 0

No test dependencies detected. The repository does not include a separate automated test project or test-only package declarations.
