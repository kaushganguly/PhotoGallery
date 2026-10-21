# PhotoGallery Assessment Report

> **Assessment limitation:** AppCAT could not analyze this legacy web project because the Linux runner does not contain `Microsoft/VisualStudio/v18.0/WebApplications/Microsoft.WebApplication.targets`. The report therefore contains the completed security results and supplementary analysis, not core AppCAT findings.

## Summary

| Metric | Value |
|--------|-------|
| Total Issues | 14 |
| Mandatory Blockers | 4 |
| Potential Issues | 5 |
| Optional Issues | 5 |
| CVE Findings (high or critical) | 3 |
| CWE Findings | 11 |

## Component Information

| Property | Value |
|----------|-------|
| Application | PhotoGallery |
| Language | C# |
| Frameworks | .NET Framework 4.8; ASP.NET MVC 5.2.3 |
| Build tools | MSBuild; NuGet (`packages.config`) |

## Security Findings

| Finding | Category | Severity | Story Points |
|---------|----------|----------|--------------|
| [Improper Handling of Exceptional Conditions in Newtonsoft.Json](#Improper_Handling_of_Exceptional_Conditions_in_Newtonsoft_Json) | CVE | mandatory | 1 |
| [Regular Expression Denial of Service in jquery-validation](#Regular_Expression_Denial_of_Service_in_jquery-validation) | CVE | mandatory | 1 |
| [Denial of service in ASP.NET Core](#Denial_of_service_in_ASP_NET_Core) | CVE | mandatory | 1 |
| [Missing Initialization of a Variable](#Missing_Initialization_of_a_Variable) | Code Quality | potential | 2 |
| [Use of Uninitialized Variable](#Use_of_Uninitialized_Variable) | Code Quality | potential | 2 |
| [Unchecked Input for Loop Condition](#Unchecked_Input_for_Loop_Condition) | Code Quality | potential | 3 |
| [Improper Initialization](#Improper_Initialization) | Code Quality | potential | 3 |
| [Incorrect Permission Assignment for Critical Resource](#Incorrect_Permission_Assignment_for_Critical_Resource) | Credentials & Secrets | optional | 5 |
| [Insufficient Logging](#Insufficient_Logging) | Credentials & Secrets | potential | 3 |
| [Improper Limitation of a Pathname to a Restricted Directory ('Path Traversal')](#Improper_Limitation_of_a_Pathname_to_a_Restricted_Directory_Path_Traversal) | File & Path Security | optional | 8 |
| [Relative Path Traversal](#Relative_Path_Traversal) | File & Path Security | optional | 5 |
| [Absolute Path Traversal](#Absolute_Path_Traversal) | File & Path Security | optional | 5 |
| [Unrestricted Upload of File with Dangerous Type](#Unrestricted_Upload_of_File_with_Dangerous_Type) | File & Path Security | mandatory | 8 |
| [Improper Neutralization of Input During Web Page Generation ('Cross-site Scripting')](#Improper_Neutralization_of_Input_During_Web_Page_Generation_Cross-site_Scripting) | Injection Attacks | optional | 8 |

<details id="Improper_Handling_of_Exceptional_Conditions_in_Newtonsoft_Json">
<summary><b>Improper Handling of Exceptional Conditions in Newtonsoft.Json</b> — CVE-2024-21907</summary>

- **Category:** CVE
- **Severity:** mandatory
- **Story Points:** 1
- **Files:** `WebApp-Storage-DotNet/packages.config:23`

[CVE-2024-21907](https://github.com/advisories/GHSA-5crp-9r3c-p9vr)

Severity: HIGH

Affected dependencies:
  - Newtonsoft.Json 6.0.8 (declared at WebApp-Storage-DotNet/packages.config:23); affected range: < 13.0.1; first patched: 13.0.1

Recommended fix: Upgrade the affected package to a version outside the vulnerable range, preferably the first patched version listed above.

</details>

<details id="Regular_Expression_Denial_of_Service_in_jquery-validation">
<summary><b>Regular Expression Denial of Service in jquery-validation</b> — CVE-2021-21252</summary>

- **Category:** CVE
- **Severity:** mandatory
- **Story Points:** 1
- **Files:** `WebApp-Storage-DotNet/packages.config:9`

[CVE-2021-21252](https://github.com/advisories/GHSA-jxwx-85vp-gvwm)

Severity: HIGH

Affected dependencies:
  - jQuery.Validation 1.11.1 (declared at WebApp-Storage-DotNet/packages.config:9); affected range: < 1.19.3; first patched: 1.19.3

Recommended fix: Upgrade the affected package to a version outside the vulnerable range, preferably the first patched version listed above.

</details>

<details id="Denial_of_service_in_ASP_NET_Core">
<summary><b>Denial of service in ASP.NET Core</b> — CVE-2018-8269</summary>

- **Category:** CVE
- **Severity:** mandatory
- **Story Points:** 1
- **Files:** `WebApp-Storage-DotNet/packages.config:17`

[CVE-2018-8269](https://github.com/advisories/GHSA-mv2r-q4g5-j8q5)

Severity: HIGH

Affected dependencies:
  - Microsoft.Data.OData 5.6.4 (declared at WebApp-Storage-DotNet/packages.config:17); affected range: < 5.8.4; first patched: 5.8.4

Recommended fix: Upgrade the affected package to a version outside the vulnerable range, preferably the first patched version listed above.

</details>

<details id="Missing_Initialization_of_a_Variable">
<summary><b>Missing Initialization of a Variable</b> — CWE-456</summary>

- **Category:** Code Quality
- **Severity:** potential
- **Story Points:** 2
- **Files:** `WebApp-Storage-DotNet/Controllers/HomeController.cs`

The product does not initialize critical variables, which causes the execution environment to use unexpected values.

**Evidence**

The static BlobContainerClient field is declared without initialization in HomeController (line 47); it is assigned only in Index (lines 63-66). UploadAsync, DeleteImage, and DeleteAll use it without guaranteeing that initialization ran first. Evidence lines: 47, 63, 108, 135, 158.

</details>

<details id="Use_of_Uninitialized_Variable">
<summary><b>Use of Uninitialized Variable</b> — CWE-457</summary>

- **Category:** Code Quality
- **Severity:** potential
- **Story Points:** 2
- **Files:** `WebApp-Storage-DotNet/Controllers/HomeController.cs`

The code uses a variable that has not been initialized, leading to unpredictable or unintended results.

**Evidence**

HomeController.UploadAsync, DeleteImage, and DeleteAll can dereference the static blobContainer before HomeController.Index has assigned it, resulting in a null-reference failure for a direct POST request (field declaration line 47; use sites lines 108, 135, and 158). Evidence lines: 47, 108, 135, 158.

</details>

<details id="Unchecked_Input_for_Loop_Condition">
<summary><b>Unchecked Input for Loop Condition</b> — CWE-606</summary>

- **Category:** Code Quality
- **Severity:** potential
- **Story Points:** 3
- **Files:** `WebApp-Storage-DotNet/Controllers/HomeController.cs`

The product does not properly check inputs that are used for loop conditions, potentially leading to a denial of service or other consequences because of excessive looping.

**Evidence**

HomeController.UploadAsync sets fileCount directly from the client-controlled Request.Files.Count and loops until that count (lines 101-107), without an application-level upper bound on the number of files processed. Evidence lines: 101, 104, 106.

</details>

<details id="Improper_Initialization">
<summary><b>Improper Initialization</b> — CWE-665</summary>

- **Category:** Code Quality
- **Severity:** potential
- **Story Points:** 3
- **Files:** `WebApp-Storage-DotNet/Controllers/HomeController.cs`

The product does not initialize or incorrectly initializes a resource, which might leave the resource in an unexpected state when it is accessed or used.

**Evidence**

The BlobContainerClient resource is initialized lazily only as a side effect of Index (lines 63-66). Other controller actions access it without ensuring initialization, leaving the resource in an unexpected null state when those actions are called first. Evidence lines: 47, 63, 66, 108, 135, 158.

</details>

<details id="Incorrect_Permission_Assignment_for_Critical_Resource">
<summary><b>Incorrect Permission Assignment for Critical Resource</b> — CWE-732</summary>

- **Category:** Credentials & Secrets
- **Severity:** optional
- **Story Points:** 5
- **Files:** `WebApp-Storage-DotNet/Controllers/HomeController.cs`

The product specifies permissions for a security-critical resource in a way that allows that resource to be read or modified by unintended actors.

**Evidence**

HomeController.Index creates the blob container with PublicAccessType.Blob (line 66), allowing anonymous users to read blobs. The permission is granted without an access-control check, making uploaded gallery content publicly readable.

</details>

<details id="Insufficient_Logging">
<summary><b>Insufficient Logging</b> — CWE-778</summary>

- **Category:** Credentials & Secrets
- **Severity:** potential
- **Story Points:** 3
- **Files:** `WebApp-Storage-DotNet/Controllers/HomeController.cs`

When a security-critical event occurs, the product either does not record the event or omits important details about the event when logging it.

**Evidence**

HomeController.UploadAsync, DeleteImage, and DeleteAll perform image changes without recording successful operations or failures in an application log. Their exception handlers return details to the Error view instead of creating an audit/log record (for example, lines 114-118).

</details>

<details id="Improper_Limitation_of_a_Pathname_to_a_Restricted_Directory_Path_Traversal">
<summary><b>Improper Limitation of a Pathname to a Restricted Directory (&#x27;Path Traversal&#x27;)</b> — CWE-22</summary>

- **Category:** File & Path Security
- **Severity:** optional
- **Story Points:** 8
- **Files:** `WebApp-Storage-DotNet/Controllers/HomeController.cs`

The product uses external input to construct a pathname that is intended to identify a file or directory that is located underneath a restricted parent directory, but the product does not properly neutralize special elements within the pathname that can cause the pathname to resolve to a location that is outside of the restricted directory.

**Evidence**

In HomeController.UploadAsync (lines 101-109), the client-supplied Request.Files[i].FileName is passed to BlobClient.UploadAsync(string path) without constraining or canonicalizing the local source path. A crafted filename containing traversal elements can cause the SDK to resolve a source path outside an intended upload directory, potentially reading a local file into the blob container.

</details>

<details id="Relative_Path_Traversal">
<summary><b>Relative Path Traversal</b> — CWE-23</summary>

- **Category:** File & Path Security
- **Severity:** optional
- **Story Points:** 5
- **Files:** `WebApp-Storage-DotNet/Controllers/HomeController.cs`

The product uses external input to construct a pathname that should be within a restricted directory, but it does not properly neutralize sequences such as .. that can resolve to a location that is outside of that directory.

**Evidence**

HomeController.UploadAsync (lines 101-109) passes the client-controlled uploaded filename directly to the file-path overload of BlobClient.UploadAsync. Relative traversal segments in the supplied filename are not removed or checked against an allowed root before the SDK opens the path.

</details>

<details id="Absolute_Path_Traversal">
<summary><b>Absolute Path Traversal</b> — CWE-36</summary>

- **Category:** File & Path Security
- **Severity:** optional
- **Story Points:** 5
- **Files:** `WebApp-Storage-DotNet/Controllers/HomeController.cs`

The product uses external input to construct a pathname that should be within a restricted directory, but it does not properly neutralize absolute path sequences such as /abs/path that can resolve to a location that is outside of that directory.

**Evidence**

HomeController.UploadAsync (lines 101-109) passes Request.Files[i].FileName directly to BlobClient.UploadAsync(string path). No check rejects rooted paths or limits the source to a server-controlled upload directory before opening the file.

</details>

<details id="Unrestricted_Upload_of_File_with_Dangerous_Type">
<summary><b>Unrestricted Upload of File with Dangerous Type</b> — CWE-434</summary>

- **Category:** File & Path Security
- **Severity:** mandatory
- **Story Points:** 8
- **Files:** `WebApp-Storage-DotNet/Controllers/HomeController.cs`

The product allows the upload or transfer of dangerous file types that are automatically processed within its environment.

**Evidence**

HomeController.UploadAsync (lines 101-110) accepts every posted file and sends it to Blob Storage without checking its type or content. The application makes the container blobs publicly readable (line 66) and renders blob URIs in the gallery, so uploaded active or malformed content can be served to visitors without application-side type restrictions.

</details>

<details id="Improper_Neutralization_of_Input_During_Web_Page_Generation_Cross-site_Scripting">
<summary><b>Improper Neutralization of Input During Web Page Generation (&#x27;Cross-site Scripting&#x27;)</b> — CWE-79</summary>

- **Category:** Injection Attacks
- **Severity:** optional
- **Story Points:** 8
- **Files:** `WebApp-Storage-DotNet/Views/Home/Index.cshtml`

The product does not neutralize or incorrectly neutralizes user-controllable input before it is placed in output that is used as a web page that is served to other users.

**Evidence**

The Index Razor view embeds the blob URI in a JavaScript string inside an inline onclick handler (line 53: deleteImage('@item')). The URI is derived from uploaded blob names, while HTML encoding is not JavaScript-string encoding; a URI containing quote/script syntax can break out of the string in the generated event handler.

</details>

## .NET Upgrade Assessment

The .NET 10 upgrade assessment was invoked for the solution and generated the scenario artifacts. The assessment reported zero analyzed packages and source files because the same legacy web-application MSBuild target was missing; its detailed output is available at [the scenario assessment](scenarios/dotnet-version-upgrade/assessment.md).

## Codebase Insights

- [Architecture Diagram](facts/architecture-diagram.md) — Application layers and component relationships.
- [Dependency Map](facts/dependency-map.md) — Declared package dependencies and compatibility notes.
- [API & Service Communication Contracts](facts/api-service-contracts.md) — MVC routes and storage communication.
- [Data Architecture & Persistence Layer](facts/data-architecture.md) — Blob storage ownership and data boundaries.
- [Configuration & Externalized Settings Inventory](facts/configuration-inventory.md) — Configuration sources and framework versions.
- [Core Business Workflows](facts/business-workflows.md) — Gallery image browsing and lifecycle workflows.
