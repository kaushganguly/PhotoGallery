# PhotoGallery Assessment Report

> **Assessment limitation:** AppCAT could not load the legacy ASP.NET Web Application project because `Microsoft.WebApplication.targets` is unavailable in this Linux environment. The versioned report is therefore marked security-only; no core AppCAT findings were generated.
>
> The CVE scan used the 34 declared packages in `packages.config`; a resolved transitive dependency graph was unavailable because `dotnet list package` could not load the project.

## Summary

| Metric | Count |
|---|---:|
| Total Issues | 15 |
| Mandatory Blockers | 4 |
| Potential Issues | 6 |
| Optional Issues | 5 |

## Application Information

| Property | Value |
|---|---|
| Project | WebApp-Storage-DotNet |
| Language | C# |
| Framework | ASP.NET MVC 5 / .NET Framework 4.8 |
| Build tools | Legacy MSBuild, NuGet `packages.config` |
| Application type | Photo gallery web application |

## Security Findings

| Issue | Criticality | Story Points | Files |
|---|---|---:|---:|
| [CVE-2018-8269: Denial of service in ASP.NET Core](#denial-of-service-in-aspnet-core) | Mandatory | 1 | 1 |
| [CVE-2024-21907: Improper Handling of Exceptional Conditions in Newtonsoft.Json](#improper-handling-of-exceptional-conditions-in-newtonsoftjson) | Mandatory | 1 | 1 |
| [CVE-2021-21252: Regular Expression Denial of Service in jquery-validation](#regular-expression-denial-of-service-in-jquery-validation) | Mandatory | 1 | 1 |
| [CWE-434: Unrestricted Upload of File with Dangerous Type](#unrestricted-upload-of-file-with-dangerous-type) | Mandatory | 8 | 1 |
| [CWE-99: Improper Control of Resource Identifiers ('Resource Injection')](#improper-control-of-resource-identifiers-resource-injection) | Potential | 3 | 1 |
| [CWE-665: Improper Initialization](#improper-initialization) | Potential | 3 | 1 |
| [CWE-778: Insufficient Logging](#insufficient-logging) | Potential | 3 | 1 |
| [CWE-820: Missing Synchronization](#missing-synchronization) | Potential | 8 | 1 |
| [CWE-606: Unchecked Input for Loop Condition](#unchecked-input-for-loop-condition) | Potential | 3 | 1 |
| [CWE-567: Unsynchronized Access to Shared Data in a Multithreaded Context](#unsynchronized-access-to-shared-data-in-a-multithreaded-context) | Potential | 5 | 1 |
| [CWE-36: Absolute Path Traversal](#absolute-path-traversal) | Optional | 5 | 1 |
| [CWE-22: Improper Limitation of a Pathname to a Restricted Directory ('Path Traversal')](#improper-limitation-of-a-pathname-to-a-restricted-directory-path-traversal) | Optional | 8 | 1 |
| [CWE-79: Improper Neutralization of Input During Web Page Generation ('Cross-site Scripting')](#improper-neutralization-of-input-during-web-page-generation-cross-site-scripting) | Optional | 8 | 1 |
| [CWE-732: Incorrect Permission Assignment for Critical Resource](#incorrect-permission-assignment-for-critical-resource) | Optional | 5 | 1 |
| [CWE-23: Relative Path Traversal](#relative-path-traversal) | Optional | 5 | 1 |

### Security Issue Details

<details id="denial-of-service-in-aspnet-core">
<summary><b>CVE-2018-8269: Denial of service in ASP.NET Core</b> — affected files</summary>

- `WebApp-Storage-DotNet/packages.config:17`

[CVE-2018-8269](https://github.com/advisories/GHSA-mv2r-q4g5-j8q5): Denial of service in ASP.NET Core

Severity: HIGH

Affected dependencies:
  - Microsoft.Data.OData:5.6.4 (declared at WebApp-Storage-DotNet/packages.config:17)

Recommended fix:
  - Upgrade Microsoft.Data.OData to 5.8.4 or later

</details>

<details id="improper-handling-of-exceptional-conditions-in-newtonsoftjson">
<summary><b>CVE-2024-21907: Improper Handling of Exceptional Conditions in Newtonsoft.Json</b> — affected files</summary>

- `WebApp-Storage-DotNet/packages.config:23`

[CVE-2024-21907](https://github.com/advisories/GHSA-5crp-9r3c-p9vr): Improper Handling of Exceptional Conditions in Newtonsoft.Json

Severity: HIGH

Affected dependencies:
  - Newtonsoft.Json:6.0.8 (declared at WebApp-Storage-DotNet/packages.config:23)

Recommended fix:
  - Upgrade Newtonsoft.Json to 13.0.1 or later

</details>

<details id="regular-expression-denial-of-service-in-jquery-validation">
<summary><b>CVE-2021-21252: Regular Expression Denial of Service in jquery-validation</b> — affected files</summary>

- `WebApp-Storage-DotNet/packages.config:9`

[CVE-2021-21252](https://github.com/advisories/GHSA-jxwx-85vp-gvwm): Regular Expression Denial of Service in jquery-validation

Severity: HIGH

Affected dependencies:
  - jQuery.Validation:1.11.1 (declared at WebApp-Storage-DotNet/packages.config:9)

Recommended fix:
  - Upgrade jQuery.Validation to 1.19.3 or later

</details>

<details id="unrestricted-upload-of-file-with-dangerous-type">
<summary><b>CWE-434: Unrestricted Upload of File with Dangerous Type</b> — affected files</summary>

- `WebApp-Storage-DotNet/Controllers/HomeController.cs`

HomeController.UploadAsync accepts request files without checking extensions or content type and uploads them to the public blob container. The code therefore permits arbitrary dangerous file types to be stored and served publicly (lines 101-109).

</details>

<details id="improper-control-of-resource-identifiers-resource-injection">
<summary><b>CWE-99: Improper Control of Resource Identifiers ('Resource Injection')</b> — affected files</summary>

- `WebApp-Storage-DotNet/Controllers/HomeController.cs`

HomeController.DeleteImage receives the user-controlled name, extracts only its basename, and uses that value in blobContainer.GetBlobClient(filename) before deletion (lines 128-136). No ownership or authorization check scopes the target to the caller, so an arbitrary blob identifier in the shared container can be selected.

</details>

<details id="improper-initialization">
<summary><b>CWE-665: Improper Initialization</b> — affected files</summary>

- `WebApp-Storage-DotNet/Controllers/HomeController.cs`

The static blobContainer is only assigned inside HomeController.Index (line 60), while UploadAsync, DeleteImage, and DeleteAll dereference it without ensuring initialization. Directly invoking those actions before Index initializes the resource can result in use of a null container (e.g., lines 108-109 and 135).

</details>

<details id="insufficient-logging">
<summary><b>CWE-778: Insufficient Logging</b> — affected files</summary>

- `WebApp-Storage-DotNet/Controllers/HomeController.cs`

UploadAsync, DeleteImage, and DeleteAll perform file operations without recording security/audit events. Their exception handlers only place exception details in ViewData and return an error view (lines 114-118); no logging mechanism is present.

</details>

<details id="missing-synchronization">
<summary><b>CWE-820: Missing Synchronization</b> — affected files</summary>

- `WebApp-Storage-DotNet/Controllers/HomeController.cs`

The static blobContainer field is shared by concurrent MVC requests; Index assigns it while other actions read and use it, with no synchronization (lines 37, 60, 108, 135).

</details>

<details id="unchecked-input-for-loop-condition">
<summary><b>CWE-606: Unchecked Input for Loop Condition</b> — affected files</summary>

- `WebApp-Storage-DotNet/Controllers/HomeController.cs`

HomeController.UploadAsync loops while i < fileCount, where fileCount comes directly from Request.Files.Count. There is no application-level upper bound on file count, allowing a request with an excessive number of files to drive unbounded per-file processing (lines 101-109).

</details>

<details id="unsynchronized-access-to-shared-data-in-a-multithreaded-context">
<summary><b>CWE-567: Unsynchronized Access to Shared Data in a Multithreaded Context</b> — affected files</summary>

- `WebApp-Storage-DotNet/Controllers/HomeController.cs`

HomeController.blobContainer is a mutable static field assigned during Index and read by UploadAsync, DeleteImage, and DeleteAll without synchronization (lines 37, 60, 108, 135). Concurrent requests can access or replace this shared state without a synchronization mechanism.

</details>

<details id="absolute-path-traversal">
<summary><b>CWE-36: Absolute Path Traversal</b> — affected files</summary>

- `WebApp-Storage-DotNet/Controllers/HomeController.cs`

HomeController.UploadAsync passes the client-supplied files[i].FileName directly to BlobClient.UploadAsync as a local filesystem path. An absolute client-supplied path is not restricted to an upload directory (line 109).

</details>

<details id="improper-limitation-of-a-pathname-to-a-restricted-directory-path-traversal">
<summary><b>CWE-22: Improper Limitation of a Pathname to a Restricted Directory ('Path Traversal')</b> — affected files</summary>

- `WebApp-Storage-DotNet/Controllers/HomeController.cs`

HomeController.UploadAsync passes the request-controlled HttpPostedFileBase.FileName directly to BlobClient.UploadAsync as a local filesystem path. The path is not constrained to an application upload directory, so traversal elements can make the process read a file outside any intended upload directory (line 109).

</details>

<details id="improper-neutralization-of-input-during-web-page-generation-cross-site-scripting">
<summary><b>CWE-79: Improper Neutralization of Input During Web Page Generation ('Cross-site Scripting')</b> — affected files</summary>

- `WebApp-Storage-DotNet/Views/Home/Index.cshtml`

Views/Home/Index.cshtml:80 appends the user-controlled file.name directly to an HTML string, and line 85 assigns that string to innerHTML without encoding. A selected filename containing HTML markup can be interpreted as DOM content.

</details>

<details id="incorrect-permission-assignment-for-critical-resource">
<summary><b>CWE-732: Incorrect Permission Assignment for Critical Resource</b> — affected files</summary>

- `WebApp-Storage-DotNet/Controllers/HomeController.cs`

HomeController.Index creates the blob container using PublicAccessType.Blob (line 60), which allows unauthenticated public reads of every blob in the container. The repository config uses development storage, but the code explicitly enables public blob access.

</details>

<details id="relative-path-traversal">
<summary><b>CWE-23: Relative Path Traversal</b> — affected files</summary>

- `WebApp-Storage-DotNet/Controllers/HomeController.cs`

HomeController.UploadAsync passes the client-supplied files[i].FileName to BlobClient.UploadAsync as a local path without canonicalization or containment checks. A relative path containing parent-directory segments can refer outside an intended upload directory (line 109).

</details>

## .NET Upgrade Assessment

The assessment targeted `net10.0`. The scenario artifacts were generated, but the analysis reports zero projects because the project import for `Microsoft.WebApplication.targets` is missing. Treat the empty upgrade findings as an analysis limitation, not evidence of compatibility.

## Codebase Insights

> Supplementary architecture and project analysis documents:

- [Architecture Diagram](facts/architecture-diagram.md)
- [Dependency Map](facts/dependency-map.md)
- [API & Service Contracts](facts/api-service-contracts.md)
- [Data Architecture](facts/data-architecture.md)
- [Configuration Inventory](facts/configuration-inventory.md)
- [Business Workflows](facts/business-workflows.md)

[Assessment Overview](facts/assessment-overview.md)
