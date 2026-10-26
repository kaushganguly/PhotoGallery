# Architecture Diagram

This single-project photo gallery serves a server-rendered web interface and uses Azure Blob Storage for image persistence. There is no relational database or separately deployed application service.

## Application Architecture

```mermaid
flowchart TD
    subgraph Client["Client Layer"]
        Browser["Web Browser"]
    end
    subgraph App["Application Layer - ASP.NET MVC 5 on .NET Framework 4.8"]
        Views["Razor Views and JavaScript"]
        Controller["HomeController"]
        Routing["MVC Routing and Global Filters"]
    end
    subgraph Storage["Storage Layer"]
        BlobSdk["Azure Storage Blobs SDK 12.9.1"]
        Container[("Azure Blob Storage container")]
    end

    Browser -->|"HTTP requests and multipart uploads"| Routing
    Routing --> Controller
    Controller -->|"renders gallery and action results"| Views
    Views -->|"HTML response"| Browser
    Controller -->|"blob listing, upload, and deletion over HTTPS"| BlobSdk
    BlobSdk -->|"container operations"| Container
    Container -->|"public blob URLs"| Browser
```

### Technology Stack Summary

| Layer | Technology | Version | Purpose |
|---|---|---:|---|
| Presentation | ASP.NET MVC | 5.2.3 | Routes browser requests to controller actions and renders Razor views |
| Runtime | .NET Framework | 4.8 | Hosts the web application |
| Storage integration | Azure.Storage.Blobs | 12.9.1 | Lists, uploads, and deletes blob objects |
| Web UI | Razor, jQuery, Bootstrap | 3.2.3, 1.10.2, 3.0.0 | Server-rendered gallery and browser interactions |
| Hosting | IIS Express / Azure Web Apps | Not pinned | Local and documented cloud hosting |

### Data Storage & External Services

Azure Blob Storage is the only application persistence service. The application lists block blobs, uploads objects, and deletes them; there is no database, cache, or message broker. The container is created with public blob-read access, so browsers can load the resulting blob URLs directly.

### Key Architectural Decisions

- A single MVC controller combines request handling and direct Blob Storage operations; no separate service or repository layer is defined.
- Blob objects, rather than relational records, are the gallery's persistence model.
- The container is accessed through a mutable static `BlobContainerClient` shared by controller requests.

## Component Relationships

```mermaid
flowchart LR
    subgraph Presentation["Presentation"]
        Home["HomeController"]
        Index["Home Index Razor view"]
        Error["Shared Error Razor view"]
    end
    subgraph Infrastructure["Application Infrastructure"]
        Routes["RouteConfig"]
        Filters["FilterConfig"]
        Startup["MvcApplication startup"]
    end
    subgraph Storage["Storage Integration"]
        Client["BlobServiceClient and BlobContainerClient"]
        Azure["Azure Blob Storage"]
    end

    Startup -->|"registers"| Routes
    Startup -->|"registers"| Filters
    Routes -->|"dispatches requests"| Home
    Home -->|"gallery model"| Index
    Home -->|"exception details"| Error
    Home -->|"creates and uses"| Client
    Client -->|"blob operations"| Azure
```

### Component Inventory

| Component | Layer | Type | Responsibility |
|---|---|---|---|
| HomeController | Presentation | MVC Controller | Lists blobs and handles upload and deletion requests |
| Home Index view | Presentation | Razor View | Displays gallery images and submits browser actions |
| Shared Error view | Presentation | Razor View | Displays controller exception details |
| MvcApplication | Application Infrastructure | ASP.NET application startup | Registers routes, global filters, and bundles |
| RouteConfig | Application Infrastructure | MVC routing configuration | Maps the default route to `Home/Index` |
| FilterConfig | Application Infrastructure | MVC filter configuration | Registers the global error handler |
| BlobServiceClient / BlobContainerClient | Storage Integration | Azure SDK clients | Communicate with the configured Blob Storage service |
