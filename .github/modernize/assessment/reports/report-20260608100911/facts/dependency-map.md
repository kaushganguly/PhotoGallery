# Dependency Map

This dependency map covers declared external libraries for WebApp-Storage-DotNet and their functional roles (36 declared NuGet/package assets).

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

    subgraph DB["Database / ORM"]
        NoDb["No relational ORM dependency"]
    end

    subgraph Cache["Caching"]
        NoCache["No dedicated cache package"]
    end

    subgraph Log["Logging"]
        NoLog["Framework default logging only"]
    end

    subgraph Sec["Security"]
        Json["Newtonsoft.Json 6.0.8"]
    end

    subgraph Obs["Observability"]
        Diag["System.Diagnostics.DiagnosticSource 4.6.0"]
    end

    subgraph Util["Utilities"]
        AzureCore["Azure.Core 1.18.0"]
        Blob["Azure.Storage.Blobs 12.9.1"]
        BlobCommon["Azure.Storage.Common 12.8.0"]
        AsyncIf["Microsoft.Bcl.AsyncInterfaces 1.0.0"]
        JsonSys["System.Text.Json 4.6.0"]
        Buffers["System.Buffers 4.5.1"]
    end

    App -->|"web"| Web
    App -->|"persistence"| DB
    App -->|"caching"| Cache
    App -->|"logging"| Log
    App -->|"security/serialization"| Sec
    App -->|"observability"| Obs
    App -->|"sdk and runtime utilities"| Util
```

### Dependency Summary

| Category | Count | Key Libraries | Notes |
|---|---:|---|---|
| Web Frameworks | 4 | Microsoft.AspNet.Mvc 5.2.3, Razor 3.2.3 | Legacy ASP.NET MVC stack on .NET Framework |
| Database / ORM | 0 | None | No relational DB access package detected |
| Caching | 0 | None | No explicit cache library declared |
| Logging | 0 | None | No dedicated logging framework package |
| Security | 1 | Newtonsoft.Json 6.0.8 | Serialization dependency with older major version |
| Observability | 1 | DiagnosticSource 4.6.0 | Minimal diagnostics instrumentation |
| Utilities | 30 | Azure Storage SDK, System.* compatibility packages | Includes Azure SDK and framework support packages |

### Version & Compatibility Risks

The project depends on an older ASP.NET MVC 5/.NET Framework stack and several legacy package versions (for example Newtonsoft.Json 6.0.8 and early compiler provider packages). These dependencies can increase migration effort and security/compatibility risk when targeting newer .NET runtimes.

### Notable Observations

- Azure Blob Storage SDK packages are the core external integration dependencies.
- No test-scoped package references were declared in `packages.config`.
- Multiple compatibility packages (`System.*`) suggest backported runtime features for .NET Framework.
- Build-time packages like `Microsoft.Net.Compilers` are pinned to old versions.

## Test Dependencies

| Framework | Version | Notes |
|---|---|---|
| None detected | N/A | No test package references found in build/package files |

Total test-scope dependencies: 0
No dedicated test framework or integration-test package is declared in the repository build manifests.
