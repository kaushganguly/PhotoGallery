# Security Assessment Report

**Generated:** 2026-10-26T13:41:41.753229Z

## Summary

| Metric | Count |
|--------|-------|
| Total Findings | 14 |
| CVE Vulnerabilities | 3 |
| CWE Vulnerabilities | 11 |
| Total Rules Assessed | 59 |
| Rules Passed | 48 |

### By Severity

| Severity | Count |
|----------|-------|
| mandatory | 4 |
| optional | 5 |
| potential | 5 |

## CVE Findings (Dependency Vulnerabilities)

### CVE-2021-21252: Regular Expression Denial of Service in jquery-validation
- **Severity:** mandatory
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:9

[CVE-2021-21252](https://github.com/advisories/GHSA-jxwx-85vp-gvwm): jquery-validation has a regular expression denial-of-service vulnerability. Severity: HIGH. Affected dependency: jQuery.Validation 1.11.1 (declared at WebApp-Storage-DotNet/packages.config:9); affected versions are below 1.19.3. Recommended fix: upgrade to 1.19.3 or later.

### CVE-2018-8269: Denial of service in ASP.NET Core
- **Severity:** mandatory
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:17

[CVE-2018-8269](https://github.com/advisories/GHSA-mv2r-q4g5-j8q5): Microsoft.Data.OData has a denial-of-service vulnerability when it improperly handles web requests. Severity: HIGH. Affected dependency: Microsoft.Data.OData 5.6.4 (declared at WebApp-Storage-DotNet/packages.config:17); affected versions are below 5.8.4. Recommended fix: upgrade to 5.8.4 or later.

### CVE-2024-21907: Improper Handling of Exceptional Conditions in Newtonsoft.Json
- **Severity:** mandatory
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:23

[CVE-2024-21907](https://github.com/advisories/GHSA-5crp-9r3c-p9vr): Newtonsoft.Json before 13.0.1 can exhibit high CPU and memory use or stack overflow when handling deeply nested data. Severity: HIGH. Affected dependency: Newtonsoft.Json 6.0.8 (declared at WebApp-Storage-DotNet/packages.config:23); affected versions are below 13.0.1. Recommended fix: upgrade to 13.0.1 or later. The duplicate advisory GHSA-8rfx-6mr3-5jh3 was withdrawn and excluded.

## CWE Findings (Code-Level Vulnerabilities)

### CWE-606: Unchecked Input for Loop Condition
- **Category:** Code Quality
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

HomeController.UploadAsync takes fileCount directly from the client-controlled Request.Files collection (lines 101-102) and iterates to that count without a maximum (line 106), allowing requests with many file parts to drive unbounded per-file processing.

### CWE-665: Improper Initialization
- **Category:** Code Quality
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

The static blobContainer is only assigned during Index (lines 63-66), but UploadAsync and DeleteImage use it without ensuring Index has run (lines 108 and 135). A direct request to either action before Index initializes the client uses a null resource.

### CWE-567: Unsynchronized Access to Shared Data in a Multithreaded Context
- **Category:** Concurrency & Synchronization
- **Severity:** potential
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

HomeController.blobContainer is a mutable static field (line 47). Index assigns it per request (line 65) while UploadAsync, DeleteImage, and DeleteAll read it without synchronization (lines 108, 135, and 158), so requests can access the shared reference concurrently.

### CWE-820: Missing Synchronization
- **Category:** Concurrency & Synchronization
- **Severity:** potential
- **Story Points:** 8
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

The static blobContainer reference is updated by Index and used concurrently by other controller actions without a lock or other synchronization (lines 47, 65, 108, 135, and 158).

### CWE-732: Incorrect Permission Assignment for Critical Resource
- **Category:** Credentials & Secrets
- **Severity:** optional
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

HomeController.Index creates the blob container with PublicAccessType.Blob (line 66), making uploaded objects anonymously readable. The permission is applied to the gallery's storage container without an access-control check.

### CWE-778: Insufficient Logging
- **Category:** Credentials & Secrets
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

The UploadAsync, DeleteImage, and DeleteAll actions perform security-relevant storage changes (lines 97-174) without recording successful operations or actor/resource details. Exceptions are surfaced to the error view rather than written to an audit or application log (for example, lines 114-118).

### CWE-22: Improper Limitation of a Pathname to a Restricted Directory ('Path Traversal')
- **Category:** File & Path Security
- **Severity:** optional
- **Story Points:** 8
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

HomeController.UploadAsync reads the client-supplied Request.Files[i].FileName (line 101) and passes it directly to BlobClient.UploadAsync as a local file path (line 109). Path elements are not constrained to an upload directory, allowing traversal beyond an intended directory.

### CWE-23: Relative Path Traversal
- **Category:** File & Path Security
- **Severity:** optional
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

HomeController.UploadAsync passes the untrusted multipart filename from Request.Files[i].FileName (line 101) to BlobClient.UploadAsync (line 109), which treats it as a local path. Relative traversal sequences are not checked or restricted.

### CWE-36: Absolute Path Traversal
- **Category:** File & Path Security
- **Severity:** optional
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

HomeController.UploadAsync passes the client-supplied multipart filename from Request.Files[i].FileName (line 101) directly to BlobClient.UploadAsync as the source path (line 109). An absolute pathname is not constrained to an upload directory.

### CWE-434: Unrestricted Upload of File with Dangerous Type
- **Category:** File & Path Security
- **Severity:** mandatory
- **Story Points:** 8
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs

HomeController.UploadAsync accepts all multipart files without validating extension or content type (lines 101-110), preserves the submitted extension in GetRandomBlobName (lines 179-182), and stores blobs in a container made publicly readable by Index (line 66). Thus uploaded active content can be publicly served and processed by clients.

### CWE-79: Improper Neutralization of Input During Web Page Generation ('Cross-site Scripting')
- **Category:** Injection Attacks
- **Severity:** optional
- **Story Points:** 8
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs, WebApp-Storage-DotNet/Views/Home/Index.cshtml

UploadAsync derives a stored blob name using the user-supplied filename extension (HomeController.cs:108, 179-182), and Index.cshtml places each blob URI into a single-quoted JavaScript argument in an inline onclick attribute (line 53). HTML encoding does not provide JavaScript-string-context encoding; attacker-controlled characters in the retained extension can break out of the string when the gallery is viewed.
