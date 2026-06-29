# Assessment Overview

This directory contains supplementary architecture and analysis documents generated as part of the application assessment for the **PhotoGallery** (WebApp-Storage-DotNet) project. Use the links below to navigate each topic area.

## Documents

| Document | Description |
|---|---|
| [Architecture Diagram](architecture-diagram.md) | Two-layer architecture visualization: high-level application architecture (technology stack, data storage, external services) and component relationship diagram (controllers, views, Azure SDK clients, startup components) |
| [Dependency Map](dependency-map.md) | Visual map of all external NuGet package dependencies grouped by functional category (Web Frameworks, Frontend Libraries, Azure Cloud Storage, Utilities, BCL Polyfills, OData/Data Services), with version and compatibility risk analysis |
| [API & Service Communication Contracts](api-service-contracts.md) | Inventory of all HTTP endpoints (GET `/`, POST `/Home/UploadAsync`, POST `/Home/DeleteImage`, POST `/Home/DeleteAll`), communication patterns with Azure Blob Storage, and sequence diagram of the primary request flows |
| [Data Architecture](data-architecture.md) | Data layer documentation covering Azure Blob Storage configuration, blob container structure, storage client methods, and data classification/sensitivity analysis |
| [Configuration Inventory](configuration-inventory.md) | Comprehensive inventory of all configuration sources (`Web.config`, `Views/Web.config`), build profiles (Debug/Release), properties with default values, secrets handling assessment, and full framework/runtime version matrix |
| [Business Workflows](business-workflows.md) | End-to-end documentation of the four core business workflows (Browse Gallery, Upload Photo, Delete Single Photo, Delete All Photos), domain entities, business rules, and a sequence diagram of the complete user journey |
