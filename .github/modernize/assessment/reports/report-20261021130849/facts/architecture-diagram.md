# Architecture Diagram

The application presents a browser-based photo gallery and delegates image storage to a Blob Storage service. It is a single ASP.NET MVC application with no separate business-service or database tier.

## Application Architecture

```mermaid
flowchart TD
    subgraph Client["Client Layer"]
        Browser["Web Browser"]
    end
    subgraph App["Application Layer - ASP.NET MVC 5 on .NET Framework 4.8"]
        Views["Razor Views"]
        Controller["HomeController"]
        Startup["MVC Startup and Route Configuration"]
    end
    subgraph Storage["Storage Layer"]
        BlobSdk["Azure Storage Blobs SDK 12.9.1"]
        Container[("Photo Gallery Blob Container")]
    end
    subgraph External["External Service"]
        BlobService["Azure Blob Storage or compatible emulator"]
    end

    Browser -->|"HTTP gallery and file requests"| Controller
    Controller -->|"renders pages"| Views
    Startup -->|"registers routes and filters"| Controller
    Controller -->|"list, upload, and delete blobs"| BlobSdk
    BlobSdk -->|"Storage REST requests"| BlobService
    BlobService -->|"stores image objects"| Container
```

### Technology Stack Summary

| Layer | Technology | Version | Purpose |
|---|---|---:|---|
| Presentation | ASP.NET MVC | 5.2.3 | Routes browser requests and renders views |
| View | Razor / ASP.NET WebPages | 3.2.3 | Server-rendered gallery and error pages |
| Runtime | .NET Framework | 4.8 | Hosts the web application |
| Storage integration | Azure.Storage.Blobs | 12.9.1 | Lists, uploads, and deletes blob objects |
| Storage service | Azure Blob Storage-compatible endpoint | Configured externally | Persists gallery images |

### Data Storage & External Services

Images are stored as block blobs in `webappstoragedotnet-imagecontainer`. The checked-in configuration selects development storage with `UseDevelopmentStorage=true`; a deployed environment must supply a storage connection string. There is no relational database, cache, message broker, or other external API.

### Key Architectural Decisions

- The MVC controller directly coordinates page requests and Blob Storage operations; no separate service or repository layer is present.
- Gallery images are exposed with blob-level public read access when the container is created.
- The application uses asynchronous upload and delete SDK operations, while listing blobs is performed synchronously.

## Component Relationships

```mermaid
flowchart LR
    subgraph Presentation["Presentation"]
        GalleryView["Home Index View"]
        ErrorView["Shared Error View"]
        HomeController["HomeController"]
    end
    subgraph Startup["Application Startup"]
        MvcApplication["MvcApplication"]
        RouteConfig["RouteConfig"]
        FilterConfig["FilterConfig"]
        BundleConfig["BundleConfig"]
    end
    subgraph Infrastructure["Infrastructure"]
        BlobClient["Azure Blob SDK Clients"]
        BlobContainer["Blob Container"]
    end

    MvcApplication -->|"registers"| RouteConfig
    MvcApplication -->|"registers"| FilterConfig
    MvcApplication -->|"registers"| BundleConfig
    RouteConfig -->|"routes requests to"| HomeController
    HomeController -->|"returns gallery"| GalleryView
    HomeController -->|"returns failures"| ErrorView
    HomeController -->|"uses"| BlobClient
    BlobClient -->|"operates on"| BlobContainer
```

### Component Inventory

| Component | Layer | Type | Responsibility |
|---|---|---|---|
| HomeController | Presentation/application | MVC Controller | Lists, uploads, and deletes gallery blobs |
| Home Index View | Presentation | Razor View | Displays image links and upload/delete controls |
| Shared Error View | Presentation | Razor View | Displays error text and stack trace |
| MvcApplication | Startup | ASP.NET application class | Registers routes, global filters, and bundles |
| RouteConfig | Startup | MVC configuration | Maps controller/action routes |
| FilterConfig | Startup | MVC configuration | Registers the standard error filter |
| BundleConfig | Startup | Asset configuration | Registers JavaScript and CSS bundles |
| Azure Blob SDK Clients | Infrastructure | Storage client | Communicates with the configured Blob Storage endpoint |
