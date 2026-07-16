# Architecture Diagram

This application is a single-service ASP.NET MVC web app that serves a browser UI and performs direct blob operations against Azure Storage.

## Application Architecture

```mermaid
flowchart TD
    subgraph Client["Client Layer"]
        Browser["Web Browser"]
    end
    subgraph App["Application Layer - ASP.NET MVC 5 on .NET Framework 4.8"]
        Routes["MVC Routing"]
        HomeCtrl["HomeController"]
        Razor["Razor Views"]
    end
    subgraph Data["Data Layer"]
        BlobSdk["Azure.Storage.Blobs SDK"]
        BlobStore[("Azure Blob Storage")]
    end
    subgraph External["External Services"]
        AzureStorage["Azure Storage Account Endpoint"]
    end

    Browser -->|"HTTP requests"| Routes
    Routes -->|"dispatches actions"| HomeCtrl
    HomeCtrl -->|"returns model"| Razor
    Razor -->|"HTML response"| Browser
    HomeCtrl -->|"list upload delete blobs"| BlobSdk
    BlobSdk -->|"blob API calls"| BlobStore
    BlobStore -->|"hosted in"| AzureStorage
```

### Technology Stack Summary

| Layer | Technology | Version | Purpose |
|---|---|---|---|
| Presentation | ASP.NET MVC + Razor | MVC 5.2.3 | Serves gallery UI and accepts file operations |
| Application | C# async controller actions | .NET Framework 4.8 | Coordinates upload, listing, and delete workflows |
| Data Access | Azure Storage Blob SDK | 12.9.1 | Performs blob container and blob operations |
| Configuration | Web.config appSettings | N/A | Stores storage connection string and runtime settings |

### Data Storage & External Services

The app stores image data in a single Azure Blob Storage container (`webappstoragedotnet-imagecontainer`) and interacts directly with the storage account endpoint through the Azure Blob client SDK.

### Key Architectural Decisions

- Uses a simple server-rendered MVC pattern with one primary controller and one view.
- Uses direct SDK calls from controller actions instead of a separate repository/service layer.
- Uses a storage connection string in application settings to switch between emulator and cloud storage.

## Component Relationships

```mermaid
flowchart LR
    subgraph Presentation["Presentation"]
        HomeView["Views/Home/Index.cshtml"]
        JsClient["Client-side JavaScript"]
    end
    subgraph Business["Business Logic"]
        HomeController["HomeController"]
        RouteConfig["RouteConfig"]
    end
    subgraph DataAccess["Data Access"]
        BlobServiceClient["BlobServiceClient"]
        BlobContainerClient["BlobContainerClient"]
        BlobClient["BlobClient"]
    end
    subgraph Infrastructure["Infrastructure"]
        AppSettings["StorageConnectionString"]
        MvcStartup["Global.asax Application_Start"]
    end

    MvcStartup -->|"registers"| RouteConfig
    HomeView -->|"form post"| HomeController
    JsClient -->|"post delete image"| HomeController
    RouteConfig -->|"maps route"| HomeController
    HomeController -->|"reads"| AppSettings
    HomeController -->|"creates"| BlobServiceClient
    BlobServiceClient -->|"gets container"| BlobContainerClient
    HomeController -->|"uploads/deletes"| BlobClient
    BlobContainerClient -->|"creates blob client"| BlobClient
```

### Component Inventory

| Component | Layer | Type | Responsibility |
|---|---|---|---|
| Global.asax | Infrastructure | Application bootstrap | Registers filters, routes, and bundles |
| RouteConfig | Business Logic | Routing config | Maps default `{controller}/{action}/{id}` route |
| HomeController | Business Logic | MVC Controller | Lists blobs, uploads files, deletes blobs |
| Views/Home/Index.cshtml | Presentation | Razor view | Displays gallery and upload/delete controls |
| Client-side JS in Index view | Presentation | Browser script | Invokes delete endpoint and updates upload list UI |
| BlobServiceClient/BlobContainerClient/BlobClient | Data Access | Azure SDK clients | Executes blob CRUD operations |
| Web.config appSettings | Infrastructure | Configuration source | Supplies storage connection string |
