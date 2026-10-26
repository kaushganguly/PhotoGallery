# Assessment Report

**Generated:** 2026-10-26T19:15:38.993032Z

## Summary

| Metric | Count |
|---|---:|
| Total Issues (unique findings) | 24 |
| Mandatory | 3 |
| Optional | 15 |
| Potential | 6 |
| CVE findings (minimum medium) | 13 |
| CWE findings | 11 |
| CWE rules assessed | 59 |
| CWE rules not found | 48 |

## Application Information

| Property | Value |
|---|---|
| Application | PhotoGallery |
| Solution | `WebApp-Storage-DotNet.sln` |
| Language | C# |
| Current target | .NET Framework 4.8 |
| Application framework | ASP.NET MVC 5 |
| Requested upgrade target | .NET 10 (`net10.0`) |
| Core AppCAT assessment | Failed to load legacy web project |
| Security assessment | Completed; CVE threshold: medium |
| .NET upgrade assessment | Attempted; MCP reported missing `Microsoft.WebApplication.targets` |

## Assessment Limitations

The core AppCAT assessment did not produce project compatibility findings because the Linux runner could not load the legacy ASP.NET Web Application project. The .NET 10 upgrade assessment also returned the missing-target error; its generated scenario data reports zero projects and zero rules and is retained under [`scenarios/dotnet-version-upgrade/`](./scenarios/dotnet-version-upgrade/). These results must not be interpreted as confirmation that the application has no upgrade issues.

## Findings

<a id="Microsoft_CBC_Padding_Oracle_in_Azure_Blob_Storage_Encryption_Library"></a>
### Microsoft: CBC Padding Oracle in Azure Blob Storage Encryption Library

- **ID:** `CVE-2022-30187`
- **Category:** CVE
- **Severity:** optional
- **Story points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:5

[CVE-2022-30187](https://github.com/advisories/GHSA-64x4-9hc6-r2h6): Microsoft: CBC Padding Oracle in Azure Blob Storage Encryption Library

Severity: MEDIUM

Affected dependencies:
  - Azure.Storage.Blobs:12.9.1 (declared at WebApp-Storage-DotNet/packages.config)

Recommended fix:
  - Upgrade Azure.Storage.Blobs to 12.13.0 or later


<a id="Improper_Handling_of_Exceptional_Conditions_in_Newtonsoft_Json"></a>
### Improper Handling of Exceptional Conditions in Newtonsoft.Json

- **ID:** `CVE-2024-21907`
- **Category:** CVE
- **Severity:** mandatory
- **Story points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:23

[CVE-2024-21907](https://github.com/advisories/GHSA-5crp-9r3c-p9vr): Improper Handling of Exceptional Conditions in Newtonsoft.Json

Severity: HIGH

Affected dependencies:
  - Newtonsoft.Json:6.0.8 (declared at WebApp-Storage-DotNet/packages.config)

Recommended fix:
  - Upgrade Newtonsoft.Json to 13.0.1 or later


<a id="Bootstrap_vulnerable_to_Cross-Site_Scripting_XSS"></a>
### Bootstrap vulnerable to Cross-Site Scripting (XSS)

- **ID:** `CVE-2018-14040`
- **Category:** CVE
- **Severity:** optional
- **Story points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2018-14040](https://github.com/advisories/GHSA-3wqf-4x89-9g79): Bootstrap vulnerable to Cross-Site Scripting (XSS)

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config)

Recommended fix:
  - Upgrade bootstrap to 4.1.2 or later


<a id="Regular_Expression_Denial_of_Service_in_jquery-validation"></a>
### Regular Expression Denial of Service in jquery-validation

- **ID:** `CVE-2021-21252`
- **Category:** CVE
- **Severity:** mandatory
- **Story points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:9

[CVE-2021-21252](https://github.com/advisories/GHSA-jxwx-85vp-gvwm): Regular Expression Denial of Service in jquery-validation

Severity: HIGH

Affected dependencies:
  - jQuery.Validation:1.11.1 (declared at WebApp-Storage-DotNet/packages.config)

Recommended fix:
  - Upgrade jQuery.Validation to 1.19.3 or later


<a id="Potential_XSS_vulnerability_in_jQuery"></a>
### Potential XSS vulnerability in jQuery

- **ID:** `CVE-2020-11023`
- **Category:** CVE
- **Severity:** optional
- **Story points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:8

[CVE-2020-11023](https://github.com/advisories/GHSA-jpcq-cgw6-v4j6): Potential XSS vulnerability in jQuery

Severity: MEDIUM

Affected dependencies:
  - jQuery:1.10.2 (declared at WebApp-Storage-DotNet/packages.config)

Recommended fix:
  - Upgrade jQuery to 3.5.0 or later


<a id="XSS_in_jQuery_as_used_in_Drupal_Backdrop_CMS_and_other_products"></a>
### XSS in jQuery as used in Drupal, Backdrop CMS, and other products

- **ID:** `CVE-2019-11358`
- **Category:** CVE
- **Severity:** optional
- **Story points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:8

[CVE-2019-11358](https://github.com/advisories/GHSA-6c3j-c64m-qhgq): XSS in jQuery as used in Drupal, Backdrop CMS, and other products

Severity: MEDIUM

Affected dependencies:
  - jQuery:1.10.2 (declared at WebApp-Storage-DotNet/packages.config)

Recommended fix:
  - Upgrade jQuery to 3.4.0 or later


<a id="Bootstrap_Vulnerable_to_Cross-Site_Scripting"></a>
### Bootstrap Vulnerable to Cross-Site Scripting

- **ID:** `CVE-2019-8331`
- **Category:** CVE
- **Severity:** optional
- **Story points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2019-8331](https://github.com/advisories/GHSA-9v3m-8fp8-mj99): Bootstrap Vulnerable to Cross-Site Scripting

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config)

Recommended fix:
  - Upgrade bootstrap to 4.3.1 or later


<a id="bootstrap_Cross-site_Scripting_vulnerability"></a>
### bootstrap Cross-site Scripting vulnerability

- **ID:** `CVE-2018-20677`
- **Category:** CVE
- **Severity:** optional
- **Story points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2018-20677](https://github.com/advisories/GHSA-ph58-4vrj-w6hr): bootstrap Cross-site Scripting vulnerability

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config)

Recommended fix:
  - Upgrade bootstrap to 3.4.0 or later


<a id="XSS_vulnerability_that_affects_bootstrap"></a>
### XSS vulnerability that affects bootstrap

- **ID:** `CVE-2018-20676`
- **Category:** CVE
- **Severity:** optional
- **Story points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2018-20676](https://github.com/advisories/GHSA-3mgp-fx93-9xv5): XSS vulnerability that affects bootstrap

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config)

Recommended fix:
  - Upgrade bootstrap to 3.4.0 or later


<a id="Bootstrap_Cross-site_Scripting_vulnerability"></a>
### Bootstrap Cross-site Scripting vulnerability

- **ID:** `CVE-2016-10735`
- **Category:** CVE
- **Severity:** optional
- **Story points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2016-10735](https://github.com/advisories/GHSA-4p24-vmcr-4gqj): Bootstrap Cross-site Scripting vulnerability

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config)

Recommended fix:
  - Upgrade bootstrap to 4.0.0-beta.2 or later


<a id="Denial_of_service_in_ASP_NET_Core"></a>
### Denial of service in ASP.NET Core

- **ID:** `CVE-2018-8269`
- **Category:** CVE
- **Severity:** mandatory
- **Story points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:17

[CVE-2018-8269](https://github.com/advisories/GHSA-mv2r-q4g5-j8q5): Denial of service in ASP.NET Core

Severity: HIGH

Affected dependencies:
  - Microsoft.Data.OData:5.6.4 (declared at WebApp-Storage-DotNet/packages.config)

Recommended fix:
  - Upgrade Microsoft.Data.OData to 5.8.4 or later


<a id="Bootstrap_Cross-site_Scripting_vulnerability"></a>
### Bootstrap Cross-site Scripting vulnerability

- **ID:** `CVE-2018-14042`
- **Category:** CVE
- **Severity:** optional
- **Story points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2018-14042](https://github.com/advisories/GHSA-7mvr-5x2g-wfc8): Bootstrap Cross-site Scripting vulnerability

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config)

Recommended fix:
  - Upgrade bootstrap to 4.1.2 or later


<a id="Cross-Site_Scripting_XSS_in_jquery"></a>
### Cross-Site Scripting (XSS) in jquery

- **ID:** `CVE-2015-9251`
- **Category:** CVE
- **Severity:** optional
- **Story points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:8

[CVE-2015-9251](https://github.com/advisories/GHSA-rmxg-73gg-4p98): Cross-Site Scripting (XSS) in jquery

Severity: MEDIUM

Affected dependencies:
  - jQuery:1.10.2 (declared at WebApp-Storage-DotNet/packages.config)

Recommended fix:
  - Upgrade jQuery to 1.12.2 or later


<a id="Missing_Initialization_of_a_Variable"></a>
### Missing Initialization of a Variable

- **ID:** `CWE-456`
- **Category:** Code Quality
- **Severity:** potential
- **Story points:** 2
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

The static blobContainer field is declared without initialization and receives a value only when Index executes. Other action methods can be invoked before that action initializes it.


<a id="Use_of_Uninitialized_Variable"></a>
### Use of Uninitialized Variable

- **ID:** `CWE-457`
- **Category:** Code Quality
- **Severity:** potential
- **Story points:** 2
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

The static blobContainer field initially has its default null value; UploadAsync, DeleteImage, and DeleteAll use it without ensuring Index has initialized it.


<a id="Unchecked_Input_for_Loop_Condition"></a>
### Unchecked Input for Loop Condition

- **ID:** `CWE-606`
- **Category:** Code Quality
- **Severity:** potential
- **Story points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

UploadAsync derives fileCount directly from the submitted Request.Files collection and loops over every entry without an application-level count limit. The configured request length limit is extremely high, so this input can control excessive repeated storage operations.


<a id="Improper_Initialization"></a>
### Improper Initialization

- **ID:** `CWE-665`
- **Category:** Code Quality
- **Severity:** potential
- **Story points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

The shared BlobContainerClient is initialized only as a side effect of Index. UploadAsync, DeleteImage, and DeleteAll assume it was initialized by a prior request, leaving the storage resource unavailable when those actions are invoked first.


<a id="Unsynchronized_Access_to_Shared_Data_in_a_Multithreaded_Context"></a>
### Unsynchronized Access to Shared Data in a Multithreaded Context

- **ID:** `CWE-567`
- **Category:** Concurrency & Synchronization
- **Severity:** potential
- **Story points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

The static blobContainer field is assigned by each Index request and read by upload and delete requests without synchronization (lines 47, 63-66, 108, 135, and 158). Concurrent requests can observe and replace this shared reference without coordinated initialization.


<a id="Incorrect_Permission_Assignment_for_Critical_Resource"></a>
### Incorrect Permission Assignment for Critical Resource

- **ID:** `CWE-732`
- **Category:** Credentials & Secrets
- **Severity:** optional
- **Story points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

HomeController.Index creates the blob container with PublicAccessType.Blob. This grants anonymous read access to blobs in the container, exposing uploaded image content to anyone who can obtain a blob URI.


<a id="Insufficient_Logging"></a>
### Insufficient Logging

- **ID:** `CWE-778`
- **Category:** Credentials & Secrets
- **Severity:** potential
- **Story points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

The upload and deletion operations can fail or alter stored content, but their exception handlers only place exception details in ViewData and return an error view. No audit or application logging records these events or outcomes.


<a id="Improper_Limitation_of_a_Pathname_to_a_Restricted_Directory_Path_Traversal"></a>
### Improper Limitation of a Pathname to a Restricted Directory ('Path Traversal')

- **ID:** `CWE-22`
- **Category:** File & Path Security
- **Severity:** optional
- **Story points:** 8
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

In HomeController.UploadAsync (line 109), the client-supplied HttpPostedFile.FileName is passed to BlobClient.UploadAsync(string path), which treats the value as a server-side filesystem path. The path is not constrained to an upload directory, so traversal elements may cause reads outside an intended upload location.


<a id="Relative_Path_Traversal"></a>
### Relative Path Traversal

- **ID:** `CWE-23`
- **Category:** File & Path Security
- **Severity:** optional
- **Story points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

In HomeController.UploadAsync (line 109), the client-provided file name is passed as a local path to BlobClient.UploadAsync(string path). Relative traversal segments are not removed or checked against an allowed directory before the SDK reads the path.


<a id="Absolute_Path_Traversal"></a>
### Absolute Path Traversal

- **ID:** `CWE-36`
- **Category:** File & Path Security
- **Severity:** optional
- **Story points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

In HomeController.UploadAsync (line 109), the client-provided file name is passed to the BlobClient.UploadAsync(string path) overload, which opens a local path. No check rejects an absolute path or confines it to a designated upload directory.


<a id="Improper_Neutralization_of_Input_During_Web_Page_Generation_Cross-site_Scripting"></a>
### Improper Neutralization of Input During Web Page Generation ('Cross-site Scripting')

- **ID:** `CWE-79`
- **Category:** Injection Attacks
- **Severity:** optional
- **Story points:** 8
- **Files:** WebApp-Storage-DotNet/Views/Home/Index.cshtml:80-85

The DisplayFilesToUpload JavaScript function appends the user-controlled file.name value directly to an HTML string at line 80 and assigns the string to FilesToUpload.innerHTML at line 85. A crafted upload filename containing HTML can be interpreted as markup and script in the user's browser.

## Codebase Insights

Supplementary application analysis documents:

- [architecture-diagram.md](./facts/architecture-diagram.md) — Application layers and component relationships.
- [dependency-map.md](./facts/dependency-map.md) — Declared external dependencies and compatibility observations.
- [api-service-contracts.md](./facts/api-service-contracts.md) — MVC endpoints and service communication contracts.
- [data-architecture.md](./facts/data-architecture.md) — Storage model, ownership, and persistence.
- [configuration-inventory.md](./facts/configuration-inventory.md) — Configuration sources, profiles, and sensitive settings.
- [business-workflows.md](./facts/business-workflows.md) — Gallery browsing, upload, and deletion workflows.
- [assessment-overview.md](./facts/assessment-overview.md) — Navigation index for supplementary documents.
