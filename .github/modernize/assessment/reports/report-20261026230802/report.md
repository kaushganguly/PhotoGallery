# report-20261026230802

## Summary

| Metric | Value |
|--------|-------|
| Total Issues | 25 |
| Mandatory Blockers | 4 |
| Potential Issues | 6 |

> Core AppCAT analysis could not load the legacy ASP.NET web project because the Visual Studio WebApplication MSBuild targets are unavailable on this Linux runner. The .NET 10 upgrade assessment produced no project or issue records for the same reason. The issue counts below reflect the completed security assessment only.

## Application Information

| Property | Value |
|----------|-------|
| Language | C# |
| Frameworks | ASP.NET MVC 5; .NET Framework 4.8 |
| Build tools | MSBuild legacy web project; NuGet packages.config |

## Security Issues

> AI-generated security findings should be reviewed before remediation.

| Issue Name | Criticality | Story Points | Files |
|------------|-------------|--------------|-------|
| CWE-434: Unrestricted Upload of File with Dangerous Type | Mandatory | 8 | [1](#Unrestricted_Upload_of_File_with_Dangerous_Type) |
| CVE-2024-21907: Improper Handling of Exceptional Conditions in Newtonsoft.Json | Mandatory | 1 | [1](#Improper_Handling_of_Exceptional_Conditions_in_Newtonsoft_Json) |
| CVE-2021-21252: Regular Expression Denial of Service in jquery-validation | Mandatory | 1 | [1](#Regular_Expression_Denial_of_Service_in_jquery-validation) |
| CVE-2018-8269: Denial of service in ASP.NET Core | Mandatory | 1 | [1](#Denial_of_service_in_ASP_NET_Core) |
| CWE-567: Unsynchronized Access to Shared Data in a Multithreaded Context | Potential | 5 | [1](#Unsynchronized_Access_to_Shared_Data_in_a_Multithreaded_Context) |
| CWE-606: Unchecked Input for Loop Condition | Potential | 3 | [1](#Unchecked_Input_for_Loop_Condition) |
| CWE-665: Improper Initialization | Potential | 3 | [1](#Improper_Initialization) |
| CWE-778: Insufficient Logging | Potential | 3 | [1](#Insufficient_Logging) |
| CWE-456: Missing Initialization of a Variable | Potential | 2 | [1](#Missing_Initialization_of_a_Variable) |
| CWE-457: Use of Uninitialized Variable | Potential | 2 | [1](#Use_of_Uninitialized_Variable) |
| CWE-22: Improper Limitation of a Pathname to a Restricted Directory ('Path Traversal') | Optional | 8 | [1](#Improper_Limitation_of_a_Pathname_to_a_Restricted_Directory_Path_Traversal) |
| CWE-79: Improper Neutralization of Input During Web Page Generation ('Cross-site Scripting') | Optional | 8 | [1](#Improper_Neutralization_of_Input_During_Web_Page_Generation_Cross-site_Scripting) |
| CWE-732: Incorrect Permission Assignment for Critical Resource | Optional | 5 | [1](#Incorrect_Permission_Assignment_for_Critical_Resource) |
| CWE-23: Relative Path Traversal | Optional | 5 | [1](#Relative_Path_Traversal) |
| CWE-36: Absolute Path Traversal | Optional | 5 | [1](#Absolute_Path_Traversal) |
| CVE-2022-30187: Microsoft: CBC Padding Oracle in Azure Blob Storage Encryption Library | Optional | 1 | [1](#Microsoft_CBC_Padding_Oracle_in_Azure_Blob_Storage_Encryption_Library) |
| CVE-2018-14040: Bootstrap vulnerable to Cross-Site Scripting (XSS) | Optional | 1 | [1](#Bootstrap_vulnerable_to_Cross-Site_Scripting_XSS) |
| CVE-2020-11023: Potential XSS vulnerability in jQuery | Optional | 1 | [1](#Potential_XSS_vulnerability_in_jQuery) |
| CVE-2019-11358: XSS in jQuery as used in Drupal, Backdrop CMS, and other products | Optional | 1 | [1](#XSS_in_jQuery_as_used_in_Drupal_Backdrop_CMS_and_other_products) |
| CVE-2019-8331: Bootstrap Vulnerable to Cross-Site Scripting | Optional | 1 | [1](#Bootstrap_Vulnerable_to_Cross-Site_Scripting) |
| CVE-2018-20677: bootstrap Cross-site Scripting vulnerability | Optional | 1 | [1](#bootstrap_Cross-site_Scripting_vulnerability) |
| CVE-2018-20676: XSS vulnerability that affects bootstrap | Optional | 1 | [1](#XSS_vulnerability_that_affects_bootstrap) |
| CVE-2016-10735: Bootstrap Cross-site Scripting vulnerability | Optional | 1 | [1](#Bootstrap_Cross-site_Scripting_vulnerability) |
| CVE-2018-14042: Bootstrap Cross-site Scripting vulnerability | Optional | 1 | [1](#Bootstrap_Cross-site_Scripting_vulnerability) |
| CVE-2015-9251: Cross-Site Scripting (XSS) in jquery | Optional | 1 | [1](#Cross-Site_Scripting_XSS_in_jquery) |

### Security Issue Details

<details id="Unrestricted_Upload_of_File_with_Dangerous_Type">
<summary><b>CWE-434: Unrestricted Upload of File with Dangerous Type</b> — affected files</summary>

- `WebApp-Storage-DotNet/Controllers/HomeController.cs`

**Severity:** mandatory  
**Description:** The product allows the upload or transfer of dangerous file types that are automatically processed within its environment.  
**Evidence:** HomeController.UploadAsync passes the client-controlled HttpPostedFileBase.FileName to BlobClient.UploadAsync(string path) at line 109. The path-based overload reads that path from the server filesystem; a crafted relative or absolute filename can therefore cause a server file to be uploaded to the public blob container. The upload also accepts arbitrary file types without validating content or extension (lines 101-109).

</details>

<details id="Improper_Handling_of_Exceptional_Conditions_in_Newtonsoft_Json">
<summary><b>CVE-2024-21907: Improper Handling of Exceptional Conditions in Newtonsoft.Json</b> — affected files</summary>

- `WebApp-Storage-DotNet/packages.config:23`

**Severity:** mandatory  
**Description:** [CVE-2024-21907](https://github.com/advisories/GHSA-5crp-9r3c-p9vr): Improper Handling of Exceptional Conditions in Newtonsoft.Json

Severity: HIGH

Affected dependencies:
  - Newtonsoft.Json:6.0.8 (declared at WebApp-Storage-DotNet/packages.config:23; affected range < 13.0.1)

Recommended fix: upgrade to a patched version listed above when available.  
**Evidence:** [CVE-2024-21907](https://github.com/advisories/GHSA-5crp-9r3c-p9vr): Improper Handling of Exceptional Conditions in Newtonsoft.Json

Severity: HIGH

Affected dependencies:
  - Newtonsoft.Json:6.0.8 (declared at WebApp-Storage-DotNet/packages.config:23; affected range < 13.0.1)

Recommended fix: upgrade to a patched version listed above when available.

</details>

<details id="Regular_Expression_Denial_of_Service_in_jquery-validation">
<summary><b>CVE-2021-21252: Regular Expression Denial of Service in jquery-validation</b> — affected files</summary>

- `WebApp-Storage-DotNet/packages.config:9`

**Severity:** mandatory  
**Description:** [CVE-2021-21252](https://github.com/advisories/GHSA-jxwx-85vp-gvwm): Regular Expression Denial of Service in jquery-validation

Severity: HIGH

Affected dependencies:
  - jQuery.Validation:1.11.1 (declared at WebApp-Storage-DotNet/packages.config:9; affected range < 1.19.3)

Recommended fix: upgrade to a patched version listed above when available.  
**Evidence:** [CVE-2021-21252](https://github.com/advisories/GHSA-jxwx-85vp-gvwm): Regular Expression Denial of Service in jquery-validation

Severity: HIGH

Affected dependencies:
  - jQuery.Validation:1.11.1 (declared at WebApp-Storage-DotNet/packages.config:9; affected range < 1.19.3)

Recommended fix: upgrade to a patched version listed above when available.

</details>

<details id="Denial_of_service_in_ASP_NET_Core">
<summary><b>CVE-2018-8269: Denial of service in ASP.NET Core</b> — affected files</summary>

- `WebApp-Storage-DotNet/packages.config:17`

**Severity:** mandatory  
**Description:** [CVE-2018-8269](https://github.com/advisories/GHSA-mv2r-q4g5-j8q5): Denial of service in ASP.NET Core

Severity: HIGH

Affected dependencies:
  - Microsoft.Data.OData:5.6.4 (declared at WebApp-Storage-DotNet/packages.config:17; affected range < 5.8.4)

Recommended fix: upgrade to a patched version listed above when available.  
**Evidence:** [CVE-2018-8269](https://github.com/advisories/GHSA-mv2r-q4g5-j8q5): Denial of service in ASP.NET Core

Severity: HIGH

Affected dependencies:
  - Microsoft.Data.OData:5.6.4 (declared at WebApp-Storage-DotNet/packages.config:17; affected range < 5.8.4)

Recommended fix: upgrade to a patched version listed above when available.

</details>

<details id="Unsynchronized_Access_to_Shared_Data_in_a_Multithreaded_Context">
<summary><b>CWE-567: Unsynchronized Access to Shared Data in a Multithreaded Context</b> — affected files</summary>

- `WebApp-Storage-DotNet/Controllers/HomeController.cs`

**Severity:** potential  
**Description:** The product does not properly synchronize shared data, such as static variables across threads, which can lead to undefined behavior and unpredictable data changes.  
**Evidence:** HomeController stores BlobContainerClient in a static field at line 47, assigns it in Index at line 65, and reads it in concurrent request actions (lines 75, 108, 135, 158) without synchronization. Concurrent MVC requests can access the shared field while it is being initialized or reassigned.

</details>

<details id="Unchecked_Input_for_Loop_Condition">
<summary><b>CWE-606: Unchecked Input for Loop Condition</b> — affected files</summary>

- `WebApp-Storage-DotNet/Controllers/HomeController.cs`

**Severity:** potential  
**Description:** The product does not properly check inputs that are used for loop conditions, potentially leading to a denial of service or other consequences because of excessive looping.  
**Evidence:** HomeController.UploadAsync copies Request.Files.Count into fileCount at line 102 and uses that unvalidated request-controlled value as the loop bound at line 106. There is no per-request file-count limit in application code, so a request containing many files can trigger an excessive number of upload iterations.

</details>

<details id="Improper_Initialization">
<summary><b>CWE-665: Improper Initialization</b> — affected files</summary>

- `WebApp-Storage-DotNet/Controllers/HomeController.cs`

**Severity:** potential  
**Description:** The product does not initialize or incorrectly initializes a resource, which might leave the resource in an unexpected state when it is accessed or used.  
**Evidence:** HomeController does not initialize the static blobContainer field at declaration (line 47); its initialization occurs only in Index (line 65), while upload and delete actions assume it is ready. A request invoking one of those actions first encounters an uninitialized storage client.

</details>

<details id="Insufficient_Logging">
<summary><b>CWE-778: Insufficient Logging</b> — affected files</summary>

- `WebApp-Storage-DotNet/Controllers/HomeController.cs`

**Severity:** potential  
**Description:** When a security-critical event occurs, the product either does not record the event or omits important details about the event when logging it.  
**Evidence:** The upload, individual delete, and bulk-delete actions perform security-relevant operations but do not record audit events. Their catch blocks only place exception messages and stack traces in ViewData (for example lines 114-118 and 140-144); there is no logging of actors, target blobs, or outcomes.

</details>

<details id="Missing_Initialization_of_a_Variable">
<summary><b>CWE-456: Missing Initialization of a Variable</b> — affected files</summary>

- `WebApp-Storage-DotNet/Controllers/HomeController.cs`

**Severity:** potential  
**Description:** The product does not initialize critical variables, which causes the execution environment to use unexpected values.  
**Evidence:** HomeController declares the static BlobContainerClient field without initialization at line 47. It is only assigned in Index at line 65, while UploadAsync, DeleteImage, and DeleteAll use it without checking or ensuring initialization (lines 108, 135, and 158), so direct requests can operate on a null resource.

</details>

<details id="Use_of_Uninitialized_Variable">
<summary><b>CWE-457: Use of Uninitialized Variable</b> — affected files</summary>

- `WebApp-Storage-DotNet/Controllers/HomeController.cs`

**Severity:** potential  
**Description:** The code uses a variable that has not been initialized, leading to unpredictable or unintended results.  
**Evidence:** HomeController.UploadAsync uses the static blobContainer field at line 108, but it is initialized only as a side effect of calling Index at line 65. A direct upload request before Index executes dereferences the uninitialized (null) field.

</details>

<details id="Improper_Limitation_of_a_Pathname_to_a_Restricted_Directory_Path_Traversal">
<summary><b>CWE-22: Improper Limitation of a Pathname to a Restricted Directory ('Path Traversal')</b> — affected files</summary>

- `WebApp-Storage-DotNet/Controllers/HomeController.cs`

**Severity:** optional  
**Description:** The product uses external input to construct a pathname that is intended to identify a file or directory that is located underneath a restricted parent directory, but the product does not properly neutralize special elements within the pathname that can cause the pathname to resolve to a location that is outside of the restricted directory.  
**Evidence:** HomeController.UploadAsync passes the client-controlled HttpPostedFileBase.FileName to BlobClient.UploadAsync(string path) at line 109. The path-based overload reads that path from the server filesystem; a crafted relative or absolute filename can therefore cause a server file to be uploaded to the public blob container. The upload also accepts arbitrary file types without validating content or extension (lines 101-109).

</details>

<details id="Improper_Neutralization_of_Input_During_Web_Page_Generation_Cross-site_Scripting">
<summary><b>CWE-79: Improper Neutralization of Input During Web Page Generation ('Cross-site Scripting')</b> — affected files</summary>

- `WebApp-Storage-DotNet/Views/Home/Index.cshtml`

**Severity:** optional  
**Description:** The product does not neutralize or incorrectly neutralizes user-controllable input before it is placed in output that is used as a web page that is served to other users.  
**Evidence:** In DisplayFilesToUpload, line 80 concatenates the selected file name (file.name) directly into an HTML string, and line 85 assigns that string to innerHTML. A specially named local file can therefore inject markup or script into the gallery page.

</details>

<details id="Incorrect_Permission_Assignment_for_Critical_Resource">
<summary><b>CWE-732: Incorrect Permission Assignment for Critical Resource</b> — affected files</summary>

- `WebApp-Storage-DotNet/Controllers/HomeController.cs`

**Severity:** optional  
**Description:** The product specifies permissions for a security-critical resource in a way that allows that resource to be read or modified by unintended actors.  
**Evidence:** HomeController.Index calls CreateIfNotExistsAsync(PublicAccessType.Blob) at line 66, configuring uploaded blobs for anonymous public read access. This exposes gallery content to anyone with a blob URL, without a configurable privacy or access-control check.

</details>

<details id="Relative_Path_Traversal">
<summary><b>CWE-23: Relative Path Traversal</b> — affected files</summary>

- `WebApp-Storage-DotNet/Controllers/HomeController.cs`

**Severity:** optional  
**Description:** The product uses external input to construct a pathname that should be within a restricted directory, but it does not properly neutralize sequences such as .. that can resolve to a location that is outside of that directory.  
**Evidence:** HomeController.UploadAsync passes the client-controlled HttpPostedFileBase.FileName to BlobClient.UploadAsync(string path) at line 109. The path-based overload reads that path from the server filesystem; a crafted relative or absolute filename can therefore cause a server file to be uploaded to the public blob container. The upload also accepts arbitrary file types without validating content or extension (lines 101-109).

</details>

<details id="Absolute_Path_Traversal">
<summary><b>CWE-36: Absolute Path Traversal</b> — affected files</summary>

- `WebApp-Storage-DotNet/Controllers/HomeController.cs`

**Severity:** optional  
**Description:** The product uses external input to construct a pathname that should be within a restricted directory, but it does not properly neutralize absolute path sequences such as /abs/path that can resolve to a location that is outside of that directory.  
**Evidence:** HomeController.UploadAsync passes the client-controlled HttpPostedFileBase.FileName to BlobClient.UploadAsync(string path) at line 109. The path-based overload reads that path from the server filesystem; a crafted relative or absolute filename can therefore cause a server file to be uploaded to the public blob container. The upload also accepts arbitrary file types without validating content or extension (lines 101-109).

</details>

<details id="Microsoft_CBC_Padding_Oracle_in_Azure_Blob_Storage_Encryption_Library">
<summary><b>CVE-2022-30187: Microsoft: CBC Padding Oracle in Azure Blob Storage Encryption Library</b> — affected files</summary>

- `WebApp-Storage-DotNet/packages.config:5`

**Severity:** optional  
**Description:** [CVE-2022-30187](https://github.com/advisories/GHSA-64x4-9hc6-r2h6): Microsoft: CBC Padding Oracle in Azure Blob Storage Encryption Library

Severity: MEDIUM

Affected dependencies:
  - Azure.Storage.Blobs:12.9.1 (declared at WebApp-Storage-DotNet/packages.config:5; affected range < 12.13.0)

Recommended fix: upgrade to a patched version listed above when available.  
**Evidence:** [CVE-2022-30187](https://github.com/advisories/GHSA-64x4-9hc6-r2h6): Microsoft: CBC Padding Oracle in Azure Blob Storage Encryption Library

Severity: MEDIUM

Affected dependencies:
  - Azure.Storage.Blobs:12.9.1 (declared at WebApp-Storage-DotNet/packages.config:5; affected range < 12.13.0)

Recommended fix: upgrade to a patched version listed above when available.

</details>

<details id="Bootstrap_vulnerable_to_Cross-Site_Scripting_XSS">
<summary><b>CVE-2018-14040: Bootstrap vulnerable to Cross-Site Scripting (XSS)</b> — affected files</summary>

- `WebApp-Storage-DotNet/packages.config:7`

**Severity:** optional  
**Description:** [CVE-2018-14040](https://github.com/advisories/GHSA-3wqf-4x89-9g79): Bootstrap vulnerable to Cross-Site Scripting (XSS)

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; affected range >= 2.3.0, < 3.4.0)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; affected range >= 4.0.0, < 4.1.2)

Recommended fix: upgrade to a patched version listed above when available.  
**Evidence:** [CVE-2018-14040](https://github.com/advisories/GHSA-3wqf-4x89-9g79): Bootstrap vulnerable to Cross-Site Scripting (XSS)

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; affected range >= 2.3.0, < 3.4.0)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; affected range >= 4.0.0, < 4.1.2)

Recommended fix: upgrade to a patched version listed above when available.

</details>

<details id="Potential_XSS_vulnerability_in_jQuery">
<summary><b>CVE-2020-11023: Potential XSS vulnerability in jQuery</b> — affected files</summary>

- `WebApp-Storage-DotNet/packages.config:8`

**Severity:** optional  
**Description:** [CVE-2020-11023](https://github.com/advisories/GHSA-jpcq-cgw6-v4j6): Potential XSS vulnerability in jQuery

Severity: MEDIUM

Affected dependencies:
  - jQuery:1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8; affected range >= 1.0.3, < 3.5.0)

Recommended fix: upgrade to a patched version listed above when available.  
**Evidence:** [CVE-2020-11023](https://github.com/advisories/GHSA-jpcq-cgw6-v4j6): Potential XSS vulnerability in jQuery

Severity: MEDIUM

Affected dependencies:
  - jQuery:1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8; affected range >= 1.0.3, < 3.5.0)

Recommended fix: upgrade to a patched version listed above when available.

</details>

<details id="XSS_in_jQuery_as_used_in_Drupal_Backdrop_CMS_and_other_products">
<summary><b>CVE-2019-11358: XSS in jQuery as used in Drupal, Backdrop CMS, and other products</b> — affected files</summary>

- `WebApp-Storage-DotNet/packages.config:8`

**Severity:** optional  
**Description:** [CVE-2019-11358](https://github.com/advisories/GHSA-6c3j-c64m-qhgq): XSS in jQuery as used in Drupal, Backdrop CMS, and other products

Severity: MEDIUM

Affected dependencies:
  - jQuery:1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8; affected range >= 1.1.4, < 3.4.0)

Recommended fix: upgrade to a patched version listed above when available.  
**Evidence:** [CVE-2019-11358](https://github.com/advisories/GHSA-6c3j-c64m-qhgq): XSS in jQuery as used in Drupal, Backdrop CMS, and other products

Severity: MEDIUM

Affected dependencies:
  - jQuery:1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8; affected range >= 1.1.4, < 3.4.0)

Recommended fix: upgrade to a patched version listed above when available.

</details>

<details id="Bootstrap_Vulnerable_to_Cross-Site_Scripting">
<summary><b>CVE-2019-8331: Bootstrap Vulnerable to Cross-Site Scripting</b> — affected files</summary>

- `WebApp-Storage-DotNet/packages.config:7`

**Severity:** optional  
**Description:** [CVE-2019-8331](https://github.com/advisories/GHSA-9v3m-8fp8-mj99): Bootstrap Vulnerable to Cross-Site Scripting

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; affected range >= 4.0.0, < 4.3.1)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; affected range >= 3.0.0, < 3.4.1)

Recommended fix: upgrade to a patched version listed above when available.  
**Evidence:** [CVE-2019-8331](https://github.com/advisories/GHSA-9v3m-8fp8-mj99): Bootstrap Vulnerable to Cross-Site Scripting

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; affected range >= 4.0.0, < 4.3.1)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; affected range >= 3.0.0, < 3.4.1)

Recommended fix: upgrade to a patched version listed above when available.

</details>

<details id="bootstrap_Cross-site_Scripting_vulnerability">
<summary><b>CVE-2018-20677: bootstrap Cross-site Scripting vulnerability</b> — affected files</summary>

- `WebApp-Storage-DotNet/packages.config:7`

**Severity:** optional  
**Description:** [CVE-2018-20677](https://github.com/advisories/GHSA-ph58-4vrj-w6hr): bootstrap Cross-site Scripting vulnerability

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; affected range < 3.4.0)

Recommended fix: upgrade to a patched version listed above when available.  
**Evidence:** [CVE-2018-20677](https://github.com/advisories/GHSA-ph58-4vrj-w6hr): bootstrap Cross-site Scripting vulnerability

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; affected range < 3.4.0)

Recommended fix: upgrade to a patched version listed above when available.

</details>

<details id="XSS_vulnerability_that_affects_bootstrap">
<summary><b>CVE-2018-20676: XSS vulnerability that affects bootstrap</b> — affected files</summary>

- `WebApp-Storage-DotNet/packages.config:7`

**Severity:** optional  
**Description:** [CVE-2018-20676](https://github.com/advisories/GHSA-3mgp-fx93-9xv5): XSS vulnerability that affects bootstrap

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; affected range < 3.4.0)

Recommended fix: upgrade to a patched version listed above when available.  
**Evidence:** [CVE-2018-20676](https://github.com/advisories/GHSA-3mgp-fx93-9xv5): XSS vulnerability that affects bootstrap

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; affected range < 3.4.0)

Recommended fix: upgrade to a patched version listed above when available.

</details>

<details id="Bootstrap_Cross-site_Scripting_vulnerability">
<summary><b>CVE-2016-10735: Bootstrap Cross-site Scripting vulnerability</b> — affected files</summary>

- `WebApp-Storage-DotNet/packages.config:7`

**Severity:** optional  
**Description:** [CVE-2016-10735](https://github.com/advisories/GHSA-4p24-vmcr-4gqj): Bootstrap Cross-site Scripting vulnerability

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; affected range >= 2.0.4, < 3.4.0)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; affected range >= 4.0.0-beta, < 4.0.0-beta.2)

Recommended fix: upgrade to a patched version listed above when available.  
**Evidence:** [CVE-2016-10735](https://github.com/advisories/GHSA-4p24-vmcr-4gqj): Bootstrap Cross-site Scripting vulnerability

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; affected range >= 2.0.4, < 3.4.0)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; affected range >= 4.0.0-beta, < 4.0.0-beta.2)

Recommended fix: upgrade to a patched version listed above when available.

</details>

<details id="Bootstrap_Cross-site_Scripting_vulnerability">
<summary><b>CVE-2018-14042: Bootstrap Cross-site Scripting vulnerability</b> — affected files</summary>

- `WebApp-Storage-DotNet/packages.config:7`

**Severity:** optional  
**Description:** [CVE-2018-14042](https://github.com/advisories/GHSA-7mvr-5x2g-wfc8): Bootstrap Cross-site Scripting vulnerability

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; affected range >= 4.0.0, < 4.1.2)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; affected range >= 2.3.0, < 3.4.0)

Recommended fix: upgrade to a patched version listed above when available.  
**Evidence:** [CVE-2018-14042](https://github.com/advisories/GHSA-7mvr-5x2g-wfc8): Bootstrap Cross-site Scripting vulnerability

Severity: MEDIUM

Affected dependencies:
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; affected range >= 4.0.0, < 4.1.2)
  - bootstrap:3.0.0 (declared at WebApp-Storage-DotNet/packages.config:7; affected range >= 2.3.0, < 3.4.0)

Recommended fix: upgrade to a patched version listed above when available.

</details>

<details id="Cross-Site_Scripting_XSS_in_jquery">
<summary><b>CVE-2015-9251: Cross-Site Scripting (XSS) in jquery</b> — affected files</summary>

- `WebApp-Storage-DotNet/packages.config:8`

**Severity:** optional  
**Description:** [CVE-2015-9251](https://github.com/advisories/GHSA-rmxg-73gg-4p98): Cross-Site Scripting (XSS) in jquery

Severity: MEDIUM

Affected dependencies:
  - jQuery:1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8; affected range < 1.12.2)
  - jQuery:1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8; affected range >= 1.12.3, < 3.0.0)

Recommended fix: upgrade to a patched version listed above when available.  
**Evidence:** [CVE-2015-9251](https://github.com/advisories/GHSA-rmxg-73gg-4p98): Cross-Site Scripting (XSS) in jquery

Severity: MEDIUM

Affected dependencies:
  - jQuery:1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8; affected range < 1.12.2)
  - jQuery:1.10.2 (declared at WebApp-Storage-DotNet/packages.config:8; affected range >= 1.12.3, < 3.0.0)

Recommended fix: upgrade to a patched version listed above when available.

</details>

---

## Codebase Insights

> AI-generated documents may contain inaccuracies or incomplete information. Please review carefully.

1. **[Architecture Diagram](facts/architecture-diagram.md)** — System layers and component relationships
2. **[Dependency Map](facts/dependency-map.md)** — Declared packages and compatibility concerns
3. **[API & Service Contracts](facts/api-service-contracts.md)** — MVC actions and storage communication
4. **[Data Architecture](facts/data-architecture.md)** — Blob persistence and data boundaries
5. **[Configuration Inventory](facts/configuration-inventory.md)** — Build/runtime settings and secret references
6. **[Business Workflows](facts/business-workflows.md)** — Gallery, upload, and deletion flows

