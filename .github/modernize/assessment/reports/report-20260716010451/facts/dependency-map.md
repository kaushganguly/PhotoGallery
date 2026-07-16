# Dependency Map

This project is a .NET Framework ASP.NET MVC web app with 18 primary runtime dependencies declared in `packages.config`, centered on MVC, Azure Storage, and utility libraries.

## Dependencies

```mermaid
flowchart LR
    App["WebApp-Storage-DotNet"]

    subgraph Web["Web Frameworks"]
        AspMvc["Microsoft.AspNet.Mvc 5.2.3"]
        Razor["Microsoft.AspNet.Razor 3.2.3"]
        WebPages["Microsoft.AspNet.WebPages 3.2.3"]
        WebOpt["Microsoft.AspNet.Web.Optimization 1.1.3"]
    end

    subgraph Data["Database / ORM"]
        DataSvc["Microsoft.Data.Services.Client 5.6.4"]
        OData["Microsoft.Data.OData 5.6.4"]
        Edm["Microsoft.Data.Edm 5.6.4"]
    end

    subgraph Log["Logging"]
        Diag["System.Diagnostics.DiagnosticSource 4.6.0"]
    end

    subgraph Sec["Security"]
        Json["Newtonsoft.Json 6.0.8"]
    end

    subgraph Util["Utilities"]
        AzureCore["Azure.Core 1.18.0"]
        Blob["Azure.Storage.Blobs 12.9.1"]
        BlobCommon["Azure.Storage.Common 12.8.0"]
        AsyncIf["Microsoft.Bcl.AsyncInterfaces 1.0.0"]
        Buffers["System.Buffers 4.5.1"]
        Memory["System.Memory 4.5.4"]
        MemData["System.Memory.Data 1.0.2"]
        Unsafe["System.Runtime.CompilerServices.Unsafe 4.6.0"]
        TextJson["System.Text.Json 4.6.0"]
    end

    App -->|"web"| Web
    App -->|"data access"| Data
    App -->|"observability"| Log
    App -->|"serialization/security"| Sec
    App -->|"utilities and sdk"| Util

    Blob -.->|"depends on"| BlobCommon
    TextJson -.->|"uses"| Buffers
    TextJson -.->|"uses"| Memory
```

### Dependency Summary

| Category | Count | Key Libraries | Notes |
|---|---:|---|---|
| Web Frameworks | 4 | Microsoft.AspNet.Mvc, Microsoft.AspNet.Razor | Legacy ASP.NET MVC 5 stack on .NET Framework |
| Database / ORM | 3 | Microsoft.Data.Services.Client, OData | OData client libraries are present; no EF/ORM usage in app code |
| Logging | 1 | System.Diagnostics.DiagnosticSource | Basic diagnostics infrastructure |
| Security | 1 | Newtonsoft.Json | Older JSON library version |
| Utilities | 9 | Azure.Storage.Blobs, Azure.Core, System.Text.Json | Includes Azure Blob SDK plus low-level support packages |

### Version & Compatibility Risks

The project targets .NET Framework 4.8 with several older package versions (for example Newtonsoft.Json 6.0.8 and ASP.NET MVC 5.2.3), which may require API and package modernization when moving to .NET 8+ or ASP.NET Core.

### Notable Observations

- Both `System.Text.Json` and `Newtonsoft.Json` are referenced, indicating potentially mixed JSON stacks.
- Azure storage integration is implemented through Track 2 SDK packages (`Azure.Storage.Blobs 12.x`).
- Build still relies on `packages.config`, which is legacy compared with SDK-style `PackageReference`.
- No dedicated resilience/circuit-breaker libraries are declared.

## Test Dependencies

| Framework | Version | Notes |
|---|---|---|
| None detected | N/A | No test-specific packages were found in `packages.config` |

Total test-scope dependencies: 0
No test dependencies were detected in the project manifest.
