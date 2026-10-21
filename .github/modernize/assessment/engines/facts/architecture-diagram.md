# Architecture Diagram

PhotoGallery is a server-rendered ASP.NET MVC application that provides a browser interface for managing images in Azure Blob Storage. The MVC controller communicates directly with the storage service using the Azure Storage Blobs client library.

## Application Architecture

```mermaid
flowchart TD
    subgraph Client["Client Layer"]
        Browser["Web Browser"]
    end
    subgraph App["Application Layer"]
        MVC["ASP.NET MVC 5"]
        Controller["Home Controller"]
        View["Razor Views"]
    end
    subgraph Storage["Storage Layer"]
        BlobSDK["Azure Storage Blobs SDK"]
        Container[("Azure Blob Storage Container")]
    end

    Browser -->|"HTTP requests and form submissions"| MVC
    MVC -->|"routes requests"| Controller
    Controller -->|"renders pages"| View
    View -->|"HTML responses"| Browser
    Controller -->|"list, upload, and delete blobs"| BlobSDK
    BlobSDK -->|"HTTPS storage API"| Container
```

### Technology Stack Summary

| Layer | Technology | Version | Purpose |
|---|---|---|---|
| Presentation | ASP.NET MVC | 5.2.3 | Handles web requests and renders server-side views |
| Presentation | Razor | 3.2.3 | Produces HTML views |
| Application | .NET Framework | 4.8 | Application runtime and framework |
| Storage integration | Azure.Storage.Blobs | 12.9.1 | Lists, uploads, and deletes gallery images |
| Storage | Azure Blob Storage | Configured externally | Persists image blobs in a named container |

### Data Storage & External Services

The application has no relational database or cache. Images are stored as block blobs in the `webappstoragedotnet-imagecontainer` container. The storage connection string is read from the `StorageConnectionString` application setting; the checked-in configuration defaults to the local development storage emulator.

### Key Architectural Decisions

- Uses server-rendered ASP.NET MVC and Razor for the browser interface.
- The `HomeController` directly invokes the Azure Blob Storage SDK; no separate service or repository layer is present.
- Stores gallery images as blobs rather than in a database.

## Component Relationships

```mermaid
flowchart LR
    subgraph Presentation["Presentation"]
        Browser["Web Browser"]
        HomeView["Home Index Razor View"]
        ErrorView["Shared Error Razor View"]
    end
    subgraph Application["Application"]
        Routes["MVC Route Configuration"]
        HomeController["HomeController"]
        Startup["MVC Application Startup"]
    end
    subgraph Infrastructure["Infrastructure"]
        Settings["Web.config App Settings"]
        BlobClient["Azure Storage Blob Clients"]
        BlobContainer[("Azure Blob Container")]
    end

    Browser -->|"requests"| Routes
    Routes -->|"dispatches to"| HomeController
    HomeController -->|"returns gallery model"| HomeView
    HomeController -->|"returns errors"| ErrorView
    HomeView -->|"renders response"| Browser
    HomeController -->|"reads connection string"| Settings
    HomeController -->|"lists, uploads, and deletes"| BlobClient
    BlobClient -->|"storage operations"| BlobContainer
    Startup -.->|"registers routes and filters"| Routes
```

### Component Inventory

| Component | Layer | Type | Responsibility |
|---|---|---|---|
| MVC Application Startup | Application | ASP.NET application startup | Registers routes, filters, and bundles |
| MVC Route Configuration | Application | MVC configuration | Maps requests to the default Home/Index action |
| HomeController | Application | MVC controller | Lists, uploads, and deletes gallery blobs |
| Home Index Razor View | Presentation | Razor view | Displays image thumbnails and upload/delete controls |
| Shared Error Razor View | Presentation | Razor view | Displays controller error details |
| Web.config App Settings | Infrastructure | Configuration | Provides the storage connection string |
| Azure Storage Blob Clients | Infrastructure | SDK clients | Communicates with Azure Blob Storage |
| Azure Blob Container | Infrastructure | Object storage | Persists image files |
