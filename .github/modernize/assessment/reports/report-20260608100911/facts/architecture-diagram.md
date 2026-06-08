# Architecture Diagram

This document summarizes the current architecture of the Photo Gallery application and key runtime component interactions.

## Application Architecture

```mermaid
flowchart TD
    subgraph Client["Client Layer"]
        Browser["Web Browser"]
    end
    subgraph App["Application Layer - ASP.NET MVC 5 on .NET Framework 4.8"]
        Mvc["HomeController and Razor Views"]
        Logic["Blob orchestration logic"]
    end
    subgraph Data["Data Layer"]
        Blob[("Azure Blob Storage container")]
    end
    subgraph External["External Services"]
        StorageApi["Azure Storage Blob service"]
    end

    Browser -->|"HTTP requests"| Mvc
    Mvc -->|"uploads and listings"| Logic
    Logic -->|"Blob SDK calls"| StorageApi
    StorageApi -->|"stores image objects"| Blob
```

### Technology Stack Summary

| Layer | Technology | Version | Purpose |
|---|---|---|---|
| Presentation | ASP.NET MVC + Razor | MVC 5.2.3 | Serves web UI and form posts |
| Application | .NET Framework | v4.8 target | Controller-based request handling |
| Storage Access | Azure.Storage.Blobs SDK | 12.9.1 | Read/write/delete image blobs |
| Data | Azure Blob Storage | Configured via connection string | Durable object storage for uploaded photos |

### Data Storage & External Services

The application persists photo content in a single Azure Blob Storage container (`webappstoragedotnet-imagecontainer`) using the configured `StorageConnectionString`. There is no relational database, message broker, or cache layer in the current implementation.

### Key Architectural Decisions

- Uses a single MVC controller to orchestrate upload, list, and delete operations.
- Stores all user content in Azure Blob Storage to avoid local file persistence.
- Uses asynchronous storage SDK APIs in controller actions for I/O operations.

## Component Relationships

```mermaid
flowchart LR
    subgraph Presentation
        HomeCtrl["HomeController"]
        IndexView["Index.cshtml"]
    end
    subgraph Business["Business Logic"]
        UploadFlow["UploadAsync flow"]
        ListFlow["Index listing flow"]
        DeleteFlow["DeleteImage/DeleteAll flow"]
    end
    subgraph DataAccess["Data Access"]
        BlobClient["BlobServiceClient"]
        ContainerClient["BlobContainerClient"]
    end
    subgraph Infra["Infrastructure"]
        RouteCfg["RouteConfig"]
        ErrorFilter["HandleErrorAttribute"]
        BundleCfg["BundleConfig"]
    end

    HomeCtrl -->|"returns"| IndexView
    HomeCtrl -->|"delegates"| UploadFlow
    HomeCtrl -->|"delegates"| ListFlow
    HomeCtrl -->|"delegates"| DeleteFlow
    UploadFlow -->|"uses"| ContainerClient
    ListFlow -->|"uses"| ContainerClient
    DeleteFlow -->|"uses"| ContainerClient
    ContainerClient -->|"created by"| BlobClient
    ErrorFilter -.->|"intercepts errors"| HomeCtrl
    RouteCfg -.->|"maps /Home routes"| HomeCtrl
    BundleCfg -.->|"serves static assets"| IndexView
```

### Component Inventory

| Component | Layer | Type | Responsibility |
|---|---|---|---|
| HomeController | Presentation | MVC Controller | Handles image list, upload, and delete requests |
| Index.cshtml | Presentation | Razor View | Renders gallery UI and upload/delete controls |
| BlobServiceClient | Data Access | SDK Client | Connects to Azure Storage account |
| BlobContainerClient | Data Access | SDK Client | Enumerates, uploads, and deletes blobs |
| RouteConfig | Infrastructure | MVC Routing Config | Defines default route mapping |
| FilterConfig / HandleErrorAttribute | Infrastructure | Global Filter | Handles unhandled MVC exceptions |
| BundleConfig | Infrastructure | Asset Bundling Config | Registers JS/CSS bundles for UI |
