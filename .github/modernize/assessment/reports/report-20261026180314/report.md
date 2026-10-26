# PhotoGallery Assessment Report

**Generated:** 2026-10-26T18:03:14Z

## Summary

| Metric | Count |
|---|---:|
| Security findings | 19 |
| CVE findings (medium severity and above) | 13 |
| CWE findings | 6 |
| Core AppCAT projects analyzed | 0 (analysis blocked) |
| .NET upgrade assessment projects analyzed | 0 (project load failed) |

### Security Severity

| Severity | Count |
|---|---:|
| mandatory | 4 |
| optional | 12 |
| potential | 3 |

## Application Information

| Property | Value |
|---|---|
| Project | WebApp-Storage-DotNet |
| Solution | WebApp-Storage-DotNet.sln |
| Language | C# |
| Current framework | .NET Framework 4.8 |
| Upgrade target assessed | net10.0 |

## Assessment Limitations

The core AppCAT analysis could not load the project because the Linux SDK installation does not include `Microsoft/VisualStudio/v18.0/WebApplications/Microsoft.WebApplication.targets`. The .NET upgrade assessment output reports zero projects and zero issues for the same project-load failure; it provides no upgrade compatibility conclusion.

## CVE Findings

### CVE-2022-30187: Microsoft: CBC Padding Oracle in Azure Blob Storage Encryption Library
- **Severity:** optional
- **Files:** WebApp-Storage-DotNet/packages.config:5

[CVE-2022-30187](https://github.com/advisories/GHSA-64x4-9hc6-r2h6): Microsoft: CBC Padding Oracle in Azure Blob Storage Encryption Library

Severity: MEDIUM

Affected dependencies:
  - Azure.Storage.Blobs 12.9.1 (affected range: < 12.13.0; declared at WebApp-Storage-DotNet/packages.config:5). Upgrade to 12.13.0 or later.

### CVE-2024-21907: Improper Handling of Exceptional Conditions in Newtonsoft.Json
- **Severity:** mandatory
- **Files:** WebApp-Storage-DotNet/packages.config:23

[CVE-2024-21907](https://github.com/advisories/GHSA-5crp-9r3c-p9vr): Improper Handling of Exceptional Conditions in Newtonsoft.Json

Severity: HIGH

Affected dependencies:
  - Newtonsoft.Json 6.0.8 (affected range: < 13.0.1; declared at WebApp-Storage-DotNet/packages.config:23). Upgrade to 13.0.1 or later.

### CVE-2018-14040: Bootstrap vulnerable to Cross-Site Scripting (XSS)
- **Severity:** optional
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2018-14040](https://github.com/advisories/GHSA-3wqf-4x89-9g79): Bootstrap vulnerable to Cross-Site Scripting (XSS)

Severity: MEDIUM

Affected dependencies:
  - bootstrap 3.0.0 (affected range: >= 2.3.0, < 3.4.0; declared at WebApp-Storage-DotNet/packages.config:7). Upgrade to 3.4.0 or later.

### CVE-2021-21252: Regular Expression Denial of Service in jquery-validation
- **Severity:** mandatory
- **Files:** WebApp-Storage-DotNet/packages.config:9

[CVE-2021-21252](https://github.com/advisories/GHSA-jxwx-85vp-gvwm): Regular Expression Denial of Service in jquery-validation

Severity: HIGH

Affected dependencies:
  - jQuery.Validation 1.11.1 (affected range: < 1.19.3; declared at WebApp-Storage-DotNet/packages.config:9). Upgrade to 1.19.3 or later.

### CVE-2020-11023: Potential XSS vulnerability in jQuery
- **Severity:** optional
- **Files:** WebApp-Storage-DotNet/packages.config:8

[CVE-2020-11023](https://github.com/advisories/GHSA-jpcq-cgw6-v4j6): Potential XSS vulnerability in jQuery

Severity: MEDIUM

Affected dependencies:
  - jQuery 1.10.2 (affected range: >= 1.0.3, < 3.5.0; declared at WebApp-Storage-DotNet/packages.config:8). Upgrade to 3.5.0 or later.

### CVE-2019-11358: XSS in jQuery as used in Drupal, Backdrop CMS, and other products
- **Severity:** optional
- **Files:** WebApp-Storage-DotNet/packages.config:8

[CVE-2019-11358](https://github.com/advisories/GHSA-6c3j-c64m-qhgq): XSS in jQuery as used in Drupal, Backdrop CMS, and other products

Severity: MEDIUM

Affected dependencies:
  - jQuery 1.10.2 (affected range: >= 1.1.4, < 3.4.0; declared at WebApp-Storage-DotNet/packages.config:8). Upgrade to 3.4.0 or later.

### CVE-2019-8331: Bootstrap Vulnerable to Cross-Site Scripting
- **Severity:** optional
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2019-8331](https://github.com/advisories/GHSA-9v3m-8fp8-mj99): Bootstrap Vulnerable to Cross-Site Scripting

Severity: MEDIUM

Affected dependencies:
  - bootstrap 3.0.0 (affected range: >= 3.0.0, < 3.4.1; declared at WebApp-Storage-DotNet/packages.config:7). Upgrade to 3.4.1 or later.

### CVE-2018-20677: bootstrap Cross-site Scripting vulnerability
- **Severity:** optional
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2018-20677](https://github.com/advisories/GHSA-ph58-4vrj-w6hr): bootstrap Cross-site Scripting vulnerability

Severity: MEDIUM

Affected dependencies:
  - bootstrap 3.0.0 (affected range: < 3.4.0; declared at WebApp-Storage-DotNet/packages.config:7). Upgrade to 3.4.0 or later.

### CVE-2018-20676: XSS vulnerability that affects bootstrap
- **Severity:** optional
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2018-20676](https://github.com/advisories/GHSA-3mgp-fx93-9xv5): XSS vulnerability that affects bootstrap

Severity: MEDIUM

Affected dependencies:
  - bootstrap 3.0.0 (affected range: < 3.4.0; declared at WebApp-Storage-DotNet/packages.config:7). Upgrade to 3.4.0 or later.

### CVE-2016-10735: Bootstrap Cross-site Scripting vulnerability
- **Severity:** optional
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2016-10735](https://github.com/advisories/GHSA-4p24-vmcr-4gqj): Bootstrap Cross-site Scripting vulnerability

Severity: MEDIUM

Affected dependencies:
  - bootstrap 3.0.0 (affected range: >= 2.0.4, < 3.4.0; declared at WebApp-Storage-DotNet/packages.config:7). Upgrade to 3.4.0 or later.

### CVE-2018-8269: Denial of service in ASP.NET Core
- **Severity:** mandatory
- **Files:** WebApp-Storage-DotNet/packages.config:17

[CVE-2018-8269](https://github.com/advisories/GHSA-mv2r-q4g5-j8q5): Denial of service in ASP.NET Core

Severity: HIGH

Affected dependencies:
  - Microsoft.Data.OData 5.6.4 (affected range: < 5.8.4; declared at WebApp-Storage-DotNet/packages.config:17). Upgrade to 5.8.4 or later.

### CVE-2018-14042: Bootstrap Cross-site Scripting vulnerability
- **Severity:** optional
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2018-14042](https://github.com/advisories/GHSA-7mvr-5x2g-wfc8): Bootstrap Cross-site Scripting vulnerability

Severity: MEDIUM

Affected dependencies:
  - bootstrap 3.0.0 (affected range: >= 2.3.0, < 3.4.0; declared at WebApp-Storage-DotNet/packages.config:7). Upgrade to 3.4.0 or later.

### CVE-2015-9251: Cross-Site Scripting (XSS) in jquery
- **Severity:** optional
- **Files:** WebApp-Storage-DotNet/packages.config:8

[CVE-2015-9251](https://github.com/advisories/GHSA-rmxg-73gg-4p98): Cross-Site Scripting (XSS) in jquery

Severity: MEDIUM

Affected dependencies:
  - jQuery 1.10.2 (affected range: < 1.12.2; declared at WebApp-Storage-DotNet/packages.config:8). Upgrade to 1.12.2 or later.

## CWE Findings

### CWE-606: Unchecked Input for Loop Condition
- **Category:** Code Quality
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:101-107, WebApp-Storage-DotNet/Web.config:25

HomeController.UploadAsync assigns Request.Files.Count directly to fileCount and iterates to that count without an application-level file-count limit. The number of files and resulting sequential storage operations are controlled by the multipart request.

### CWE-665: Improper Initialization
- **Category:** Code Quality
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:46-47, WebApp-Storage-DotNet/Controllers/HomeController.cs:57-66, WebApp-Storage-DotNet/Controllers/HomeController.cs:97-109

The static blobContainer field starts null and is assigned only when Index runs. UploadAsync and the delete actions access it without ensuring Index has initialized it, so a direct mutation request before a successful gallery request operates on an uninitialized storage client.

### CWE-732: Incorrect Permission Assignment for Critical Resource
- **Category:** Credentials & Secrets
- **Severity:** optional
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:63-66

HomeController.Index creates the image container with PublicAccessType.Blob. This assigns public read access to stored blobs, allowing unauthenticated clients to read content that may not be intended for public access.

### CWE-778: Insufficient Logging
- **Category:** Credentials & Secrets
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:97-119, WebApp-Storage-DotNet/Controllers/HomeController.cs:128-173

The upload and image-deletion actions perform security-relevant storage mutations, but no audit or logging call records the actor, target blob, or operation result. Exceptions are returned in the error view rather than recorded by an application logger.

### CWE-434: Unrestricted Upload of File with Dangerous Type
- **Category:** File & Path Security
- **Severity:** mandatory
- **Story Points:** 8
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:66, WebApp-Storage-DotNet/Controllers/HomeController.cs:96-110

HomeController.UploadAsync accepts all multipart files from Request.Files and uploads each using a generated name that retains the client-supplied extension. No file-type or content validation is performed. The container is created with public blob access in HomeController.Index, so uploaded content can be retrieved and processed by clients.

### CWE-79: Improper Neutralization of Input During Web Page Generation ('Cross-site Scripting')
- **Category:** Injection Attacks
- **Severity:** optional
- **Story Points:** 8
- **Files:** WebApp-Storage-DotNet/Views/Home/Index.cshtml:78-85

DisplayFilesToUpload concatenates the user-selected file.name into an HTML string and assigns it to FilesToUpload.innerHTML without encoding. A crafted filename containing markup can therefore be interpreted as HTML and execute script in the gallery page's origin when the user selects the file.

## Codebase Insights

> These AI-generated documents may contain inaccuracies or incomplete information; review them as appropriate.

1. [Architecture Diagram](facts/architecture-diagram.md) — Application architecture and component relationships.
2. [Dependency Map](facts/dependency-map.md) — Declared dependencies and compatibility risks.
3. [API & Service Communication Contracts](facts/api-service-contracts.md) — Service catalog and request contracts.
4. [Data Architecture & Persistence Layer](facts/data-architecture.md) — Blob storage model and data ownership.
5. [Configuration & Externalized Settings Inventory](facts/configuration-inventory.md) — Configuration sources, settings, and runtime versions.
6. [Core Business Workflows](facts/business-workflows.md) — Gallery browsing, upload, and deletion workflows.
