# Azure Resource Naming Module

[![Terraform](https://img.shields.io/badge/Terraform-~%3E%201.6-blue.svg)](https://www.terraform.io/downloads.html)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

This Terraform module generates standardized, compliant names for Azure resources following Microsoft Azure naming conventions and constraints. It simplifies resource naming by automatically generating names based on workload, environment, region, and uniqueness requirements.

## Features

- **50+ Resource Types Supported**: Generates names for Azure compute, networking, storage, databases, security, analytics, and AI/ML resources
- **Automatic Constraint Compliance**: Respects Azure's naming rules for each resource type, including character limits, allowed characters, and scope of uniqueness.
- **Deterministic Naming**: Use seeds to ensure consistent naming across deployments
- **Complete Validation Metadata**: Each generated name includes validation patterns, length constraints, and scope information
- **Region Code Resolution**: Automatically converts region names and display names to standard region codes
- **Multi-Instance Support**: Generate sequential names for scaled deployments with instance numbers
- **No External Dependencies**: Only uses Terraform built-in functions and the random provider

## Supported Resource Types

The module generates naming conventions for **59+ Azure resource types** across these categories:

### Compute
- Virtual Machines (`vm`)
- App Services / Web Apps (`app`, `wa`)
- Azure Functions (`func`)
- Container Registries (`cr`)
- Azure Kubernetes Service (`aks`)
- Container Apps (`ca`)
- Virtual Machine Scale Sets (`vmss`)
- Availability Sets (`avail`)
- Static Web Apps (`stapp`)
- App Service Plans (`asp`)

### Networking
- Virtual Networks (`vnet`)
- Subnets (`snet`)
- Network Interfaces (`nic`)
- Network Security Groups (`nsg`)
- Public IP Addresses (`pip`)
- Load Balancers (`lb`)
- Application Gateways (`agw`)
- Azure Firewalls (`afw`)
- Firewall Policies (`afwp`)
- CDN Profiles (`cdnp`)

### Storage & Databases
- Storage Accounts (`st`)
- Data Lake Storage (`sss`)
- Azure Cosmos DB (`cosmos`)
- SQL Server (`sql`)
- SQL Database (`sqldb`)
- MySQL (`mysql`)
- PostgreSQL (`psql`)
- Azure Cache for Redis (`redis`)

### Security & Management
- Key Vaults (`kv`)
- Managed Identities (`id`)
- Automation Accounts (`aa`)
- Log Analytics Workspaces (`log`)
- Application Insights (`appi`)

### Integration & Messaging
- API Management (`apim`)
- Service Bus Namespaces (`sbns`)
- Event Hub Namespaces (`evhns`)
- Event Hubs (`evh`)
- Event Grid Domains (`evgd`)
- Logic Apps (`logic`)
- IoT Hubs (`iot`)

### AI & Machine Learning
- Azure AI Search (`srch`)
- Azure AI Services (`ais`)
- AI Foundry Accounts (`aif`)
- AI Foundry Projects (`proj`)
- AI Foundry Hubs (`hub`)
- Machine Learning Workspaces (`mlw`)
- Azure OpenAI (`oai`)
- Bot Service (`bot`)
- Computer Vision (`cv`)
- Content Moderator (`cm`)
- Document Intelligence (`di`)
- Language Service (`lang`)

### Analytics & Data
- Data Factories (`adf`)
- Databricks Workspaces (`dbw`)
- Data Explorer Clusters (`dec`)
- Data Transformations (`dt`)

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.6 |
| azapi | ~> 2.4 |
| random | ~> 3.6 |

## Usage

### Basic Example

```hcl
module "naming" {
  source  = "TaleLearnCode/naming/azurerm"
  version = "0.1.0"

  workload        = "myapp"
  environment     = "dev"
  region          = "eastus"
  unique_length   = 4
  unique_seed     = "prod"
  instance_number = 1
}

# Use generated names in your resources
resource "azurerm_storage_account" "example" {
  name                     = module.naming.storage_account.name
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_virtual_network" "example" {
  name                = module.naming.virtual_network.name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_key_vault" "example" {
  name                = module.naming.key_vault.name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| workload | The name of the workload, application, or project. Must be 1-20 characters, lowercase alphanumeric with hyphens allowed. | `string` | — | yes |
| environment | The environment name (e.g., prod, dev, qa, stage, test). Leave null to exclude from generated names. Must be 1-10 characters, lowercase alphanumeric. | `string` | `null` | no |
| region | The Azure region name or display name (e.g., "eastus", "West Europe"). Automatically resolves to region code. Leave null to skip region code resolution. | `string` | `null` | no |
| unique_length | The length of the random unique suffix (1-4 characters). Controls how many random digits are appended to names. | `number` | `4` | no |
| unique_seed | The seed for the random unique number generator. When set, ensures deterministic naming across runs. Leave empty for random seed. | `string` | `""` | no |
| instance_number | The instance number for scaled deployments (0-999). Use 0 to exclude the instance number from names. Formatted with leading zeros. | `number` | `1` | no |

## Outputs

The module exports naming conventions for all 59+ supported resource types. Each output follows this structure:

```hcl
{
  name          = "generated-name-with-conventions"
  unique_name   = "generated-name-with-unique-suffix"
  slug          = "abbreviation"
  allows_dashes = true/false
  min_length    = 2
  max_length    = 64
  scope         = "Global|Resource Group|Subscription"
  regex         = "validation pattern"
}
```

### Common Outputs

- `app_service` - Azure App Service
- `container_registry` - Azure Container Registry
- `key_vault` - Azure Key Vault
- `kubernetes_cluster` - Azure Kubernetes Service
- `log_analytics` - Log Analytics Workspace
- `network_security_group` - Network Security Group
- `storage_account` - Storage Account
- `virtual_network` - Virtual Network
- `web_app` - Web App (App Service)

See the [outputs.tf](outputs.tf) file for the complete list of all 59+ resource types.

## Resource Type Output Structure

Each resource type output provides comprehensive metadata for validation:

```hcl
output "storage_account" {
  description = "Naming convention for Azure Storage Accounts"
  value = {
    name          = "stmyappdev0001"           # Generated name
    unique_name   = "stmyappdev5c4t"           # With unique suffix
    allows_dashes = false                       # Storage accounts don't allow dashes
    slug          = "st"                        # Resource type abbreviation
    min_length    = 3                           # Minimum name length
    max_length    = 24                          # Maximum name length
    scope         = "Global"                    # Uniqueness scope
    regex         = "^[a-z0-9]*$"              # Validation pattern
  }
}

output "virtual_network" {
  description = "Naming convention for Virtual Networks"
  value = {
    name          = "vnet-myapp-dev-eus-0001"
    unique_name   = "vnet-myapp-dev-eus-5c4t"
    allows_dashes = true
    slug          = "vnet"
    min_length    = 2
    max_length    = 64
    scope         = "Resource Group"
    regex         = "^[a-zA-Z0-9-_]*$"
  }
}
```

## Naming Convention Format

Generated names follow this pattern:

```
[abbreviation]-[workload]-[environment]-[region-code]-[unique-id]-[instance]
```

### Examples

With inputs `workload="myapp"`, `environment="dev"`, `region="eastus"`, `unique_seed="prod"`, `instance_number=1`:

- **Storage Account** (no dashes): `stmyappdev0001`
- **Virtual Network**: `vnet-myapp-dev-eus-5c4t`
- **Key Vault**: `kv-myapp-dev-5c4t`
- **Web App**: `wa-myapp-dev-001`
- **App Service Plan**: `asp-myapp-dev-001`
- **Kubernetes Cluster**: `aks-myapp-dev-eus-001`

## Advanced Examples

### Multi-Environment Deployment

```hcl
locals {
  environments = {
    dev  = { env = "dev", region = "eastus" }
    prod = { env = "prod", region = "westus" }
  }
}

module "naming" {
  for_each = local.environments
  source   = "../../"

  workload        = "myapp"
  environment     = each.value.env
  region          = each.value.region
  unique_seed     = "myapp"  # Consistent across environments
  instance_number = 1
}

# Results in consistent naming across environments:
# Dev:  stmyappdev0001, vnet-myapp-dev-eus-5c4t
# Prod: stmyappprod0001, vnet-myapp-prod-wus-5c4t
```

### Scaled Deployment with Instance Numbers

```hcl
module "naming" {
  for_each = toset([1, 2, 3])
  source   = "../../"

  workload        = "myapp"
  environment     = "prod"
  region          = "eastus"
  unique_seed     = "scale-test"
  instance_number = tonumber(each.key)
}

# Results in sequential names:
# wa-myapp-prod-eus-001
# wa-myapp-prod-eus-002
# wa-myapp-prod-eus-003
```

### Deterministic Naming with Fixed Seed

```hcl
module "naming" {
  source = "../../"

  workload        = "myapp"
  environment     = "prod"
  region          = "eastus"
  unique_seed     = "v1-production"  # Same seed = same unique suffix
  unique_length   = 4
}

# Always generates consistent names across multiple runs:
# storage_account: stmyappprod7c8a
# virtual_network: vnet-myapp-prod-eus-7c8a
```

## Module Behavior

### Region Code Resolution
The module automatically converts Azure region names and display names to standard region codes:
- "eastus" → "eus"
- "West Europe" → "weu"
- "Southeast Asia" → "sea"
- And many more...

### Unique Suffix Generation
- If `unique_seed` is provided, the random suffix is deterministic and consistent across runs.
- If `unique_seed` is empty, a random suffix is generated.
- The suffix length is controlled by `unique_length` (1-4 characters)

### Instance Number Formatting
- Instance numbers are formatted with leading zeros.
- Example: instance_number=1 becomes "001", instance_number=25 becomes "025"
- Set instance_number=0 to exclude from generated names

### Character Constraints
- Each resource type respects Azure's naming constraints.
- Names are automatically adjusted to respect the "allows_dashes" setting.
- Validation regex patterns are provided in each output for reference

## Real-World Use Cases

### 1. Infrastructure Standardization
Enforce consistent naming across your organization by centralizing resource naming logic:

```hcl
module "naming" {
  source = "git::https://github.com/yourorg/terraform-azurerm-naming.git"

  workload    = var.application_name
  environment = var.environment
  region      = var.location
  unique_seed = "${var.organization}-${var.application_name}"
}
```

### 2. Compliance and Auditing
Use the module to maintain naming compliance with regulatory requirements:

```hcl
# All resources follow the same naming convention, making audits easier
resource "azurerm_resource_group" "main" {
  name     = "rg-${module.naming.web_app.unique_name}"
  location = var.location
}

resource "azurerm_storage_account" "logs" {
  name = module.naming.storage_account.name  # Auto-validated for compliance
  # ...
}
```

### 3. Multi-Tenant Deployments
Generate unique names for each tenant while maintaining the same structure:

```hcl
module "naming" {
  for_each = var.tenants
  source   = "../../"

  workload        = each.value.name
  environment     = var.environment
  region          = var.location
  unique_seed     = "${var.tenant_prefix}-${each.key}"
}
```

## Best Practices

1. **Use Consistent Seeds**: Always use deterministic seeds in production to ensure consistent naming.
2. **Leverage Workload Names**: Keep workload names short (max 20 chars) and meaningful
3. **Include Environment**: Set environment values (dev, prod, staging) for precise resource classification.
4. **Validate Against Regex**: Use the provided regex patterns to validate names in your own infrastructure code.
5. **Plan for Scaling**: Consider how instance numbers will scale your deployments.
6. **Document Your Convention**: Share naming outputs with your team for consistency.

## Validation and Constraints

The module provides complete validation metadata for each resource type:

- **min_length**: Minimum number of characters allowed
- **max_length**: Maximum number of characters allowed
- **allows_dashes**: Whether hyphens are permitted
- **scope**: Whether names must be unique globally, at subscription, or resource group level
- **regex**: Validation pattern that generated names conform to

Use these constraints to validate that generated names meet Azure's requirements before deployment.

## Testing

The module includes comprehensive test suites validating naming conventions:

```bash
# Run all tests
terraform test

# Review test results
terraform test -verbose
```

See the [tests/](tests/) directory for test configurations covering:
- Default naming generation
- Validation metadata accuracy
- Resource type coverage
- Edge cases and special scenarios

## Examples

Refer to the [examples/](examples/) directory for complete working examples:

- **[default/](examples/default/)**: Basic usage with multiple resource types
- Demonstrates the configuration of the module
- Shows how to use generated names with real Azure resources
- Includes outputs for viewing generated names

## License

This module is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit issues and enhancement requests.

---

## References

- [Cloud Adoption Framework - Resource Naming](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)
- [Cloud Adoption Framework - Resource Abbreviations](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations)
- [Azure Resource Naming Rules](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules)
- [Azure Verified Module - Regions](https://registry.terraform.io/modules/Azure/avm-utl-regions/azurerm)

