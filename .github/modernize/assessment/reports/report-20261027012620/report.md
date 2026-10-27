# PhotoGallery Assessment Report

> **Assessment limitation:** The AppCAT core analysis did not complete because the legacy ASP.NET WebApplication MSBuild targets are unavailable on this Linux runner. This report contains the security scan and repository facts only; cloud-readiness and .NET upgrade results are not available.

## Summary

| Metric | Count |
|---|---:|
| Total Issues | 20 |
| Mandatory Issues | 4 |
| Potential Issues | 4 |
| Optional Issues | 12 |

Counts are unique security findings, not source-file occurrences. Dependency CVEs use the requested minimum severity threshold of medium.

## Application Information

| Property | Value |
|---|---|
| Application | PhotoGallery |
| Language | C# |
| Framework | ASP.NET MVC 5, .NET Framework 4.8 |
| Core assessment | Not completed; MSBuild WebApplication targets unavailable |
| .NET 10 upgrade assessment | Not run; the core assessment did not produce its report directory |

## Security Findings

### Dependency vulnerabilities

| Finding | Severity | Evidence |
|---|---|---|
| [CVE-2022-30187: Azure Blob Storage Encryption Library padding oracle](#cve-2022-30187-azure-blob-storage-encryption-library-padding-oracle) | Optional | `packages.config:5` |
| [CVE-2024-21907: Newtonsoft.Json exceptional condition handling](#cve-2024-21907-newtonsoftjson-exceptional-condition-handling) | Mandatory | `packages.config:23` |
| [CVE-2018-14040: Bootstrap cross-site scripting](#cve-2018-14040-bootstrap-cross-site-scripting) | Optional | `packages.config:7` |
| [CVE-2021-21252: jquery-validation regular-expression DoS](#cve-2021-21252-jquery-validation-regular-expression-dos) | Mandatory | `packages.config:9` |
| [CVE-2020-11023: jQuery potential XSS](#cve-2020-11023-jquery-potential-xss) | Optional | `packages.config:8` |
| [CVE-2019-11358: jQuery XSS](#cve-2019-11358-jquery-xss) | Optional | `packages.config:8` |
| [CVE-2019-8331: Bootstrap XSS](#cve-2019-8331-bootstrap-xss) | Optional | `packages.config:7` |
| [CVE-2018-20677: Bootstrap XSS](#cve-2018-20677-bootstrap-xss) | Optional | `packages.config:7` |
| [CVE-2018-20676: Bootstrap XSS](#cve-2018-20676-bootstrap-xss) | Optional | `packages.config:7` |
| [CVE-2016-10735: Bootstrap XSS](#cve-2016-10735-bootstrap-xss) | Optional | `packages.config:7` |
| [CVE-2018-8269: ASP.NET Core denial of service advisory](#cve-2018-8269-aspnet-core-denial-of-service-advisory) | Mandatory | `packages.config:17` |
| [CVE-2018-14042: Bootstrap XSS](#cve-2018-14042-bootstrap-xss) | Optional | `packages.config:7` |
| [CVE-2015-9251: jQuery XSS](#cve-2015-9251-jquery-xss) | Optional | `packages.config:8` |

### Code-level vulnerabilities

| Finding | Severity | Evidence |
|---|---|---|
| [CWE-606: Unchecked upload count in loop](#cwe-606-unchecked-upload-count-in-loop) | Potential | `Controllers/HomeController.cs:102` |
| [CWE-665: Blob container initialization depends on prior page access](#cwe-665-blob-container-initialization-depends-on-prior-page-access) | Potential | `Controllers/HomeController.cs:47` |
| [CWE-567: Unsynchronized static blob container](#cwe-567-unsynchronized-static-blob-container) | Potential | `Controllers/HomeController.cs:47` |
| [CWE-732: Public blob read permission](#cwe-732-public-blob-read-permission) | Optional | `Controllers/HomeController.cs:66` |
| [CWE-778: Missing security-event logging](#cwe-778-missing-security-event-logging) | Potential | `Controllers/HomeController.cs:97` |
| [CWE-434: Unrestricted file uploads](#cwe-434-unrestricted-file-uploads) | Mandatory | `Controllers/HomeController.cs:97` |
| [CWE-79: Client-side HTML injection from filename](#cwe-79-client-side-html-injection-from-filename) | Optional | `Views/Home/Index.cshtml:80` |

## Codebase Insights

- [Architecture Diagram](facts/architecture-diagram.md)
- [Dependency Map](facts/dependency-map.md)
- [API & Service Communication Contracts](facts/api-service-contracts.md)
- [Data Architecture & Persistence Layer](facts/data-architecture.md)
- [Configuration & Externalized Settings Inventory](facts/configuration-inventory.md)
- [Core Business Workflows](facts/business-workflows.md)

## Finding Details

### CVE-2022-30187: Azure Blob Storage Encryption Library padding oracle

Declared Azure.Storage.Blobs 12.9.1 is within the advisory's affected range; the assessment identified 12.13.0 as the first patched version.

### CVE-2024-21907: Newtonsoft.Json exceptional condition handling

Declared Newtonsoft.Json 6.0.8 is below the patched version 13.0.1.

### CVE-2018-14040: Bootstrap cross-site scripting

Declared Bootstrap 3.0.0 is within an affected version range; the advisory lists 3.4.0 as patched for the applicable 2.x/3.x range.

### CVE-2021-21252: jquery-validation regular-expression DoS

Declared jQuery.Validation 1.11.1 is below the patched version 1.19.3.

### CVE-2020-11023: jQuery potential XSS

Declared jQuery 1.10.2 is within the advisory's affected range.

### CVE-2019-11358: jQuery XSS

Declared jQuery 1.10.2 is within the advisory's affected range.

### CVE-2019-8331: Bootstrap XSS

Declared Bootstrap 3.0.0 is within the advisory's affected range.

### CVE-2018-20677: Bootstrap XSS

Declared Bootstrap 3.0.0 is within the advisory's affected range.

### CVE-2018-20676: Bootstrap XSS

Declared Bootstrap 3.0.0 is within the advisory's affected range.

### CVE-2016-10735: Bootstrap XSS

Declared Bootstrap 3.0.0 is within the advisory's affected range.

### CVE-2018-8269: ASP.NET Core denial of service advisory

The advisory query associated a finding with Microsoft.Data.OData 5.6.4, declared at `packages.config:17`. The NuGet dependency-list command could not resolve the project on this runner, so the dependency match should be reviewed before remediation.

### CVE-2018-14042: Bootstrap XSS

Declared Bootstrap 3.0.0 is within an affected version range.

### CVE-2015-9251: jQuery XSS

Declared jQuery 1.10.2 is below the patched versions listed by the advisory.

### CWE-606: Unchecked upload count in loop

`UploadAsync` uses the uploaded file collection count as the loop bound and has no application-level cap on the number of per-request uploads.

### CWE-665: Blob container initialization depends on prior page access

The static blob container is initialized in `Index`, while other actions access it without guaranteeing that initialization has occurred.

### CWE-567: Unsynchronized static blob container

Concurrent requests share the static blob-container field, which is assigned and read without synchronization.

### CWE-732: Public blob read permission

Container creation explicitly enables public blob access.

### CWE-778: Missing security-event logging

Upload and delete actions do not write security-relevant operations to an application log or audit trail.

### CWE-434: Unrestricted file uploads

`UploadAsync` accepts files without checking their type before uploading them to the publicly readable container.

### CWE-79: Client-side HTML injection from filename

The browser-supplied filename is concatenated into an HTML string and assigned to `innerHTML`.
