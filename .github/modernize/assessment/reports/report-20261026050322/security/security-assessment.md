# Security Assessment Report

**Generated:** 2026-10-26T05:10:31.039200Z

**Minimum CVE severity:** medium (one low-severity advisory retained in raw results but excluded here).

## Summary

| Metric | Count |
|--------|-------|
| Total Findings | 24 |
| CVE Vulnerabilities | 16 |
| CWE Vulnerabilities | 8 |
| Total Rules Assessed | 59 |
| Rules Passed (no matching pattern found) | 51 |

### By Severity

| Severity | Count |
|----------|-------|
| mandatory | 4 |
| optional | 17 |
| potential | 3 |

## Coverage and limitations

- Dependency inventory covers the 34 pinned NuGet packages in packages.config and corresponding vendored JavaScript assets. dotnet list package --include-transitive --format json failed because Microsoft.WebApplication.targets is unavailable; dependencies beyond this pinned inventory were not verified.
- CVE findings identify vulnerable versions, not proof that vulnerable features are exercised. Advisory links and branch-specific patched versions are retained with each finding.
- CWE findings are source-based assessments; deployment exploitability was not dynamically tested. FOUND and NOT_FOUND describe the inspected patterns, not a security certification.
- CWE-22, CWE-23, and CWE-36 describe related pathname handling in the same upload operation. Findings are counts of checklist matches, not counts of distinct root causes.
- Assessment severities follow the supplied checklist; optional does not imply that a finding is safe to ignore.
- Application source was not modified. Remediations are recommendations for follow-up work.

## CVE Findings (Dependency Vulnerabilities)

### CVE-2022-30187: Microsoft: CBC Padding Oracle in Azure Blob Storage Encryption Library
- **Category:** CVE
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:5

[CVE-2022-30187](https://github.com/advisories/GHSA-64x4-9hc6-r2h6): Microsoft: CBC Padding Oracle in Azure Blob Storage Encryption Library

Severity: MEDIUM

Affected pinned packages/assets:
- Azure.Storage.Blobs:12.9.1 (nuget; WebApp-Storage-DotNet/packages.config:5)
  Applicable vulnerable range: < 12.13.0; first patched version: 12.13.0.

Recommended fix: upgrade to a supported patched version for the applicable branch listed above and verify compatibility. Where no patched version is listed, the advisory provides no fixed version for that branch; do not assume a same-major upgrade fixes it. Update shipped JavaScript assets as well as package declarations.

Coverage: packages.config inventory fallback after dotnet package enumeration failed on missing Microsoft.WebApplication.targets; unresolved dependencies beyond the pinned inventory are not verified. This is a known-vulnerable-version finding, not proof that the vulnerable feature is exercised. The affected client-side CBC encryption feature is not configured by the inspected HomeController, so feature-specific exploitability is unconfirmed.

### CVE-2018-14040: Bootstrap vulnerable to Cross-Site Scripting (XSS)
- **Category:** CVE
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7, WebApp-Storage-DotNet/Scripts/bootstrap.js:17

[CVE-2018-14040](https://github.com/advisories/GHSA-3wqf-4x89-9g79): Bootstrap vulnerable to Cross-Site Scripting (XSS)

Severity: MEDIUM

Affected pinned packages/assets:
- bootstrap:3.0.0 (nuget; WebApp-Storage-DotNet/packages.config:7)
  Applicable vulnerable range: >= 2.3.0, < 3.4.0; first patched version: 3.4.0.
- bootstrap:3.0.0 (npm; WebApp-Storage-DotNet/packages.config:7; vendored asset WebApp-Storage-DotNet/Scripts/bootstrap.js:17)
  Applicable vulnerable range: >= 2.3.0, < 3.4.0; first patched version: 3.4.0.
  npm metadata identifies the same upstream JavaScript shipped via NuGet; not an installed npm dependency.

Recommended fix: upgrade to a supported patched version for the applicable branch listed above and verify compatibility. Where no patched version is listed, the advisory provides no fixed version for that branch; do not assume a same-major upgrade fixes it. Update shipped JavaScript assets as well as package declarations.

Coverage: packages.config inventory fallback after dotnet package enumeration failed on missing Microsoft.WebApplication.targets; unresolved dependencies beyond the pinned inventory are not verified. This is a known-vulnerable-version finding, not proof that the vulnerable feature is exercised.

### CVE-2019-8331: Bootstrap Vulnerable to Cross-Site Scripting
- **Category:** CVE
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7, WebApp-Storage-DotNet/Scripts/bootstrap.js:17

[CVE-2019-8331](https://github.com/advisories/GHSA-9v3m-8fp8-mj99): Bootstrap Vulnerable to Cross-Site Scripting

Severity: MEDIUM

Affected pinned packages/assets:
- bootstrap:3.0.0 (nuget; WebApp-Storage-DotNet/packages.config:7)
  Applicable vulnerable range: >= 3.0.0, < 3.4.1; first patched version: 3.4.1.
- bootstrap:3.0.0 (npm; WebApp-Storage-DotNet/packages.config:7; vendored asset WebApp-Storage-DotNet/Scripts/bootstrap.js:17)
  Applicable vulnerable range: >= 3.0.0, < 3.4.1; first patched version: 3.4.1.
  npm metadata identifies the same upstream JavaScript shipped via NuGet; not an installed npm dependency.

Recommended fix: upgrade to a supported patched version for the applicable branch listed above and verify compatibility. Where no patched version is listed, the advisory provides no fixed version for that branch; do not assume a same-major upgrade fixes it. Update shipped JavaScript assets as well as package declarations.

Coverage: packages.config inventory fallback after dotnet package enumeration failed on missing Microsoft.WebApplication.targets; unresolved dependencies beyond the pinned inventory are not verified. This is a known-vulnerable-version finding, not proof that the vulnerable feature is exercised.

### CVE-2018-20677: bootstrap Cross-site Scripting vulnerability
- **Category:** CVE
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7, WebApp-Storage-DotNet/Scripts/bootstrap.js:17

[CVE-2018-20677](https://github.com/advisories/GHSA-ph58-4vrj-w6hr): bootstrap Cross-site Scripting vulnerability

Severity: MEDIUM

Affected pinned packages/assets:
- bootstrap:3.0.0 (nuget; WebApp-Storage-DotNet/packages.config:7)
  Applicable vulnerable range: < 3.4.0; first patched version: 3.4.0.
- bootstrap:3.0.0 (npm; WebApp-Storage-DotNet/packages.config:7; vendored asset WebApp-Storage-DotNet/Scripts/bootstrap.js:17)
  Applicable vulnerable range: < 3.4.0; first patched version: 3.4.0.
  npm metadata identifies the same upstream JavaScript shipped via NuGet; not an installed npm dependency.

Recommended fix: upgrade to a supported patched version for the applicable branch listed above and verify compatibility. Where no patched version is listed, the advisory provides no fixed version for that branch; do not assume a same-major upgrade fixes it. Update shipped JavaScript assets as well as package declarations.

Coverage: packages.config inventory fallback after dotnet package enumeration failed on missing Microsoft.WebApplication.targets; unresolved dependencies beyond the pinned inventory are not verified. This is a known-vulnerable-version finding, not proof that the vulnerable feature is exercised.

### CVE-2018-20676: XSS vulnerability that affects bootstrap
- **Category:** CVE
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7, WebApp-Storage-DotNet/Scripts/bootstrap.js:17

[CVE-2018-20676](https://github.com/advisories/GHSA-3mgp-fx93-9xv5): XSS vulnerability that affects bootstrap

Severity: MEDIUM

Affected pinned packages/assets:
- bootstrap:3.0.0 (nuget; WebApp-Storage-DotNet/packages.config:7)
  Applicable vulnerable range: < 3.4.0; first patched version: 3.4.0.
- bootstrap:3.0.0 (npm; WebApp-Storage-DotNet/packages.config:7; vendored asset WebApp-Storage-DotNet/Scripts/bootstrap.js:17)
  Applicable vulnerable range: < 3.4.0; first patched version: 3.4.0.
  npm metadata identifies the same upstream JavaScript shipped via NuGet; not an installed npm dependency.

Recommended fix: upgrade to a supported patched version for the applicable branch listed above and verify compatibility. Where no patched version is listed, the advisory provides no fixed version for that branch; do not assume a same-major upgrade fixes it. Update shipped JavaScript assets as well as package declarations.

Coverage: packages.config inventory fallback after dotnet package enumeration failed on missing Microsoft.WebApplication.targets; unresolved dependencies beyond the pinned inventory are not verified. This is a known-vulnerable-version finding, not proof that the vulnerable feature is exercised.

### CVE-2016-10735: Bootstrap Cross-site Scripting vulnerability
- **Category:** CVE
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7, WebApp-Storage-DotNet/Scripts/bootstrap.js:17

[CVE-2016-10735](https://github.com/advisories/GHSA-4p24-vmcr-4gqj): Bootstrap Cross-site Scripting vulnerability

Severity: MEDIUM

Affected pinned packages/assets:
- bootstrap:3.0.0 (nuget; WebApp-Storage-DotNet/packages.config:7)
  Applicable vulnerable range: >= 2.0.4, < 3.4.0; first patched version: 3.4.0.
- bootstrap:3.0.0 (npm; WebApp-Storage-DotNet/packages.config:7; vendored asset WebApp-Storage-DotNet/Scripts/bootstrap.js:17)
  Applicable vulnerable range: >= 2.0.4, < 3.4.0; first patched version: 3.4.0.
  npm metadata identifies the same upstream JavaScript shipped via NuGet; not an installed npm dependency.

Recommended fix: upgrade to a supported patched version for the applicable branch listed above and verify compatibility. Where no patched version is listed, the advisory provides no fixed version for that branch; do not assume a same-major upgrade fixes it. Update shipped JavaScript assets as well as package declarations.

Coverage: packages.config inventory fallback after dotnet package enumeration failed on missing Microsoft.WebApplication.targets; unresolved dependencies beyond the pinned inventory are not verified. This is a known-vulnerable-version finding, not proof that the vulnerable feature is exercised.

### CVE-2018-14042: Bootstrap Cross-site Scripting vulnerability
- **Category:** CVE
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7, WebApp-Storage-DotNet/Scripts/bootstrap.js:17

[CVE-2018-14042](https://github.com/advisories/GHSA-7mvr-5x2g-wfc8): Bootstrap Cross-site Scripting vulnerability

Severity: MEDIUM

Affected pinned packages/assets:
- bootstrap:3.0.0 (nuget; WebApp-Storage-DotNet/packages.config:7)
  Applicable vulnerable range: >= 2.3.0, < 3.4.0; first patched version: 3.4.0.
- bootstrap:3.0.0 (npm; WebApp-Storage-DotNet/packages.config:7; vendored asset WebApp-Storage-DotNet/Scripts/bootstrap.js:17)
  Applicable vulnerable range: >= 2.3.0, < 3.4.0; first patched version: 3.4.0.
  npm metadata identifies the same upstream JavaScript shipped via NuGet; not an installed npm dependency.

Recommended fix: upgrade to a supported patched version for the applicable branch listed above and verify compatibility. Where no patched version is listed, the advisory provides no fixed version for that branch; do not assume a same-major upgrade fixes it. Update shipped JavaScript assets as well as package declarations.

Coverage: packages.config inventory fallback after dotnet package enumeration failed on missing Microsoft.WebApplication.targets; unresolved dependencies beyond the pinned inventory are not verified. This is a known-vulnerable-version finding, not proof that the vulnerable feature is exercised.

### CVE-2020-11023: Potential XSS vulnerability in jQuery
- **Category:** CVE
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:8, WebApp-Storage-DotNet/Scripts/jquery-1.10.2.js:16

[CVE-2020-11023](https://github.com/advisories/GHSA-jpcq-cgw6-v4j6): Potential XSS vulnerability in jQuery

Severity: MEDIUM

Affected pinned packages/assets:
- jQuery:1.10.2 (nuget; WebApp-Storage-DotNet/packages.config:8)
  Applicable vulnerable range: >= 1.0.3, < 3.5.0; first patched version: 3.5.0.
- jquery:1.10.2 (npm; WebApp-Storage-DotNet/packages.config:8; vendored asset WebApp-Storage-DotNet/Scripts/jquery-1.10.2.js:16)
  Applicable vulnerable range: >= 1.0.3, < 3.5.0; first patched version: 3.5.0.
  npm metadata identifies the same upstream JavaScript shipped via NuGet; not an installed npm dependency.

Recommended fix: upgrade to a supported patched version for the applicable branch listed above and verify compatibility. Where no patched version is listed, the advisory provides no fixed version for that branch; do not assume a same-major upgrade fixes it. Update shipped JavaScript assets as well as package declarations.

Coverage: packages.config inventory fallback after dotnet package enumeration failed on missing Microsoft.WebApplication.targets; unresolved dependencies beyond the pinned inventory are not verified. This is a known-vulnerable-version finding, not proof that the vulnerable feature is exercised.

### CVE-2019-11358: XSS in jQuery as used in Drupal, Backdrop CMS, and other products
- **Category:** CVE
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:8, WebApp-Storage-DotNet/Scripts/jquery-1.10.2.js:16

[CVE-2019-11358](https://github.com/advisories/GHSA-6c3j-c64m-qhgq): XSS in jQuery as used in Drupal, Backdrop CMS, and other products

Severity: MEDIUM

Affected pinned packages/assets:
- jQuery:1.10.2 (nuget; WebApp-Storage-DotNet/packages.config:8)
  Applicable vulnerable range: >= 1.1.4, < 3.4.0; first patched version: 3.4.0.
- jquery:1.10.2 (npm; WebApp-Storage-DotNet/packages.config:8; vendored asset WebApp-Storage-DotNet/Scripts/jquery-1.10.2.js:16)
  Applicable vulnerable range: >= 1.1.4, < 3.4.0; first patched version: 3.4.0.
  npm metadata identifies the same upstream JavaScript shipped via NuGet; not an installed npm dependency.

Recommended fix: upgrade to a supported patched version for the applicable branch listed above and verify compatibility. Where no patched version is listed, the advisory provides no fixed version for that branch; do not assume a same-major upgrade fixes it. Update shipped JavaScript assets as well as package declarations.

Coverage: packages.config inventory fallback after dotnet package enumeration failed on missing Microsoft.WebApplication.targets; unresolved dependencies beyond the pinned inventory are not verified. This is a known-vulnerable-version finding, not proof that the vulnerable feature is exercised.

### CVE-2015-9251: Cross-Site Scripting (XSS) in jquery
- **Category:** CVE
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:8, WebApp-Storage-DotNet/Scripts/jquery-1.10.2.js:16

[CVE-2015-9251](https://github.com/advisories/GHSA-rmxg-73gg-4p98): Cross-Site Scripting (XSS) in jquery

Severity: MEDIUM

Affected pinned packages/assets:
- jQuery:1.10.2 (nuget; WebApp-Storage-DotNet/packages.config:8)
  Applicable vulnerable range: < 1.12.2; first patched version: 1.12.2.
- jquery:1.10.2 (npm; WebApp-Storage-DotNet/packages.config:8; vendored asset WebApp-Storage-DotNet/Scripts/jquery-1.10.2.js:16)
  Applicable vulnerable range: < 1.12.2; first patched version: 1.12.2.
  npm metadata identifies the same upstream JavaScript shipped via NuGet; not an installed npm dependency.

Recommended fix: upgrade to a supported patched version for the applicable branch listed above and verify compatibility. Where no patched version is listed, the advisory provides no fixed version for that branch; do not assume a same-major upgrade fixes it. Update shipped JavaScript assets as well as package declarations.

Coverage: packages.config inventory fallback after dotnet package enumeration failed on missing Microsoft.WebApplication.targets; unresolved dependencies beyond the pinned inventory are not verified. This is a known-vulnerable-version finding, not proof that the vulnerable feature is exercised.

### CVE-2021-21252: Regular Expression Denial of Service in jquery-validation
- **Category:** CVE
- **Severity:** mandatory
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:9, WebApp-Storage-DotNet/Scripts/jquery.validate.js:16

[CVE-2021-21252](https://github.com/advisories/GHSA-jxwx-85vp-gvwm): Regular Expression Denial of Service in jquery-validation

Severity: HIGH

Affected pinned packages/assets:
- jQuery.Validation:1.11.1 (nuget; WebApp-Storage-DotNet/packages.config:9)
  Applicable vulnerable range: < 1.19.3; first patched version: 1.19.3.
- jquery-validation:1.11.1 (npm; WebApp-Storage-DotNet/packages.config:9; vendored asset WebApp-Storage-DotNet/Scripts/jquery.validate.js:16)
  Applicable vulnerable range: < 1.19.3; first patched version: 1.19.3.
  npm metadata identifies the same upstream JavaScript shipped via NuGet; not an installed npm dependency.

Recommended fix: upgrade to a supported patched version for the applicable branch listed above and verify compatibility. Where no patched version is listed, the advisory provides no fixed version for that branch; do not assume a same-major upgrade fixes it. Update shipped JavaScript assets as well as package declarations.

Coverage: packages.config inventory fallback after dotnet package enumeration failed on missing Microsoft.WebApplication.targets; unresolved dependencies beyond the pinned inventory are not verified. This is a known-vulnerable-version finding, not proof that the vulnerable feature is exercised.

### CVE-2018-8269: Denial of service in ASP.NET Core
- **Category:** CVE
- **Severity:** mandatory
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:17

[CVE-2018-8269](https://github.com/advisories/GHSA-mv2r-q4g5-j8q5): Denial of service in ASP.NET Core

Severity: HIGH

Affected pinned packages/assets:
- Microsoft.Data.OData:5.6.4 (nuget; WebApp-Storage-DotNet/packages.config:17)
  Applicable vulnerable range: < 5.8.4; first patched version: 5.8.4.

Recommended fix: upgrade to a supported patched version for the applicable branch listed above and verify compatibility. Where no patched version is listed, the advisory provides no fixed version for that branch; do not assume a same-major upgrade fixes it. Update shipped JavaScript assets as well as package declarations.

Coverage: packages.config inventory fallback after dotnet package enumeration failed on missing Microsoft.WebApplication.targets; unresolved dependencies beyond the pinned inventory are not verified. This is a known-vulnerable-version finding, not proof that the vulnerable feature is exercised.

### CVE-2024-21907: Improper Handling of Exceptional Conditions in Newtonsoft.Json
- **Category:** CVE
- **Severity:** mandatory
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:23

[CVE-2024-21907](https://github.com/advisories/GHSA-5crp-9r3c-p9vr): Improper Handling of Exceptional Conditions in Newtonsoft.Json

Severity: HIGH

Affected pinned packages/assets:
- Newtonsoft.Json:6.0.8 (nuget; WebApp-Storage-DotNet/packages.config:23)
  Applicable vulnerable range: < 13.0.1; first patched version: 13.0.1.

Recommended fix: upgrade to a supported patched version for the applicable branch listed above and verify compatibility. Where no patched version is listed, the advisory provides no fixed version for that branch; do not assume a same-major upgrade fixes it. Update shipped JavaScript assets as well as package declarations.

Coverage: packages.config inventory fallback after dotnet package enumeration failed on missing Microsoft.WebApplication.targets; unresolved dependencies beyond the pinned inventory are not verified. This is a known-vulnerable-version finding, not proof that the vulnerable feature is exercised.

### CVE-2024-6485: Bootstrap Cross-Site Scripting (XSS) vulnerability for data-* attributes
- **Category:** CVE
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7, WebApp-Storage-DotNet/Scripts/bootstrap.js:17

[CVE-2024-6485](https://github.com/advisories/GHSA-vxmc-5x29-h64v): Bootstrap Cross-Site Scripting (XSS) vulnerability for data-* attributes

Severity: MEDIUM

Affected pinned packages/assets:
- bootstrap:3.0.0 (npm; WebApp-Storage-DotNet/packages.config:7; vendored asset WebApp-Storage-DotNet/Scripts/bootstrap.js:17)
  Applicable vulnerable range: >= 1.4.0, <= 3.4.1; first patched version: none provided.
  npm metadata identifies the same upstream JavaScript shipped via NuGet; not an installed npm dependency.

Recommended fix: upgrade to a supported patched version for the applicable branch listed above and verify compatibility. Where no patched version is listed, the advisory provides no fixed version for that branch; do not assume a same-major upgrade fixes it. Update shipped JavaScript assets as well as package declarations.

Coverage: packages.config inventory fallback after dotnet package enumeration failed on missing Microsoft.WebApplication.targets; unresolved dependencies beyond the pinned inventory are not verified. This is a known-vulnerable-version finding, not proof that the vulnerable feature is exercised.

### CVE-2025-3573: jquery-validation vulnerable to Cross-site Scripting
- **Category:** CVE
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:9, WebApp-Storage-DotNet/Scripts/jquery.validate.js:16

[CVE-2025-3573](https://github.com/advisories/GHSA-rrj2-ph5q-jxw2): jquery-validation vulnerable to Cross-site Scripting

Severity: MEDIUM

Affected pinned packages/assets:
- jquery-validation:1.11.1 (npm; WebApp-Storage-DotNet/packages.config:9; vendored asset WebApp-Storage-DotNet/Scripts/jquery.validate.js:16)
  Applicable vulnerable range: < 1.20.0; first patched version: 1.20.0.
  npm metadata identifies the same upstream JavaScript shipped via NuGet; not an installed npm dependency.

Recommended fix: upgrade to a supported patched version for the applicable branch listed above and verify compatibility. Where no patched version is listed, the advisory provides no fixed version for that branch; do not assume a same-major upgrade fixes it. Update shipped JavaScript assets as well as package declarations.

Coverage: packages.config inventory fallback after dotnet package enumeration failed on missing Microsoft.WebApplication.targets; unresolved dependencies beyond the pinned inventory are not verified. This is a known-vulnerable-version finding, not proof that the vulnerable feature is exercised.

### CVE-2022-31147: jquery-validation Regular Expression Denial of Service due to arbitrary input to url2 method
- **Category:** CVE
- **Severity:** mandatory
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:9, WebApp-Storage-DotNet/Scripts/jquery.validate.js:16

[CVE-2022-31147](https://github.com/advisories/GHSA-ffmh-x56j-9rc3): jquery-validation Regular Expression Denial of Service due to arbitrary input to url2 method

Severity: HIGH

Affected pinned packages/assets:
- jquery-validation:1.11.1 (npm; WebApp-Storage-DotNet/packages.config:9; vendored asset WebApp-Storage-DotNet/Scripts/jquery.validate.js:16)
  Applicable vulnerable range: < 1.19.5; first patched version: 1.19.5.
  npm metadata identifies the same upstream JavaScript shipped via NuGet; not an installed npm dependency.

Recommended fix: upgrade to a supported patched version for the applicable branch listed above and verify compatibility. Where no patched version is listed, the advisory provides no fixed version for that branch; do not assume a same-major upgrade fixes it. Update shipped JavaScript assets as well as package declarations.

Coverage: packages.config inventory fallback after dotnet package enumeration failed on missing Microsoft.WebApplication.targets; unresolved dependencies beyond the pinned inventory are not verified. This is a known-vulnerable-version finding, not proof that the vulnerable feature is exercised. The advisory targets the url2 method in additional-methods.js; that additional file/method is not shipped in the inspected repository, so this upstream package-version match is not confirmed reachable in this deployment.

## CWE Findings (Code-Level Vulnerabilities)

### CWE-665: Improper Initialization
- **Category:** Code Quality
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:47, WebApp-Storage-DotNet/Controllers/HomeController.cs:63-66, WebApp-Storage-DotNet/Controllers/HomeController.cs:108-118, WebApp-Storage-DotNet/Views/Shared/Error.cshtml:7-9

HomeController.blobContainer is left null at application startup and is initialized only by visiting Index. UploadAsync dereferences this shared resource at line 108 without ensuring Index ran. A direct multipart POST after worker startup/recycle therefore reliably raises NullReferenceException; the catch block publishes the detailed exception and stack trace via Error.cshtml. This is a request-order-dependent initialization defect and information exposure, not a memory-corruption claim. Valid storage setup and a request to Index avoid this particular null state.

### CWE-732: Incorrect Permission Assignment for Critical Resource
- **Category:** Credentials & Secrets
- **Severity:** optional
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:44-47, WebApp-Storage-DotNet/Controllers/HomeController.cs:127-162, WebApp-Storage-DotNet/App_Start/FilterConfig.cs:8-10, WebApp-Storage-DotNet/Web.config:23-26

The gallery routes expose DeleteImage and DeleteAll with only HttpPost; there is no controller/action authorization, ownership check, global Authorize filter, or web.config authorization restriction. Any reachable anonymous caller can invoke DeleteAll to delete every block blob using the application storage identity (158-162), or DeleteImage to delete a known blob. This confers destructive storage modification permissions to arbitrary site visitors, not merely the intentionally public read access configured at line 66. Exploitation requires a configured storage account and initialized container; lack of anti-forgery checks also permits cross-site form submission.

### CWE-778: Insufficient Logging
- **Category:** Credentials & Secrets
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:128-172

Security-critical blob deletion (DeleteImage at 136 and DeleteAll at 162) is followed only by a redirect. No application audit record contains actor, target, outcome, or deletion count. Failure handlers (140-144, 168-172) send the exception to a view instead of recording it. Repository-wide application C# inspection found no audit/logging provider or logging calls; no storage diagnostic configuration is committed. Anonymous bulk deletion can therefore occur without an application-level security event record. External platform/storage logging may exist but cannot be verified from this repository.

### CWE-22: Improper Limitation of a Pathname to a Restricted Directory ('Path Traversal')
- **Category:** File & Path Security
- **Severity:** optional
- **Story Points:** 8
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:101-109, WebApp-Storage-DotNet/Controllers/HomeController.cs:65-78

HomeController.UploadAsync passes attacker-controlled multipart files[i].FileName directly to BlobClient.UploadAsync(string path) at line 109, which reads a server-local file rather than the uploaded InputStream. No path containment or authorization is enforced. After Index initializes the client (65-66), a crafted relative or absolute server pathname can copy any process-readable local file into the blob container. Index creates that container with PublicAccessType.Blob and lists the new blob URI (66, 75-78), enabling remote retrieval when Azure storage is configured and public access is permitted. The source extension is retained (181-182), not a path restriction. API contract: https://learn.microsoft.com/en-us/dotnet/api/azure.storage.blobs.blobclient.uploadasync (string path denotes a local file). Pinned 12.9.1 SDK source verification: https://raw.githubusercontent.com/Azure/azure-sdk-for-net/Azure.Storage.Blobs_12.9.1/sdk/storage/Azure.Storage.Blobs/src/BlobClient.cs; UploadAsync(string path, ...) opens new FileStream(path, FileMode.Open, FileAccess.Read) (SDK source lines 1565-1575).

### CWE-23: Relative Path Traversal
- **Category:** File & Path Security
- **Severity:** optional
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:101-109, WebApp-Storage-DotNet/Controllers/HomeController.cs:65-78

HomeController.UploadAsync passes attacker-controlled multipart files[i].FileName directly to BlobClient.UploadAsync(string path) at line 109, which reads a server-local file rather than the uploaded InputStream. No path containment or authorization is enforced. After Index initializes the client (65-66), a crafted relative traversal pathname containing .. can copy any process-readable local file into the blob container. Index creates that container with PublicAccessType.Blob and lists the new blob URI (66, 75-78), enabling remote retrieval when Azure storage is configured and public access is permitted. The source extension is retained (181-182), not a path restriction. API contract: https://learn.microsoft.com/en-us/dotnet/api/azure.storage.blobs.blobclient.uploadasync (string path denotes a local file). Pinned 12.9.1 SDK source verification: https://raw.githubusercontent.com/Azure/azure-sdk-for-net/Azure.Storage.Blobs_12.9.1/sdk/storage/Azure.Storage.Blobs/src/BlobClient.cs; UploadAsync(string path, ...) opens new FileStream(path, FileMode.Open, FileAccess.Read) (SDK source lines 1565-1575).

### CWE-36: Absolute Path Traversal
- **Category:** File & Path Security
- **Severity:** optional
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:101-109, WebApp-Storage-DotNet/Controllers/HomeController.cs:65-78

HomeController.UploadAsync passes attacker-controlled multipart files[i].FileName directly to BlobClient.UploadAsync(string path) at line 109, which reads a server-local file rather than the uploaded InputStream. No path containment or authorization is enforced. After Index initializes the client (65-66), a crafted absolute server pathname can copy any process-readable local file into the blob container. Index creates that container with PublicAccessType.Blob and lists the new blob URI (66, 75-78), enabling remote retrieval when Azure storage is configured and public access is permitted. The source extension is retained (181-182), not a path restriction. API contract: https://learn.microsoft.com/en-us/dotnet/api/azure.storage.blobs.blobclient.uploadasync (string path denotes a local file). Pinned 12.9.1 SDK source verification: https://raw.githubusercontent.com/Azure/azure-sdk-for-net/Azure.Storage.Blobs_12.9.1/sdk/storage/Azure.Storage.Blobs/src/BlobClient.cs; UploadAsync(string path, ...) opens new FileStream(path, FileMode.Open, FileAccess.Read) (SDK source lines 1565-1575).

### CWE-79: Improper Neutralization of Input During Web Page Generation ('Cross-site Scripting')
- **Category:** Injection Attacks
- **Severity:** optional
- **Story Points:** 8
- **Files:** WebApp-Storage-DotNet/Views/Home/Index.cshtml:72-85

DisplayFilesToUpload concatenates the selected File.name without HTML encoding (80) into html and assigns it to FilesToUpload.innerHTML (85). A filename containing an HTML element with an event handler is interpreted as active markup in the gallery origin. This is a user-assisted DOM XSS path: an attacker must deliver a specially named local file and persuade the victim to select it in the file picker; it is not a remotely triggerable stored upload finding. The sink executes before submission, independently of the server upload failure.

### CWE-99: Improper Control of Resource Identifiers ('Resource Injection')
- **Category:** Injection Attacks
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:101-109

HomeController.UploadAsync uses a multipart filename supplied by the requester as the server-local resource identifier passed to BlobClient.UploadAsync(string path), without restriction to uploaded data or a permitted directory. Once Index initializes the container, this permits selection of any process-readable local file for transfer to Azure blobs. The filename is a local file path, not an upload stream; this is the same root cause as the path-traversal findings.
