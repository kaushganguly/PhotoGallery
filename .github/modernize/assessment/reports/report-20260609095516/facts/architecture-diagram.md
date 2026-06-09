# Architecture Diagram

This application is a single ASP.NET MVC web app that serves a photo gallery UI and uses Azure Blob Storage as its backing store for uploaded images.

## Application Architecture

```mermaid
flowchart TD
    subgraph Client["Client Layer"]
        Browser["Web Browser"]
    end
    subgraph Web["Application Layer - ASP.NET MVC 5 on .NET Framework 4.8"]
        Views["Razor Views"]
        HomeController["HomeController"]
        BlobClientLayer["Azure Storage Blob SDK"]
    end
    subgraph Data["Data Layer"]
        BlobContainer[("Azure Blob Container webappstoragedotnet-imagecontainer")]
    end
    subgraph External["External Services"]
        AzureBlob["Azure Blob Storage Account"]
    end

    Browser -->|"GET and POST requests"| HomeController
    HomeController -->|"returns HTML views"| Views
    HomeController -->|"list upload delete blobs"| BlobClientLayer
    BlobClientLayer -->|"blob operations over HTTPS"| AzureBlob
    AzureBlob -->|"stores images"| BlobContainer
```

### Technology Stack Summary

| Layer | Technology | Version | Purpose |
|---|---|---|---|
| Presentation | ASP.NET MVC + Razor | MVC 5.2.3 | Server rendered web UI for image gallery |
| Application | .NET Framework | 4.8 | Web app runtime and request handling |
| Data Access | Azure.Storage.Blobs SDK | 12.9.1 | Programmatic blob container and blob operations |
| Frontend Assets | jQuery + Bootstrap | 1.10.2 and 3.0.0 | Client interactivity and UI styling |

### Data Storage & External Services

The application stores image binaries in an Azure Blob Storage container. It uses the `StorageConnectionString` app setting to connect either to the storage emulator for local development or a real Azure Storage account in deployed environments.

### Key Architectural Decisions

- Uses a single MVC controller (`HomeController`) to handle all gallery operations.
- Stores unstructured files in blob storage instead of a relational database.
- Uses asynchronous blob SDK methods for upload and delete operations.

## Component Relationships

```mermaid
flowchart LR
    subgraph Presentation["Presentation"]
        IndexView["Views/Home/Index.cshtml"]
        ErrorView["Views/Shared/Error.cshtml"]
        JQuery["jQuery client scripts"]
    end
    subgraph Business["Business Logic"]
        HomeController["HomeController"]
    end
    subgraph DataAccess["Data Access"]
        BlobServiceClient["BlobServiceClient"]
        BlobContainerClient["BlobContainerClient"]
        BlobClient["BlobClient"]
    end
    subgraph Infrastructure["Infrastructure"]
        RouteConfig["RouteConfig"]
        FilterConfig["FilterConfig"]
        BundleConfig["BundleConfig"]
        WebConfig["Web.config appSettings"]
    end

    JQuery -->|"POST delete and refresh"| HomeController
    IndexView -->|"form submit for upload and delete all"| HomeController
    HomeController -->|"read StorageConnectionString"| WebConfig
    HomeController -->|"create client"| BlobServiceClient
    BlobServiceClient -->|"get container client"| BlobContainerClient
    HomeController -->|"create blob client per file"| BlobClient
    BlobClient -->|"upload and delete blob"| BlobContainerClient
    RouteConfig -.->|"maps default route"| HomeController
    FilterConfig -.->|"global error handling"| HomeController
    BundleConfig -.->|"registers script style bundles"| IndexView
    HomeController -->|"returns models and views"| ErrorView
```

### Component Inventory

| Component | Layer | Type | Responsibility |
|---|---|---|---|
| HomeController | Business Logic | MVC Controller | Lists blobs, uploads files, deletes single or all files |
| Index.cshtml | Presentation | Razor View | Displays gallery and upload/delete controls |
| Error.cshtml | Presentation | Razor View | Displays error details from controller exception handling |
| RouteConfig | Infrastructure | Route Configuration | Configures default MVC route mapping |
| FilterConfig | Infrastructure | Global Filter Registration | Registers global error handling filter |
| BundleConfig | Infrastructure | Asset Bundling Configuration | Registers script and stylesheet bundles |
| BlobServiceClient | Data Access | SDK Client | Connects to Azure Blob Storage account |
| BlobContainerClient | Data Access | SDK Client | Represents and manages image container |
| BlobClient | Data Access | SDK Client | Uploads/deletes individual image blobs |
