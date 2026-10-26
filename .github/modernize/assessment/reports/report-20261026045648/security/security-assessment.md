# Security Assessment Report

**Generated:** 2026-10-26T05:02:17.156140Z

## Scope and limitations

All 34 packages declared in `packages.config` were checked against GitHub advisories. Dependency CLI resolution failed because Microsoft.WebApplication.targets is unavailable; dependencies outside that manifest and live deployment controls were not verified. Minimum CVE severity: **medium**. CVEs indicate affected versions, not confirmed reachable exploits. CWE findings can overlap: CWE-22, CWE-23, CWE-36 and CWE-99 describe one upload-path root cause. NOT_FOUND means no evidence found in this review, not a guarantee of safety. Findings are recommendations only; application code is unchanged.

## Summary

| Metric | Count |
|---|---:|
| TotalFindings | 22 |
| CveCount | 13 |
| CweCount | 9 |
| TotalRulesAssessed | 59 |
| RulesPassed | 50 |

### By Severity

| Severity | Count |
|---|---:|
| optional | 15 |
| mandatory | 3 |
| potential | 4 |

## CVE Findings (Dependency Vulnerabilities)

### CVE-2022-30187: Microsoft: CBC Padding Oracle in Azure Blob Storage Encryption Library
- **Category:** CVE
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:5

[CVE-2022-30187](https://github.com/advisories/GHSA-64x4-9hc6-r2h6). Severity: MEDIUM. Azure.Storage.Blobs 12.9.1 matches NuGet range < 12.13.0. Upgrade to 12.13.0 or later and follow the advisory's client-side encryption migration guidance. Package-version finding; client-side encryption exploitability is not established. Collection: dotnet list package --include-transitive --format json failed because Microsoft.WebApplication.targets is missing; packages.config supplied all 34 declared packages, including NuGet-distributed JavaScript. Public GitHub Advisory REST queries used batches of 30 and 4, followed pagination, filtered NuGet package identities and installed-version ranges, excluded three withdrawn advisories, and deduplicated CVEs. Thirteen active version matches were found. Coverage does not establish deployment state, framework/OS patching, dependencies absent from the manifest, or runtime exploitability.

### CVE-2024-21907: Improper Handling of Exceptional Conditions in Newtonsoft.Json
- **Category:** CVE
- **Severity:** mandatory
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:23

[CVE-2024-21907](https://github.com/advisories/GHSA-5crp-9r3c-p9vr). Severity: HIGH. Newtonsoft.Json 6.0.8 matches NuGet range < 13.0.1. Excessively nested JSON can cause stack exhaustion/denial of service. Upgrade to 13.0.1 or later. Package-version finding; an attacker-controlled deserialization path is not established.

### CVE-2018-14040: Bootstrap vulnerable to Cross-Site Scripting (XSS)
- **Category:** CVE
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2018-14040](https://github.com/advisories/GHSA-3wqf-4x89-9g79). Severity: MEDIUM. bootstrap 3.0.0 matches NuGet range >= 2.3.0, < 3.4.0. Upgrade to 3.4.0 or later; prefer a supported release covering all listed advisories. Package-version finding, not proof of a reachable application XSS.

### CVE-2021-21252: Regular Expression Denial of Service in jquery-validation
- **Category:** CVE
- **Severity:** mandatory
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:9

[CVE-2021-21252](https://github.com/advisories/GHSA-jxwx-85vp-gvwm). Severity: HIGH. jQuery.Validation 1.11.1 matches NuGet range < 1.19.3. Crafted input to vulnerable validation expressions can cause excessive processing/denial of service. Upgrade to 1.19.3 or later. Package-version finding; vulnerable validators are not proven reachable in the application.

### CVE-2020-11023: Potential XSS vulnerability in jQuery
- **Category:** CVE
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:8

[CVE-2020-11023](https://github.com/advisories/GHSA-jpcq-cgw6-v4j6). Severity: MEDIUM. jQuery 1.10.2 matches NuGet range >= 1.0.3, < 3.5.0. Upgrade to 3.5.0 or later. Package-version finding; passing attacker-controlled HTML to affected DOM methods is not established.

### CVE-2019-11358: XSS in jQuery as used in Drupal, Backdrop CMS, and other products
- **Category:** CVE
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:8

[CVE-2019-11358](https://github.com/advisories/GHSA-6c3j-c64m-qhgq). Severity: MEDIUM. jQuery 1.10.2 matches NuGet range >= 1.1.4, < 3.4.0. Prototype pollution can arise from deep extending attacker-controlled objects. Upgrade to 3.4.0 or later. Package-version finding, not proof of an exploitable application call.

### CVE-2019-8331: Bootstrap Vulnerable to Cross-Site Scripting
- **Category:** CVE
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2019-8331](https://github.com/advisories/GHSA-9v3m-8fp8-mj99). Severity: MEDIUM. bootstrap 3.0.0 matches NuGet range >= 3.0.0, < 3.4.1. Upgrade to 3.4.1 or later. Package-version finding; attacker control of affected tooltip/popover configuration is not established.

### CVE-2018-20677: bootstrap Cross-site Scripting vulnerability
- **Category:** CVE
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2018-20677](https://github.com/advisories/GHSA-ph58-4vrj-w6hr). Severity: MEDIUM. bootstrap 3.0.0 matches NuGet range < 3.4.0. Upgrade to 3.4.0 or later. Package-version finding; application-level exploitability is not established.

### CVE-2018-20676: XSS vulnerability that affects bootstrap
- **Category:** CVE
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2018-20676](https://github.com/advisories/GHSA-3mgp-fx93-9xv5). Severity: MEDIUM. bootstrap 3.0.0 matches NuGet range < 3.4.0. Upgrade to 3.4.0 or later. Package-version finding; application-level exploitability is not established.

### CVE-2016-10735: Bootstrap Cross-site Scripting vulnerability
- **Category:** CVE
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2016-10735](https://github.com/advisories/GHSA-4p24-vmcr-4gqj). Severity: MEDIUM. bootstrap 3.0.0 matches NuGet range >= 2.0.4, < 3.4.0 (stable 3.0.0 does not match the separate 4.0.0 prerelease range). Upgrade to 3.4.0 or later. Package-version finding; application-level exploitability is not established.

### CVE-2018-8269: Denial of service in ASP.NET Core
- **Category:** CVE
- **Severity:** mandatory
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:17

[CVE-2018-8269](https://github.com/advisories/GHSA-mv2r-q4g5-j8q5). Severity: HIGH. Microsoft.Data.OData 5.6.4 matches NuGet range < 5.8.4. Improper OData request handling can cause denial of service. Upgrade to 5.8.4 or later. The advisory title is upstream metadata and does not imply this ASP.NET Framework application uses ASP.NET Core. Package-version finding; a reachable OData endpoint is not established.

### CVE-2018-14042: Bootstrap Cross-site Scripting vulnerability
- **Category:** CVE
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:7

[CVE-2018-14042](https://github.com/advisories/GHSA-7mvr-5x2g-wfc8). Severity: MEDIUM. bootstrap 3.0.0 matches NuGet range >= 2.3.0, < 3.4.0. Upgrade to 3.4.0 or later. Package-version finding; application-level exploitability is not established.

### CVE-2015-9251: Cross-Site Scripting (XSS) in jquery
- **Category:** CVE
- **Severity:** optional
- **Story Points:** 1
- **Files:** WebApp-Storage-DotNet/packages.config:8

[CVE-2015-9251](https://github.com/advisories/GHSA-rmxg-73gg-4p98). Severity: MEDIUM. jQuery 1.10.2 matches NuGet range < 1.12.2. Upgrade to 1.12.2 or later; prefer a supported release covering all listed advisories. Package-version finding; vulnerable cross-domain AJAX behavior is not proven reachable.

## CWE Findings (Code-Level Vulnerabilities)

### CWE-606: Unchecked Input for Loop Condition
- **Category:** Code Quality
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:101, WebApp-Storage-DotNet/Controllers/HomeController.cs:102, WebApp-Storage-DotNet/Controllers/HomeController.cs:106, WebApp-Storage-DotNet/Controllers/HomeController.cs:109, WebApp-Storage-DotNet/Web.config:25

HomeController.UploadAsync uses attacker-selected Request.Files.Count as the loop bound without a per-request file-count/work cap. Each accepted multipart entry performs a sequential storage upload. With the initialized/configured container and an existing readable local source filename (the local-path bug), many small multipart entries can repeat the same source read and generate many unique blob writes, amplifying request CPU/I/O, storage transactions and occupied request lifetime. Web.config sets maxRequestLength=2100000000 and executionTimeout=12000000; these do not constrain file count. Upstream IIS/proxy limits may reduce input size; no bypass of those limits or quantified DoS is claimed.

### CWE-665: Improper Initialization
- **Category:** Code Quality
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:47, WebApp-Storage-DotNet/Controllers/HomeController.cs:65, WebApp-Storage-DotNet/Controllers/HomeController.cs:108, WebApp-Storage-DotNet/Controllers/HomeController.cs:158, WebApp-Storage-DotNet/App_Start/RouteConfig.cs:16

HomeController stores blobContainer in a static field but only initializes it inside the independently routed Index action. A direct POST to DeleteAll after application startup/recycle, before any Index request reaches line 65, dereferences null at GetBlobs; UploadAsync with a multipart file similarly dereferences it at line 108. RouteConfig permits these direct action routes and neither startup nor the actions initialize the resource. The exception is caught and returns Error, so the confirmed impact is request-level functionality failure due to initialization ordering, not a process crash, cross-account access, or sustained denial of service.

### CWE-732: Incorrect Permission Assignment for Critical Resource
- **Category:** Credentials & Secrets
- **Severity:** optional
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:44, WebApp-Storage-DotNet/Controllers/HomeController.cs:63, WebApp-Storage-DotNet/Controllers/HomeController.cs:127, WebApp-Storage-DotNet/Controllers/HomeController.cs:135, WebApp-Storage-DotNet/Controllers/HomeController.cs:153, WebApp-Storage-DotNet/Controllers/HomeController.cs:162, WebApp-Storage-DotNet/App_Start/FilterConfig.cs:10, WebApp-Storage-DotNet/App_Start/RouteConfig.cs:16

The application gives every reachable caller the controller's storage-account deletion capability: DeleteImage and DeleteAll are public POST actions with no authorization check, no controller-level authorization, and no global authorization filter. After Index initializes the configured container, an anonymous POST /Home/DeleteAll enumerates and deletes every block blob; DeleteImage permits individual deletion based on a supplied URI basename. Public viewing of gallery photos does not require public destructive access. This finding concerns gallery integrity, not a claim that intentional public photo viewing alone is insecure. External IIS/network authentication could restrict exposure, but no such protection is present in repository configuration. Primary weakness is missing authorization; reported under this requested permission category because the effective application permission grants destructive access to anonymous callers.

### CWE-778: Insufficient Logging
- **Category:** Credentials & Secrets
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:128, WebApp-Storage-DotNet/Controllers/HomeController.cs:136, WebApp-Storage-DotNet/Controllers/HomeController.cs:154, WebApp-Storage-DotNet/Controllers/HomeController.cs:162, WebApp-Storage-DotNet/Controllers/HomeController.cs:168

HomeController.DeleteImage and DeleteAll perform security-critical storage deletion without recording the requester, target objects, deletion result or operation identifier. Success redirects; exception paths only render message/stack trace in the response and do not persist an application audit event. Thus the anonymous destructive operations identified above leave no application-level audit trail. Hosting request logs and optional Azure diagnostic logging were not available and may provide partial external evidence; this finding does not claim those external logs are absent.

### CWE-22: Improper Limitation of a Pathname to a Restricted Directory ('Path Traversal')
- **Category:** File & Path Security
- **Severity:** optional
- **Story Points:** 8
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:63, WebApp-Storage-DotNet/Controllers/HomeController.cs:66, WebApp-Storage-DotNet/Controllers/HomeController.cs:101, WebApp-Storage-DotNet/Controllers/HomeController.cs:108, WebApp-Storage-DotNet/Controllers/HomeController.cs:109

HomeController.UploadAsync passes attacker-controlled multipart files[i].FileName directly to BlobClient.UploadAsync(string path), which opens that path on the server instead of reading the uploaded InputStream. After Index initializes the shared container, a crafted multipart filename naming a process-readable server file causes that file's contents to be copied into blob storage. Index lists blob URIs and creates new containers with PublicAccessType.Blob, exposing copied data when public access is permitted. No authentication or path confinement is present. Requires a configured writable storage account and a readable existing target. This and CWE-23/CWE-36 are three classifications of one root cause, not three independent defects.

### CWE-23: Relative Path Traversal
- **Category:** File & Path Security
- **Severity:** optional
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:101, WebApp-Storage-DotNet/Controllers/HomeController.cs:108, WebApp-Storage-DotNet/Controllers/HomeController.cs:109

HomeController.UploadAsync sends the unmodified multipart filename to the server-local path overload of BlobClient.UploadAsync. A crafted filename such as ../target.txt or ..\target.txt traverses relative to the server process working directory when the target exists and the process can read it. GetRandomBlobName only transforms the destination blob name; it does not sanitize the local source path. The resulting blob is discoverable through Index. Same root cause as CWE-22; exploitation depends on working-directory layout, storage configuration, and file permissions.

### CWE-36: Absolute Path Traversal
- **Category:** File & Path Security
- **Severity:** optional
- **Story Points:** 5
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:101, WebApp-Storage-DotNet/Controllers/HomeController.cs:108, WebApp-Storage-DotNet/Controllers/HomeController.cs:109

A manually crafted multipart filename such as C:\Windows\win.ini reaches BlobClient.UploadAsync(string path) unchanged in HomeController.UploadAsync. On the intended Windows host this selects an absolute server-local file rather than uploaded content, and copies a process-readable target to the configured blob container. There is no root/path allowlist. Same root cause as CWE-22; requires a successful Index initialization, storage access, and target read permission.

### CWE-79: Improper Neutralization of Input During Web Page Generation ('Cross-site Scripting')
- **Category:** Injection Attacks
- **Severity:** optional
- **Story Points:** 8
- **Files:** WebApp-Storage-DotNet/Views/Home/Index.cshtml:37, WebApp-Storage-DotNet/Views/Home/Index.cshtml:72, WebApp-Storage-DotNet/Views/Home/Index.cshtml:80, WebApp-Storage-DotNet/Views/Home/Index.cshtml:85

DisplayFilesToUpload concatenates File.name into markup and assigns that markup to FilesToUpload.innerHTML on the file input onchange event. On filesystems permitting angle brackets (for example Linux), an attacker-supplied file named <img src=x onerror=alert(1)>.png injects an image/event handler into the application's DOM when the victim selects that file. This is user-assisted DOM XSS: it requires the victim to obtain and select an attacker-named file and a platform/browser preserving that name; it is not an unauthenticated remote reflected/stored XSS claim. The injection occurs before the upload request, independently of the server upload bug.

### CWE-99: Improper Control of Resource Identifiers ('Resource Injection')
- **Category:** Injection Attacks
- **Severity:** potential
- **Story Points:** 3
- **Files:** WebApp-Storage-DotNet/Controllers/HomeController.cs:101, WebApp-Storage-DotNet/Controllers/HomeController.cs:108, WebApp-Storage-DotNet/Controllers/HomeController.cs:109

HomeController.UploadAsync lets attacker-controlled multipart FileName choose the source resource passed to BlobClient.UploadAsync(string path), a server-local file read. A crafted filename identifying an existing readable local file copies that resource into the gallery container instead of using the posted file bytes. Requires configured storage and initialized blobContainer. This is the same root cause classified as CWE-22/CWE-23/CWE-36 in the file/path artifact; it is not an additional independent exploit.
