# WebApp-Storage-DotNet

## Summary

| Metric | Value |
|--------|-------|
| Total Issues | 13 |
| Mandatory Blockers | 7 |
| Potential Issues | 2 |

## Component Information

| Property | Value |
|----------|-------|
| Language | C# |
| Frameworks | .NETFramework,Version=v4.8 |
| Build tools | MSBuild |

## Cloud Readiness Issues

| Issue Name | Criticality | Story Points | Occurrences |
|------------|-------------|--------------|-------------|
| Static content detected | Optional | 3 | [1](#Static_content_detected) |
| Connection strings without configuration builders detected | Optional | 3 | [1](#Connection_strings_without_configuration_builders_detected) |

### Issue Details

<details id="Static_content_detected">
<summary><b>Static content detected</b> — affected files</summary>

- `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj`

</details>

<details id="Connection_strings_without_configuration_builders_detected">
<summary><b>Connection strings without configuration builders detected</b> — affected files</summary>

- `WebApp-Storage-DotNet/Web.config`

</details>

## DotNET Upgrade Issues [View Details](scenarios/dotnet-version-upgrade/assessment.md)

| Issue Category | Criticality | Story Points | Occurrences |
|----------------|-------------|--------------|-------------|
| NuGet package functionality is included with framework reference | Mandatory | 1 | [11](#NuGet_package_functionality_is_included_with_framework_reference) |
| Manual redirect conflicts with auto-generated version | Mandatory | 1 | [7](#Manual_redirect_conflicts_with_auto-generated_version) |
| NuGet package is incompatible | Mandatory | 1 | [5](#NuGet_package_is_incompatible) |
| Project file needs to be converted to SDK-style | Mandatory | 1 | [1](#Project_file_needs_to_be_converted_to_SDK-style) |
| Project's target framework(s) needs to be changed | Mandatory | 1 | [1](#Project_s_target_framework_s_needs_to_be_changed) |
| System.Web.Optimization bundling and minification is not supported in .NET Core and should be replaced with actual html tags pointing to content files | Mandatory | 1 | [1](#System_Web_Optimization_bundling_and_minification_is_not_supported_in_NET_Core_and_should_be_replaced_with_actual_html_tags_pointing_to_content_files) |
| Convert application initialization code from Global.asax.cs to .NET Core and clean up Global.asax.cs | Mandatory | 1 | [1](#Convert_application_initialization_code_from_Global_asax_cs_to_NET_Core_and_clean_up_Global_asax_cs) |
| NuGet package upgrade is recommended | Potential | 1 | [8](#NuGet_package_upgrade_is_recommended) |
| Binding redirect forces version downgrade | Potential | 1 | [7](#Binding_redirect_forces_version_downgrade) |
| NuGet package contains security vulnerability | Optional | 1 | [6](#NuGet_package_contains_security_vulnerability) |
| NuGet package is deprecated | Optional | 1 | [3](#NuGet_package_is_deprecated) |

### Issue Details

<details id="NuGet_package_functionality_is_included_with_framework_reference">
<summary><b>NuGet package functionality is included with framework reference</b> — affected files</summary>

- `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj`

</details>

<details id="Manual_redirect_conflicts_with_auto-generated_version">
<summary><b>Manual redirect conflicts with auto-generated version</b> — affected files</summary>

- `WebApp-Storage-DotNet/Web.config`

</details>

<details id="NuGet_package_is_incompatible">
<summary><b>NuGet package is incompatible</b> — affected files</summary>

- `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj`

</details>

<details id="Project_file_needs_to_be_converted_to_SDK-style">
<summary><b>Project file needs to be converted to SDK-style</b> — affected files</summary>

- `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj`

</details>

<details id="Project_s_target_framework_s_needs_to_be_changed">
<summary><b>Project's target framework(s) needs to be changed</b> — affected files</summary>

- `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj`

</details>

<details id="System_Web_Optimization_bundling_and_minification_is_not_supported_in_NET_Core_and_should_be_replaced_with_actual_html_tags_pointing_to_content_files">
<summary><b>System.Web.Optimization bundling and minification is not supported in .NET Core and should be replaced with actual html tags pointing to content files</b> — affected files</summary>

- `WebApp-Storage-DotNet/Views/Shared/_Layout.cshtml`

</details>

<details id="Convert_application_initialization_code_from_Global_asax_cs_to_NET_Core_and_clean_up_Global_asax_cs">
<summary><b>Convert application initialization code from Global.asax.cs to .NET Core and clean up Global.asax.cs</b> — affected files</summary>

- `WebApp-Storage-DotNet/Global.asax.cs`

</details>

<details id="NuGet_package_upgrade_is_recommended">
<summary><b>NuGet package upgrade is recommended</b> — affected files</summary>

- `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj`

</details>

<details id="Binding_redirect_forces_version_downgrade">
<summary><b>Binding redirect forces version downgrade</b> — affected files</summary>

- `WebApp-Storage-DotNet/Web.config`

</details>

<details id="NuGet_package_contains_security_vulnerability">
<summary><b>NuGet package contains security vulnerability</b> — affected files</summary>

- `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj`

</details>

<details id="NuGet_package_is_deprecated">
<summary><b>NuGet package is deprecated</b> — affected files</summary>

- `WebApp-Storage-DotNet/WebApp-Storage-DotNet.csproj`

</details>

---

## Codebase Insights

> **Note:** These documents are generated by AI and may contain inaccuracies or incomplete information. Please review carefully.

1. **[Architecture Diagram](facts/architecture-diagram.md)** — Understand the big picture: system layers and component relationships
2. **[Dependency Map](facts/dependency-map.md)** — Know what the project depends on and where the risks are
3. **[API & Service Contracts](facts/api-service-contracts.md)** — See how services communicate and what contracts they expose
4. **[Data Architecture](facts/data-architecture.md)** — Explore data models, storage, and data flow patterns
5. **[Configuration Inventory](facts/configuration-inventory.md)** — Review how the application is configured across environments
6. **[Business Workflows](facts/business-workflows.md)** — Trace end-to-end business processes and domain logic

[Share feedback](https://aka.ms/ghcp-appmod/feedback)
