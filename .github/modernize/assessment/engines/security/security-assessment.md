# Security Assessment Report

**Generated:** 2026-10-26T19:49:05.500794Z

## Summary

| Metric | Count |
|--------|-------|
| Total Findings | 23 |
| CVE Vulnerabilities | 13 |
| CWE Vulnerabilities | 10 |
| Total Rules Assessed | 59 |
| Rules Passed | 49 |

### By Severity

| Severity | Count |
|----------|-------|
| mandatory | 4 |
| optional | 15 |
| potential | 4 |

## CVE Findings (Dependency Vulnerabilities)

### CVE-2018-8269: Denial of service in ASP.NET Core
- **Severity:** mandatory
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:17

[CVE-2018-8269](https://github.com/advisories/GHSA-mv2r-q4g5-j8q5): Denial of service in ASP.NET Core

Severity: HIGH

Affected dependencies:
  - Microsoft.Data.OData:5.6.4 (declared at WebApp-Storage-DotNet/packages.config:17; vulnerable range: < 5.8.4; first patched: 5.8.4)

Recommended fix: upgrade affected packages to 5.8.4 or later.

### CVE-2021-21252: Regular Expression Denial of Service in jquery-validation
- **Severity:** mandatory
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:9

[CVE-2021-21252](https://github.com/advisories/GHSA-jxwx-85vp-gvwm): Regular Expression Denial of Service in jquery-validation

Severity: HIGH

Affected dependencies:
  - jQuery.Validation:1.11.1 (declared at WebApp-Storage-DotNet/packages.config:9; vulnerable range: < 1.19.3; first patched: 1.19.3)

Recommended fix: upgrade affected packages to 1.19.3 or later.

### CVE-2024-21907: Improper Handling of Exceptional Conditions in Newtonsoft.Json
- **Severity:** mandatory
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:23

[CVE-2024-21907](https://github.com/advisories/GHSA-5crp-9r3c-p9vr): Improper Handling of Exceptional Conditions in Newtonsoft.Json

Severity: HIGH

Affected dependencies:
  - Newtonsoft.Json:6.0.8 (declared at WebApp-Storage-DotNet/packages.config:23; vulnerable range: < 13.0.1; first patched: 13.0.1)

Recommended fix: upgrade affected packages to 13.0.1 or later.

### CVE-2015-9251: Cross-Site Scripting (XSS) in jquery
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:8

[CVE-2015-9251](https://github.com/advisories/GHSA-rmxg-73gg-4p98): Cross-Site Scripting (XSS) in jquery

Severity: MEDIUM

Affected dependencies:
  - jQuery:1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8; vulnerable range: < 1.12.2; first patched: 1.12.2)
  - jQuery:1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8; vulnerable range: >= 1.12.3, < 3.0.0; first patched: 3.0.0)
  - jQuery:1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8; vulnerable range: < 1.12.2; first patched: 1.12.2)
  - jQuery:1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8; vulnerable range: >= 1.12.3, < 3.0.0; first patched: 3.0.0)

Recommended fix: upgrade affected packages to 1.12.2, 3.0.0 or later.

### CVE-2016-10735: Bootstrap Cross-site Scripting vulnerability
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2016-10735](https://github.com/advisories/GHSA-4p24-vmcr-4gqj): Bootstrap Cross-site Scripting vulnerability

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: >= 4.0.0-beta, < 4.0.0-beta.2; first patched: 4.0.0-beta.2)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: >= 2.0.4, < 3.4.0; first patched: 3.4.0)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: < 4.0.0-beta.2; first patched: 4.0.0-beta.2)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: >= 2.0.4, < 3.4.0; first patched: 3.4.0)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: >= 4.0.0-beta, < 4.0.0-beta.2; first patched: 4.0.0-beta.2)

Recommended fix: upgrade affected packages to 3.4.0, 4.0.0-beta.2 or later.

### CVE-2018-14040: Bootstrap vulnerable to Cross-Site Scripting (XSS)
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2018-14040](https://github.com/advisories/GHSA-3wqf-4x89-9g79): Bootstrap vulnerable to Cross-Site Scripting (XSS)

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: >= 4.0.0, < 4.1.2; first patched: 4.1.2)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: >= 4.0.0, < 4.1.2; first patched: 4.1.2)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: >= 2.3.0, < 3.4.0; first patched: 3.4.0)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: >= 2.3.0, < 3.4.0; first patched: 3.4.0)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: >= 2.3.0, < 3.4.0; first patched: 3.4.0)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: >= 4.0.0, < 4.1.2; first patched: 4.1.2)

Recommended fix: upgrade affected packages to 3.4.0, 4.1.2 or later.

### CVE-2018-14042: Bootstrap Cross-site Scripting vulnerability
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2018-14042](https://github.com/advisories/GHSA-7mvr-5x2g-wfc8): Bootstrap Cross-site Scripting vulnerability

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: >= 4.0.0, < 4.1.2; first patched: 4.1.2)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: >= 2.3.0, < 3.4.0; first patched: 3.4.0)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: >= 4.0.0, < 4.1.2; first patched: 4.1.2)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: >= 2.3.0, < 3.4.0; first patched: 3.4.0)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: >= 4.0.0, < 4.1.2; first patched: 4.1.2)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: >= 2.3.0, < 3.4.0; first patched: 3.4.0)

Recommended fix: upgrade affected packages to 3.4.0, 4.1.2 or later.

### CVE-2018-20676: XSS vulnerability that affects bootstrap
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2018-20676](https://github.com/advisories/GHSA-3mgp-fx93-9xv5): XSS vulnerability that affects bootstrap

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: < 3.4.0; first patched: 3.4.0)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: < 3.4.0; first patched: 3.4.0)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: < 3.4.0; first patched: 3.4.0)

Recommended fix: upgrade affected packages to 3.4.0 or later.

### CVE-2018-20677: bootstrap Cross-site Scripting vulnerability
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2018-20677](https://github.com/advisories/GHSA-ph58-4vrj-w6hr): bootstrap Cross-site Scripting vulnerability

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: < 3.4.0; first patched: 3.4.0)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: < 3.4.0; first patched: 3.4.0)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: < 3.4.0; first patched: 3.4.0)

Recommended fix: upgrade affected packages to 3.4.0 or later.

### CVE-2019-11358: XSS in jQuery as used in Drupal, Backdrop CMS, and other products
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:8

[CVE-2019-11358](https://github.com/advisories/GHSA-6c3j-c64m-qhgq): XSS in jQuery as used in Drupal, Backdrop CMS, and other products

Severity: MEDIUM

Affected dependencies:
  - jQuery:1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8; vulnerable range: >= 1.1.4, < 3.4.0; first patched: 3.4.0)
  - jQuery:1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8; vulnerable range: >= 1.1.4, < 3.4.0; first patched: 3.4.0)

Recommended fix: upgrade affected packages to 3.4.0 or later.

### CVE-2019-8331: Bootstrap Vulnerable to Cross-Site Scripting
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2019-8331](https://github.com/advisories/GHSA-9v3m-8fp8-mj99): Bootstrap Vulnerable to Cross-Site Scripting

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: < 4.3.1; first patched: 4.3.1)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: >= 4.0.0, < 4.3.1; first patched: 4.3.1)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: >= 3.0.0, < 3.4.1; first patched: 3.4.1)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: >= 4.0.0, < 4.3.1; first patched: 4.3.1)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; vulnerable range: >= 3.0.0, < 3.4.1; first patched: 3.4.1)

Recommended fix: upgrade affected packages to 3.4.1, 4.3.1 or later.

### CVE-2020-11023: Potential XSS vulnerability in jQuery
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:8

[CVE-2020-11023](https://github.com/advisories/GHSA-jpcq-cgw6-v4j6): Potential XSS vulnerability in jQuery

Severity: MEDIUM

Affected dependencies:
  - jQuery:1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8; vulnerable range: >= 1.0.3, < 3.5.0; first patched: 3.5.0)
  - jQuery:1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8; vulnerable range: >= 1.0.3, < 3.5.0; first patched: 3.5.0)

Recommended fix: upgrade affected packages to 3.5.0 or later.

### CVE-2022-30187: Microsoft: CBC Padding Oracle in Azure Blob Storage Encryption Library
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:5

[CVE-2022-30187](https://github.com/advisories/GHSA-64x4-9hc6-r2h6): Microsoft: CBC Padding Oracle in Azure Blob Storage Encryption Library

Severity: MEDIUM

Affected dependencies:
  - Azure.Storage.Blobs:12.9.1 (declared at WebApp-Storage-DotNet/packages.config:5; vulnerable range: < 12.13.0; first patched: 12.13.0)

Recommended fix: upgrade affected packages to 12.13.0 or later.

## CWE Findings (Code-Level Vulnerabilities)

### CWE-606: Unchecked Input for Loop Condition
- **Category:** Code Quality
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:101-107

HomeController.UploadAsync derives fileCount from the client-controlled multipart Request.Files collection and loops from zero to fileCount without an application-level count limit. A request containing a very large number of files can force repeated per-file processing and blob upload operations.

### CWE-567: Unsynchronized Access to Shared Data in a Multithreaded Context
- **Category:** Concurrency & Synchronization
- **Severity:** potential
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:47, WebApp-Storage-DotNet/Controllers/HomeController.cs:65-66, WebApp-Storage-DotNet/Controllers/HomeController.cs:108

HomeController.blobContainer is a mutable static field. Each concurrent Index request assigns a BlobContainerClient to it, while upload and delete requests read the same field without synchronization. Concurrent requests can overwrite or observe shared state without a defined ordering.

### CWE-820: Missing Synchronization
- **Category:** Concurrency & Synchronization
- **Severity:** potential
- **Story Points:** 8
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:47, WebApp-Storage-DotNet/Controllers/HomeController.cs:65-66, WebApp-Storage-DotNet/Controllers/HomeController.cs:108

The static BlobContainerClient field is shared by concurrent ASP.NET requests. It is reassigned in Index and accessed in upload/delete actions without synchronization, so concurrent operations can race on the shared reference.

### CWE-732: Incorrect Permission Assignment for Critical Resource
- **Category:** Credentials & Secrets
- **Severity:** optional
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:66

HomeController.Index creates the image container using PublicAccessType.Blob, making each blob publicly readable without an authenticated application check. This assigns public read permissions to uploaded gallery content.

### CWE-778: Insufficient Logging
- **Category:** Credentials & Secrets
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:97-118, WebApp-Storage-DotNet/Controllers/HomeController.cs:128-173

The upload and deletion actions perform security-relevant storage changes but do not write audit or application logs for successful operations. Exceptions are placed in ViewData and returned to the caller instead of being recorded, leaving no server-side event trail for these changes or failures.

### CWE-22: Improper Limitation of a Pathname to a Restricted Directory ('Path Traversal')
- **Category:** File & Path Security
- **Severity:** optional
- **Story Points:** 8
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:109

HomeController.UploadAsync passes the client-supplied files[i].FileName directly to BlobClient.UploadAsync(string), which treats the string as a local file path. The path is not restricted to an upload directory, so crafted relative traversal components can cause the server to read a file outside the intended upload location.

### CWE-23: Relative Path Traversal
- **Category:** File & Path Security
- **Severity:** optional
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:109

HomeController.UploadAsync passes the client-supplied files[i].FileName to BlobClient.UploadAsync(string) as a local file path without restricting or canonicalizing it. A crafted relative path containing traversal components can therefore select a file outside an intended upload directory.

### CWE-36: Absolute Path Traversal
- **Category:** File & Path Security
- **Severity:** optional
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:109

HomeController.UploadAsync uses the client-supplied files[i].FileName as the local path passed to BlobClient.UploadAsync(string). No restriction prevents an absolute path from resolving to a server-side file outside an intended upload directory.

### CWE-434: Unrestricted Upload of File with Dangerous Type
- **Category:** File & Path Security
- **Severity:** mandatory
- **Story Points:** 8
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:66, WebApp-Storage-DotNet/Controllers/HomeController.cs:101-109

HomeController.UploadAsync accepts all posted files without checking extension, content type, or file content before uploading them to the gallery container. The container is created with public blob access in HomeController.Index, and uploaded objects are exposed as browser-accessible blob URLs, allowing active content such as HTML or script-bearing image formats to be hosted without type restrictions.

### CWE-79: Improper Neutralization of Input During Web Page Generation ('Cross-site Scripting')
- **Category:** Injection Attacks
- **Severity:** optional
- **Story Points:** 8
- **Files:** WebApp-Storage-DotNet/Views/Home/Index.cshtml:80-85

DisplayFilesToUpload appends the user-controlled File.name value directly into an HTML string and assigns the string to FilesToUpload.innerHTML without HTML encoding. A filename containing markup can be interpreted as HTML or script by the browser.
