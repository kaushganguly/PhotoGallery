# Architecture Diagram

PhotoGallery is a single ASP.NET MVC web application that presents photos stored in Azure Blob Storage. Browsers retrieve the gallery page from the application and load public blob URLs directly from the storage service.

## Application Architecture

```mermaid
flowchart TD
    subgraph Client["Client Layer"]
        Browser["Web Browser"]
    end
    subgraph Application["Application Layer - ASP.NET MVC 5 on .NET Framework 4.8"]
        Web["IIS-hosted MVC application"]
        Controller["Home Controller"]
        Views["Razor Views"]
    end
    subgraph Storage["Storage Layer"]
        BlobContainer[("Azure Blob Storage container")]
    end

    Browser -->|"HTTP requests"| Web
    Web -->|"routes requests"| Controller
    Controller -->|"renders gallery"| Views
    Views -->|"HTML response"| Browser
    Controller -->|"lists, uploads, deletes blobs"| BlobContainer
    Browser -->|"loads public photo URLs"| BlobContainer
```

### Technology Stack Summary

| Layer | Technology | Version | Purpose |
|---|---|---|---|
| Presentation | ASP.NET MVC | 5.2.3 | Handles gallery requests and renders Razor views |
| Runtime | .NET Framework | 4.8 | Hosts the web application |
| View | ASP.NET Razor | 3.2.3 | Renders gallery and upload UI |
| Storage | Azure.Storage.Blobs | 12.9.1 | Lists, uploads, and deletes photo blobs |
| Browser assets | jQuery, Bootstrap | 1.10.2, 3.0.0 | Client-side UI and form behavior |

### Data Storage & External Services

The application stores image objects in one Azure Blob Storage container and has no relational database, cache, or message broker. The controller lists and mutates blobs; the browser receives blob URIs and loads them directly. The container is created with blob-level public read access.

### Key Architectural Decisions

- A single MVC controller coordinates the UI and Azure Blob Storage operations; no separate service or repository layer is present.
- Blob data is exposed through direct storage URLs rather than proxied through the web application.
- Listing and deletion use synchronous SDK operations while create/upload/delete operations are asynchronous in some actions.

## Component Relationships

```mermaid
flowchart LR
    subgraph Presentation["Presentation"]
        BrowserClient["Web Browser"]
        HomeRoutes["MVC routes"]
        HomeController["HomeController"]
        GalleryViews["Razor views"]
    end
    subgraph Infrastructure["Infrastructure"]
        BlobClient["BlobContainerClient"]
        AzureStorage["Azure Blob Storage"]
        GlobalStartup["MVC startup and route configuration"]
    end

    BrowserClient -->|"HTTP actions"| HomeRoutes
    HomeRoutes -->|"dispatches"| HomeController
    HomeController -->|"returns view data"| GalleryViews
    GalleryViews -->|"renders page"| BrowserClient
    HomeController -->|"uses"| BlobClient
    BlobClient -->|"blob operations"| AzureStorage
    GlobalStartup -.->|"registers routes"| HomeRoutes
    BrowserClient -->|"requests photo URI"| AzureStorage
```

### Component Inventory

| Component | Layer | Type | Responsibility |
|---|---|---|---|
| HomeController | Presentation | MVC Controller | Lists, uploads, and deletes gallery blobs |
| Index.cshtml | Presentation | Razor View | Displays photos and provides upload/delete actions |
| RouteConfig | Infrastructure | MVC Configuration | Maps controller/action URL routes |
| MvcApplication | Infrastructure | Startup | Registers MVC routes, filters, and bundles |
| BlobContainerClient | Infrastructure | Azure SDK client | Performs operations on the configured container |
| Azure Blob Storage | Infrastructure | External service | Persists image blobs and serves public blob URLs |
