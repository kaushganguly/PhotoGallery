# Security Assessment Report

**Generated:** 2026-10-21T13:13:50.123870Z

## Summary

| Metric | Count |
|--------|-------|
| Total Findings | 15 |
| CVE Vulnerabilities | 3 |
| CWE Vulnerabilities | 12 |
| Total Rules Assessed | 59 |
| Rules Passed | 47 |

### By Severity

| Severity | Count |
|----------|-------|
| mandatory | 4 |
| optional | 5 |
| potential | 6 |

> **Coverage note:** The legacy project could not be loaded by `dotnet list package` on this Linux runner because its Visual Studio Web Application targets are missing. CVE matching therefore used the 34 declared packages in `packages.config`; a resolved transitive dependency graph was unavailable.

## CVE Findings (Dependency Vulnerabilities)

### CVE-2024-21907: Improper Handling of Exceptional Conditions in Newtonsoft.Json
- **Severity:** mandatory
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:23

[CVE-2024-21907](https://github.com/advisories/GHSA-5crp-9r3c-p9vr): Improper Handling of Exceptional Conditions in Newtonsoft.Json

Severity: HIGH

Affected dependencies:
  - Newtonsoft.Json:6.0.8 (declared at WebApp-Storage-DotNet/packages.config:23)

Recommended fixes:
  - Upgrade Newtonsoft.Json to one of the patched versions: 13.0.1

### CVE-2021-21252: Regular Expression Denial of Service in jquery-validation
- **Severity:** mandatory
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:9

[CVE-2021-21252](https://github.com/advisories/GHSA-jxwx-85vp-gvwm): Regular Expression Denial of Service in jquery-validation

Severity: HIGH

Affected dependencies:
  - jQuery.Validation:1.11.1 (declared at WebApp-Storage-DotNet/packages.config:9)

Recommended fixes:
  - Upgrade jQuery.Validation to one of the patched versions: 1.19.3

### CVE-2018-8269: Denial of service in ASP.NET Core
- **Severity:** mandatory
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:17

[CVE-2018-8269](https://github.com/advisories/GHSA-mv2r-q4g5-j8q5): Denial of service in ASP.NET Core

Severity: HIGH

Affected dependencies:
  - Microsoft.Data.OData:5.6.4 (declared at WebApp-Storage-DotNet/packages.config:17)

Recommended fixes:
  - Upgrade Microsoft.Data.OData to one of the patched versions: 5.8.4

## CWE Findings (Code-Level Vulnerabilities)

### CWE-606: Unchecked Input for Loop Condition
- **Category:** Code Quality
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

HomeController.UploadAsync loops while i < fileCount, where fileCount comes directly from Request.Files.Count. There is no application-level upper bound on file count, allowing a request with an excessive number of files to drive unbounded per-file processing (lines 101-109).

### CWE-665: Improper Initialization
- **Category:** Code Quality
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

The static blobContainer is only assigned inside HomeController.Index (line 60), while UploadAsync, DeleteImage, and DeleteAll dereference it without ensuring initialization. Directly invoking those actions before Index initializes the resource can result in use of a null container (e.g., lines 108-109 and 135).

### CWE-567: Unsynchronized Access to Shared Data in a Multithreaded Context
- **Category:** Concurrency & Synchronization
- **Severity:** potential
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

HomeController.blobContainer is a mutable static field assigned during Index and read by UploadAsync, DeleteImage, and DeleteAll without synchronization (lines 37, 60, 108, 135). Concurrent requests can access or replace this shared state without a synchronization mechanism.

### CWE-820: Missing Synchronization
- **Category:** Concurrency & Synchronization
- **Severity:** potential
- **Story Points:** 8
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

The static blobContainer field is shared by concurrent MVC requests; Index assigns it while other actions read and use it, with no synchronization (lines 37, 60, 108, 135).

### CWE-732: Incorrect Permission Assignment for Critical Resource
- **Category:** Credentials & Secrets
- **Severity:** optional
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

HomeController.Index creates the blob container using PublicAccessType.Blob (line 60), which allows unauthenticated public reads of every blob in the container. The repository config uses development storage, but the code explicitly enables public blob access.

### CWE-778: Insufficient Logging
- **Category:** Credentials & Secrets
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

UploadAsync, DeleteImage, and DeleteAll perform file operations without recording security/audit events. Their exception handlers only place exception details in ViewData and return an error view (lines 114-118); no logging mechanism is present.

### CWE-22: Improper Limitation of a Pathname to a Restricted Directory ('Path Traversal')
- **Category:** File & Path Security
- **Severity:** optional
- **Story Points:** 8
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

HomeController.UploadAsync passes the request-controlled HttpPostedFileBase.FileName directly to BlobClient.UploadAsync as a local filesystem path. The path is not constrained to an application upload directory, so traversal elements can make the process read a file outside any intended upload directory (line 109).

### CWE-23: Relative Path Traversal
- **Category:** File & Path Security
- **Severity:** optional
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

HomeController.UploadAsync passes the client-supplied files[i].FileName to BlobClient.UploadAsync as a local path without canonicalization or containment checks. A relative path containing parent-directory segments can refer outside an intended upload directory (line 109).

### CWE-36: Absolute Path Traversal
- **Category:** File & Path Security
- **Severity:** optional
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

HomeController.UploadAsync passes the client-supplied files[i].FileName directly to BlobClient.UploadAsync as a local filesystem path. An absolute client-supplied path is not restricted to an upload directory (line 109).

### CWE-434: Unrestricted Upload of File with Dangerous Type
- **Category:** File & Path Security
- **Severity:** mandatory
- **Story Points:** 8
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

HomeController.UploadAsync accepts request files without checking extensions or content type and uploads them to the public blob container. The code therefore permits arbitrary dangerous file types to be stored and served publicly (lines 101-109).

### CWE-79: Improper Neutralization of Input During Web Page Generation ('Cross-site Scripting')
- **Category:** Injection Attacks
- **Severity:** optional
- **Story Points:** 8
- **Files:** WebApp-Storage-DotNet/Views/Home/Index.cshtml

Views/Home/Index.cshtml:80 appends the user-controlled file.name directly to an HTML string, and line 85 assigns that string to innerHTML without encoding. A selected filename containing HTML markup can be interpreted as DOM content.

### CWE-99: Improper Control of Resource Identifiers ('Resource Injection')
- **Category:** Injection Attacks
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

HomeController.DeleteImage receives the user-controlled name, extracts only its basename, and uses that value in blobContainer.GetBlobClient(filename) before deletion (lines 128-136). No ownership or authorization check scopes the target to the caller, so an arbitrary blob identifier in the shared container can be selected.
