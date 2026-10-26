# Security Assessment Report

**Generated:** 2026-10-26T20:42:52.859514Z

## Summary

| Metric | Count |
|--------|-------|
| Total Findings | 25 |
| CVE Vulnerabilities | 13 |
| CWE Vulnerabilities | 12 |
| Total Rules Assessed | 59 |
| Rules Passed | 47 |

### By Severity

| Severity | Count |
|----------|-------|
| mandatory | 4 |
| optional | 15 |
| potential | 6 |

## CVE Findings (Dependency Vulnerabilities)

### CVE-2022-30187: Microsoft: CBC Padding Oracle in Azure Blob Storage Encryption Library
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:5

[CVE-2022-30187](https://github.com/advisories/GHSA-64x4-9hc6-r2h6) Microsoft: CBC Padding Oracle in Azure Blob Storage Encryption Library

Severity: MEDIUM

Affected dependencies:
  - Azure.Storage.Blobs:12.9.1 (declared at WebApp-Storage-DotNet/packages.config:5)

Recommended fix:
  - Upgrade to 12.13.0 or later

### CVE-2024-21907: Improper Handling of Exceptional Conditions in Newtonsoft.Json
- **Severity:** mandatory
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:23

[CVE-2024-21907](https://github.com/advisories/GHSA-5crp-9r3c-p9vr) Improper Handling of Exceptional Conditions in Newtonsoft.Json

Severity: HIGH

Affected dependencies:
  - Newtonsoft.Json:6.0.8 (declared at WebApp-Storage-DotNet/packages.config:23)

Recommended fix:
  - Upgrade to 13.0.1 or later

### CVE-2018-14040: Bootstrap vulnerable to Cross-Site Scripting (XSS)
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7, WebApp-Storage-DotNet/packages.config:7

[CVE-2018-14040](https://github.com/advisories/GHSA-3wqf-4x89-9g79) Bootstrap vulnerable to Cross-Site Scripting (XSS)

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7)

Recommended fix:
  - Upgrade to 3.4.0 or later
  - Upgrade to 4.1.2 or later

### CVE-2021-21252: Regular Expression Denial of Service in jquery-validation
- **Severity:** mandatory
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:9

[CVE-2021-21252](https://github.com/advisories/GHSA-jxwx-85vp-gvwm) Regular Expression Denial of Service in jquery-validation

Severity: HIGH

Affected dependencies:
  - jQuery.Validation:1.11.1 (declared at WebApp-Storage-DotNet/packages.config:9)

Recommended fix:
  - Upgrade to 1.19.3 or later

### CVE-2020-11023: Potential XSS vulnerability in jQuery
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:8

[CVE-2020-11023](https://github.com/advisories/GHSA-jpcq-cgw6-v4j6) Potential XSS vulnerability in jQuery

Severity: MEDIUM

Affected dependencies:
  - jQuery:1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8)

Recommended fix:
  - Upgrade to 3.5.0 or later

### CVE-2019-11358: XSS in jQuery as used in Drupal, Backdrop CMS, and other products
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:8

[CVE-2019-11358](https://github.com/advisories/GHSA-6c3j-c64m-qhgq) XSS in jQuery as used in Drupal, Backdrop CMS, and other products

Severity: MEDIUM

Affected dependencies:
  - jQuery:1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8)

Recommended fix:
  - Upgrade to 3.4.0 or later

### CVE-2019-8331: Bootstrap Vulnerable to Cross-Site Scripting
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7, WebApp-Storage-DotNet/packages.config:7

[CVE-2019-8331](https://github.com/advisories/GHSA-9v3m-8fp8-mj99) Bootstrap Vulnerable to Cross-Site Scripting

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7)

Recommended fix:
  - Upgrade to 3.4.1 or later
  - Upgrade to 4.3.1 or later

### CVE-2018-20677: bootstrap Cross-site Scripting vulnerability
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2018-20677](https://github.com/advisories/GHSA-ph58-4vrj-w6hr) bootstrap Cross-site Scripting vulnerability

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7)

Recommended fix:
  - Upgrade to 3.4.0 or later

### CVE-2018-20676: XSS vulnerability that affects bootstrap
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2018-20676](https://github.com/advisories/GHSA-3mgp-fx93-9xv5) XSS vulnerability that affects bootstrap

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7)

Recommended fix:
  - Upgrade to 3.4.0 or later

### CVE-2016-10735: Bootstrap Cross-site Scripting vulnerability
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7, WebApp-Storage-DotNet/packages.config:7

[CVE-2016-10735](https://github.com/advisories/GHSA-4p24-vmcr-4gqj) Bootstrap Cross-site Scripting vulnerability

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7)

Recommended fix:
  - Upgrade to 3.4.0 or later
  - Upgrade to 4.0.0-beta.2 or later

### CVE-2018-8269: Denial of service in ASP.NET Core
- **Severity:** mandatory
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:17

[CVE-2018-8269](https://github.com/advisories/GHSA-mv2r-q4g5-j8q5) Denial of service in ASP.NET Core

Severity: HIGH

Affected dependencies:
  - Microsoft.Data.OData:5.6.4 (declared at WebApp-Storage-DotNet/packages.config:17)

Recommended fix:
  - Upgrade to 5.8.4 or later

### CVE-2018-14042: Bootstrap Cross-site Scripting vulnerability
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7, WebApp-Storage-DotNet/packages.config:7

[CVE-2018-14042](https://github.com/advisories/GHSA-7mvr-5x2g-wfc8) Bootstrap Cross-site Scripting vulnerability

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7)

Recommended fix:
  - Upgrade to 3.4.0 or later
  - Upgrade to 4.1.2 or later

### CVE-2015-9251: Cross-Site Scripting (XSS) in jquery
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:8, WebApp-Storage-DotNet/packages.config:8

[CVE-2015-9251](https://github.com/advisories/GHSA-rmxg-73gg-4p98) Cross-Site Scripting (XSS) in jquery

Severity: MEDIUM

Affected dependencies:
  - jQuery:1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8)
  - jQuery:1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8)

Recommended fix:
  - Upgrade to 1.12.2 or later
  - Upgrade to 3.0.0 or later

## CWE Findings (Code-Level Vulnerabilities)

### CWE-606: Unchecked Input for Loop Condition
- **Category:** Code Quality
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

UploadAsync sets fileCount directly from Request.Files.Count at line 102 and iterates to that unbounded value at lines 104-110. Each iteration performs an upload without an application-level file-count limit, so a request containing many parts can cause excessive work.

### CWE-665: Improper Initialization
- **Category:** Code Quality
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

The static blobContainer resource is declared without initialization at line 47 and is assigned only when Index runs at line 65. UploadAsync and the delete actions use it without ensuring initialization (for example line 108), so a direct request before Index can access an uninitialized resource.

### CWE-543: Use of Singleton Pattern Without Synchronization in a Multithreaded Context
- **Category:** Concurrency & Synchronization
- **Severity:** potential
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

The static BlobContainerClient field is shared as a single instance and is initialized from the Index request without synchronization (lines 47, 63-66). Concurrent requests can access the shared resource during initialization.

### CWE-567: Unsynchronized Access to Shared Data in a Multithreaded Context
- **Category:** Concurrency & Synchronization
- **Severity:** potential
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

HomeController.blobContainer is static mutable state (line 47), assigned in Index (lines 63-66) and read by separate UploadAsync/Delete actions (for example line 108), without synchronization. Concurrent first requests can observe null or interleave assignment and use.

### CWE-820: Missing Synchronization
- **Category:** Concurrency & Synchronization
- **Severity:** potential
- **Story Points:** 8
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

The application shares and mutates the static blobContainer across MVC requests (line 47), but does not synchronize initialization in Index with reads from UploadAsync and delete actions (lines 63-66 and 108).

### CWE-732: Incorrect Permission Assignment for Critical Resource
- **Category:** Credentials & Secrets
- **Severity:** optional
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

Index creates the container with PublicAccessType.Blob at line 66, allowing unauthenticated public reads of uploaded blobs. This assigns broad read permissions to stored user content.

### CWE-778: Insufficient Logging
- **Category:** Credentials & Secrets
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

UploadAsync and the delete actions perform security-relevant storage modifications, but failures only populate ViewData and return an error view (for example lines 114-119); no security/audit logging is performed for these operations.

### CWE-22: Improper Limitation of a Pathname to a Restricted Directory ('Path Traversal')
- **Category:** File & Path Security
- **Severity:** optional
- **Story Points:** 8
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

UploadAsync passes the client-provided files[i].FileName to BlobClient.UploadAsync(string path) at line 109. This overload treats the value as a server-side filesystem path; the filename is not constrained to a restricted directory, allowing path elements to select a file outside an intended upload area.

### CWE-23: Relative Path Traversal
- **Category:** File & Path Security
- **Severity:** optional
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

UploadAsync passes files[i].FileName directly to the local-path BlobClient.UploadAsync overload at line 109. Relative path segments in the client-controlled filename are not normalized or constrained before the SDK opens the path.

### CWE-36: Absolute Path Traversal
- **Category:** File & Path Security
- **Severity:** optional
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

UploadAsync passes files[i].FileName directly to BlobClient.UploadAsync(string path) at line 109. An absolute client-supplied path can be interpreted as the server-side file to upload without restriction to an intended directory.

### CWE-434: Unrestricted Upload of File with Dangerous Type
- **Category:** File & Path Security
- **Severity:** mandatory
- **Story Points:** 8
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

UploadAsync accepts each submitted file without checking its extension or content type before uploading it to the blob container at lines 101-110. The container is created with public blob access in Index at line 66, so arbitrary uploaded types become publicly retrievable; no upload type restriction or content inspection is present.

### CWE-79: Improper Neutralization of Input During Web Page Generation ('Cross-site Scripting')
- **Category:** Injection Attacks
- **Severity:** optional
- **Story Points:** 8
- **Files:** WebApp-Storage-DotNet/Views/Home/Index.cshtml

DisplayFilesToUpload() concatenates file.name, which is controlled by the selected/uploaded file name, into an HTML string at line 80 and writes it using innerHTML at line 85. The filename is not HTML-escaped before reaching the DOM sink, allowing markup/script injection in the page.
