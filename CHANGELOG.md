# Changelog

All notable changes to this Terraform module will be documented in this file.

## [0.1.0] - 2026-01-17

### Added

- Initial release of Azure Resource Naming Module
- Support for 60+ Azure resource types with CAF naming conventions
- Automatic unique identifier generation with configurable random seed
- Region resolution using Azure Verified Module (avm-utl-regions)
- Comprehensive output metadata including:
  - Generated resource names
  - Resource-specific naming rules (min/max length, regex patterns)
  - Scope information (Global, Resource Group, etc.)
  - Character restriction indicators (allows_dashes)
- Input variables for workload, environment, region, and instance identification
- Module documentation following Terraform Registry standards
- Examples demonstrating basic and advanced usage

## [0.0.8-pre] - 2024-10-25

### Added
- Ability to generate names for Public IP Addresses.

## [0.0.7-pre] - 2024-10-25

### Added
- Ability to genrate names for API Management and Network Security Groups.

## [0.0.6-pre] - 2024-10-12

### Added
- Ability to generate names for App Service Plans.

## [0.0.5-pre]

### Added
- Ability to generate names for Azure Function Apps.

## [0.0.4-pre]

### Added
- Ability to generate names for Application Insights.

## [0.0.3-pre]

### Added
- Ability to generate names for Log Analytics Workspaces.

## [0.0.2-pre]

### Updated
- Corrected module reference issues.

## [0.0.1-pre] - 2024-10-09

### Added

- Initial release of the module