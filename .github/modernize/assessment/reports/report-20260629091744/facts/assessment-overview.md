# Assessment Overview

This directory contains supplementary analysis documents generated alongside the core AppCAT assessment report for the **WebApp-Storage-DotNet Photo Gallery** application — an ASP.NET MVC 5 web application targeting .NET Framework 4.8 that uses Azure Blob Storage for image persistence.

## Supplementary Documents

| Document | Description |
|----------|-------------|
| [Architecture Diagram](architecture-diagram.md) | Two-layer visualization: high-level application architecture (technology stack, data flow, external services) and detailed component relationships grouped by layer |
| [Dependency Map](dependency-map.md) | Visual map of all 34 declared NuGet packages grouped by functional category (web frameworks, Azure Storage SDK, client-side UI, utilities), with version/compatibility risk analysis |
| [API & Service Contracts](api-service-contracts.md) | Catalog of all 4 HTTP endpoints, communication patterns, security posture, and a sequence diagram showing browser-to-storage request flows |
| [Data Architecture](data-architecture.md) | Azure Blob Storage configuration, data ownership, persistence operations, data classification, and sensitivity analysis including the plaintext storage connection string risk |
| [Configuration Inventory](configuration-inventory.md) | Full inventory of configuration sources (`Web.config`), build profiles, runtime properties, secrets handling, and framework/runtime version matrix |
| [Business Workflows](business-workflows.md) | End-to-end documentation of the four core user workflows (view gallery, upload photos, delete single photo, delete all photos), business rules, and decision logic |

## Key Findings Summary

- **Framework**: ASP.NET MVC 5 on .NET Framework 4.8 — requires migration to ASP.NET Core for cross-platform and cloud-native deployment.
- **Storage**: Azure Blob Storage SDK v12 (Azure.Core 1.18.0) — modern SDK but connected via plaintext connection string; managed identity migration recommended.
- **Security**: No authentication, no authorization, no CSRF protection, and connection string stored in plaintext `Web.config`.
- **No logging, no health checks, no observability** — errors surface only to the end user via an error view.
- **14 polyfill packages** that become obsolete on .NET 6+, and several end-of-life client libraries (Bootstrap 3, jQuery 1.x).

For the full machine-readable assessment results, see `../report.json`.
