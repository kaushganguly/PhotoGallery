# Security Assessment Report

**Generated:** 2026-10-27T01:26:20.280286Z

## Summary

| Metric | Count |
|--------|-------|
| Total Findings | 20 |
| CVE Vulnerabilities | 13 |
| CWE Vulnerabilities | 7 |
| Total Rules Assessed | 59 |
| Rules Passed | 52 |

### By Severity

| Severity | Count |
|----------|-------|
| mandatory | 4 |
| optional | 12 |
| potential | 4 |

## CVE Findings (Dependency Vulnerabilities)

### CVE-2022-30187: Microsoft: CBC Padding Oracle in Azure Blob Storage Encryption Library

- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:5

[CVE-2022-30187](https://github.com/advisories/GHSA-64x4-9hc6-r2h6): Microsoft: CBC Padding Oracle in Azure Blob Storage Encryption Library

Severity: MEDIUM

Affected dependencies:
  - Azure.Storage.Blobs 12.9.1 (declared at WebApp-Storage-DotNet/packages.config:5); affected range < 12.13.0; patched version 12.13.0

Recommended fix:
  - Upgrade to 12.13.0

### CVE-2024-21907: Improper Handling of Exceptional Conditions in Newtonsoft.Json

- **Severity:** mandatory
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:23

[CVE-2024-21907](https://github.com/advisories/GHSA-5crp-9r3c-p9vr): Improper Handling of Exceptional Conditions in Newtonsoft.Json

Severity: HIGH

Affected dependencies:
  - Newtonsoft.Json 6.0.8 (declared at WebApp-Storage-DotNet/packages.config:23); affected range < 13.0.1; patched version 13.0.1

Recommended fix:
  - Upgrade to 13.0.1

### CVE-2018-14040: Bootstrap vulnerable to Cross-Site Scripting (XSS)

- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2018-14040](https://github.com/advisories/GHSA-3wqf-4x89-9g79): Bootstrap vulnerable to Cross-Site Scripting (XSS)

Severity: MEDIUM

Affected dependencies:
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range >= 4.0.0, < 4.1.2; patched version 4.1.2
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range >= 4.0.0, < 4.1.2; patched version 4.1.2
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range >= 2.3.0, < 3.4.0; patched version 3.4.0
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range >= 2.3.0, < 3.4.0; patched version 3.4.0
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range >= 2.3.0, < 3.4.0; patched version 3.4.0
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range >= 4.0.0, < 4.1.2; patched version 4.1.2

Recommended fix:
  - Upgrade to 3.4.0, 4.1.2

### CVE-2021-21252: Regular Expression Denial of Service in jquery-validation

- **Severity:** mandatory
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:9

[CVE-2021-21252](https://github.com/advisories/GHSA-jxwx-85vp-gvwm): Regular Expression Denial of Service in jquery-validation

Severity: HIGH

Affected dependencies:
  - jQuery.Validation 1.11.1 (declared at WebApp-Storage-DotNet/packages.config:9); affected range < 1.19.3; patched version 1.19.3

Recommended fix:
  - Upgrade to 1.19.3

### CVE-2020-11023: Potential XSS vulnerability in jQuery

- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:8

[CVE-2020-11023](https://github.com/advisories/GHSA-jpcq-cgw6-v4j6): Potential XSS vulnerability in jQuery

Severity: MEDIUM

Affected dependencies:
  - jQuery 1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8); affected range >= 1.0.3, < 3.5.0; patched version 3.5.0
  - jQuery 1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8); affected range >= 1.0.3, < 3.5.0; patched version 3.5.0

Recommended fix:
  - Upgrade to 3.5.0

### CVE-2019-11358: XSS in jQuery as used in Drupal, Backdrop CMS, and other products

- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:8

[CVE-2019-11358](https://github.com/advisories/GHSA-6c3j-c64m-qhgq): XSS in jQuery as used in Drupal, Backdrop CMS, and other products

Severity: MEDIUM

Affected dependencies:
  - jQuery 1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8); affected range >= 1.1.4, < 3.4.0; patched version 3.4.0
  - jQuery 1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8); affected range >= 1.1.4, < 3.4.0; patched version 3.4.0

Recommended fix:
  - Upgrade to 3.4.0

### CVE-2019-8331: Bootstrap Vulnerable to Cross-Site Scripting

- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2019-8331](https://github.com/advisories/GHSA-9v3m-8fp8-mj99): Bootstrap Vulnerable to Cross-Site Scripting

Severity: MEDIUM

Affected dependencies:
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range < 4.3.1; patched version 4.3.1
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range >= 4.0.0, < 4.3.1; patched version 4.3.1
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range >= 3.0.0, < 3.4.1; patched version 3.4.1
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range >= 4.0.0, < 4.3.1; patched version 4.3.1
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range >= 3.0.0, < 3.4.1; patched version 3.4.1

Recommended fix:
  - Upgrade to 3.4.1, 4.3.1

### CVE-2018-20677: bootstrap Cross-site Scripting vulnerability

- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2018-20677](https://github.com/advisories/GHSA-ph58-4vrj-w6hr): bootstrap Cross-site Scripting vulnerability

Severity: MEDIUM

Affected dependencies:
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range < 3.4.0; patched version 3.4.0
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range < 3.4.0; patched version 3.4.0
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range < 3.4.0; patched version 3.4.0

Recommended fix:
  - Upgrade to 3.4.0

### CVE-2018-20676: XSS vulnerability that affects bootstrap

- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2018-20676](https://github.com/advisories/GHSA-3mgp-fx93-9xv5): XSS vulnerability that affects bootstrap

Severity: MEDIUM

Affected dependencies:
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range < 3.4.0; patched version 3.4.0
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range < 3.4.0; patched version 3.4.0
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range < 3.4.0; patched version 3.4.0

Recommended fix:
  - Upgrade to 3.4.0

### CVE-2016-10735: Bootstrap Cross-site Scripting vulnerability

- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2016-10735](https://github.com/advisories/GHSA-4p24-vmcr-4gqj): Bootstrap Cross-site Scripting vulnerability

Severity: MEDIUM

Affected dependencies:
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range >= 4.0.0-beta, < 4.0.0-beta.2; patched version 4.0.0-beta.2
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range >= 2.0.4, < 3.4.0; patched version 3.4.0
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range < 4.0.0-beta.2; patched version 4.0.0-beta.2
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range >= 2.0.4, < 3.4.0; patched version 3.4.0
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range >= 4.0.0-beta, < 4.0.0-beta.2; patched version 4.0.0-beta.2

Recommended fix:
  - Upgrade to 3.4.0, 4.0.0-beta.2

### CVE-2018-8269: Denial of service in ASP.NET Core

- **Severity:** mandatory
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:17

[CVE-2018-8269](https://github.com/advisories/GHSA-mv2r-q4g5-j8q5): Denial of service in ASP.NET Core

Severity: HIGH

Affected dependencies:
  - Microsoft.Data.OData 5.6.4 (declared at WebApp-Storage-DotNet/packages.config:17); affected range < 5.8.4; patched version 5.8.4

Recommended fix:
  - Upgrade to 5.8.4

### CVE-2018-14042: Bootstrap Cross-site Scripting vulnerability

- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2018-14042](https://github.com/advisories/GHSA-7mvr-5x2g-wfc8): Bootstrap Cross-site Scripting vulnerability

Severity: MEDIUM

Affected dependencies:
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range >= 4.0.0, < 4.1.2; patched version 4.1.2
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range >= 2.3.0, < 3.4.0; patched version 3.4.0
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range >= 4.0.0, < 4.1.2; patched version 4.1.2
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range >= 2.3.0, < 3.4.0; patched version 3.4.0
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range >= 4.0.0, < 4.1.2; patched version 4.1.2
  - bootstrap 3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7); affected range >= 2.3.0, < 3.4.0; patched version 3.4.0

Recommended fix:
  - Upgrade to 3.4.0, 4.1.2

### CVE-2015-9251: Cross-Site Scripting (XSS) in jquery

- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:8

[CVE-2015-9251](https://github.com/advisories/GHSA-rmxg-73gg-4p98): Cross-Site Scripting (XSS) in jquery

Severity: MEDIUM

Affected dependencies:
  - jQuery 1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8); affected range < 1.12.2; patched version 1.12.2
  - jQuery 1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8); affected range >= 1.12.3, < 3.0.0; patched version 3.0.0
  - jQuery 1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8); affected range < 1.12.2; patched version 1.12.2
  - jQuery 1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8); affected range >= 1.12.3, < 3.0.0; patched version 3.0.0

Recommended fix:
  - Upgrade to 1.12.2, 3.0.0

## CWE Findings (Code-Level Vulnerabilities)

### CWE-606: Unchecked Input for Loop Condition

- **Category:** Code Quality
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:102

UploadAsync assigns Request.Files.Count directly to fileCount and loops until that client-controlled count is exhausted. No application-level cap limits the per-request iteration or resulting blob uploads.

### CWE-665: Improper Initialization

- **Category:** Code Quality
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:47

The static blobContainer is initialized only inside Index (lines 65-66), but UploadAsync, DeleteImage, and DeleteAll use it without ensuring Index has run. Direct requests to those actions before Index leave the resource null and cause operation failures.

### CWE-567: Unsynchronized Access to Shared Data in a Multithreaded Context

- **Category:** Concurrency & Synchronization
- **Severity:** potential
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:47, WebApp-Storage-DotNet/Controllers/HomeController.cs:65, WebApp-Storage-DotNet/Controllers/HomeController.cs:108

HomeController.blobContainer is a static field shared across concurrent MVC requests. Index assigns it while UploadAsync and other actions read it, with no synchronization or safe initialization, so requests can observe an inconsistent lifecycle state.

### CWE-732: Incorrect Permission Assignment for Critical Resource

- **Category:** Credentials & Secrets
- **Severity:** optional
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:66

HomeController.Index creates the blob container with PublicAccessType.Blob, granting anonymous public read access to blob contents. This permission is broader than an access-controlled photo gallery resource.

### CWE-778: Insufficient Logging

- **Category:** Credentials & Secrets
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:97, WebApp-Storage-DotNet/Controllers/HomeController.cs:128, WebApp-Storage-DotNet/Controllers/HomeController.cs:154

UploadAsync, DeleteImage, and DeleteAll perform security-relevant storage changes, but their exception handlers only copy exception text/stack trace into ViewData and do not record upload or deletion events in an application log or audit trail.

### CWE-434: Unrestricted Upload of File with Dangerous Type

- **Category:** File & Path Security
- **Severity:** mandatory
- **Story Points:** 8
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:97, WebApp-Storage-DotNet/Controllers/HomeController.cs:109

HomeController.UploadAsync accepts every item in Request.Files without checking its extension or content type and uploads it to the blob container using the submitted filename extension. The container is initialized with public blob access in HomeController.Index (line 66), allowing arbitrary uploaded content to be served publicly without a file-type restriction.

### CWE-79: Improper Neutralization of Input During Web Page Generation ('Cross-site Scripting')

- **Category:** Injection Attacks
- **Severity:** optional
- **Story Points:** 8
- **Files:** WebApp-Storage-DotNet/Views/Home/Index.cshtml:80, WebApp-Storage-DotNet/Views/Home/Index.cshtml:85

DisplayFilesToUpload concatenates the browser-supplied file.name directly into an HTML string, then assigns that string to FilesToUpload.innerHTML. A specially named local file can therefore inject markup or script into the page when the user selects it.
