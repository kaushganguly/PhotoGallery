# Dependency Map

This project (`WebApp-Storage-DotNet`) declares approximately 34 NuGet dependencies, centered on ASP.NET MVC and Azure Blob Storage integration.

## Dependencies

```mermaid
flowchart LR
    App["WebApp-Storage-DotNet"]

    subgraph Web["Web Frameworks"]
        AspMvc["Microsoft.AspNet.Mvc 5.2.3"]
        Razor["Microsoft.AspNet.Razor 3.2.3"]
        WebPages["Microsoft.AspNet.WebPages 3.2.3"]
        Optimization["Microsoft.AspNet.Web.Optimization 1.1.3"]
        JQuery["jQuery 1.10.2"]
        Bootstrap["bootstrap 3.0.0"]
        Modernizr["Modernizr 2.6.2"]
    end

    subgraph DB["Database or ORM"]
        NoOrm["No relational ORM declared"]
    end

    subgraph Cache["Caching"]
        NoCache["No caching library declared"]
    end

    subgraph Log["Logging"]
        NoLog["No dedicated logging package declared"]
    end

    subgraph Sec["Security"]
        NoAuth["No auth framework package declared"]
    end

    subgraph Obs["Observability"]
        Diag["System.Diagnostics.DiagnosticSource 4.6.0"]
    end

    subgraph Util["Utilities"]
        AzureCore["Azure.Core 1.18.0"]
        AzureBlob["Azure.Storage.Blobs 12.9.1"]
        AzureCommon["Azure.Storage.Common 12.8.0"]
        Newtonsoft["Newtonsoft.Json 6.0.8"]
        TextJson["System.Text.Json 4.6.0"]
        Buffers["System.Buffers 4.5.1"]
        Memory["System.Memory 4.5.4"]
        Unsafe["System.Runtime.CompilerServices.Unsafe 4.6.0"]
    end

    App -->|"web"| Web
    App -->|"persistence"| DB
    App -->|"caching"| Cache
    App -->|"logging"| Log
    App -->|"security"| Sec
    App -->|"observability"| Obs
    App -->|"utilities"| Util
    AzureBlob -.->|"depends on"| AzureCore
    AzureBlob -.->|"depends on"| AzureCommon
```

### Dependency Summary

| Category | Count | Key Libraries | Notes |
|---|---:|---|---|
| Web Frameworks | 7 | ASP.NET MVC 5.2.3, Razor 3.2.3, WebPages 3.2.3 | Legacy ASP.NET MVC stack on .NET Framework |
| Database or ORM | 0 | None | No relational persistence layer in this app |
| Messaging | 0 | None | No queue or broker client libraries declared |
| Caching | 0 | None | No dedicated caching package declared |
| Logging | 0 | None | Relies on default framework logging/error pages |
| Security | 0 | None | No explicit auth package in dependencies |
| Observability | 1 | DiagnosticSource 4.6.0 | Low observability footprint |
| Utilities | 8 | Azure.Storage.Blobs 12.9.1, Azure.Core 1.18.0, Newtonsoft.Json 6.0.8 | Mix of Azure SDK and base runtime helper libs |

### Version & Compatibility Risks

The project uses .NET Framework 4.8 with older ASP.NET MVC-era packages and frontend libraries (notably jQuery 1.10.2 and Bootstrap 3.0.0), which increase modernization and security maintenance risk. Newtonsoft.Json 6.0.8 is also significantly behind current supported versions.

### Notable Observations

- Azure Blob Storage SDK is modern relative to the older ASP.NET MVC application stack.
- Both `Newtonsoft.Json` and `System.Text.Json` are present, indicating potential serialization inconsistency.
- No explicit authentication/authorization dependency is declared.
- Several packages are legacy-era versions tied to classic ASP.NET tooling.

## Test Dependencies

| Framework | Version | Notes |
|---|---|---|
| None detected | N/A | No test-scoped packages found in `packages.config` |

Total test-scope dependencies: 0

No test infrastructure dependencies were detected from declared package metadata.
