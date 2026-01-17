# Azure Resource Naming Module - Default Example

This example demonstrates how to use the Azure Resource Naming module to generate standardized, consistent names for Azure resources across your infrastructure.

---

## Overview

The naming module automatically generates Azure-compliant resource names based on configurable parameters:
- **Workload**: The name of your application or project
- **Environment**: Deployment environment (dev, prod, staging, etc.)
- **Region**: Azure region where resources are deployed
- **Unique identifier**: Random suffix to ensure global uniqueness
- **Instance number**: When deploying multiple instances of the same resource type

---

## Usage Example

### Basic Configuration

```hcl
module "naming" {
  source  = "TaleLearnCode/naming/azurerm"
  version = "0.1.0"

  workload        = "myapp"
  environment     = "dev"
  region          = "eastus"
  unique_length   = 4
  unique_seed     = "example"
  instance_number = 1
}
```

### Using Generated Names

The module outputs naming conventions for all supported resource types. Access generated names using dot notation:

#### Example 1: Storage Account (no dashes allowed)
```hcl
resource "azurerm_storage_account" "example" {
  name                     = module.naming.storage_account.name
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}
```

The storage account name will be generated without dashes (e.g., `stmyappdev0001`).

#### Example 2: Virtual Network (dashes allowed)
```hcl
resource "azurerm_virtual_network" "example" {
  name                = module.naming.virtual_network.name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}
```

The virtual network name will include dashes for readability (e.g., `vnet-myapp-dev-001`).

#### Example 3: Key Vault with Unique Suffix
```hcl
resource "azurerm_key_vault" "example" {
  name                = module.naming.key_vault.name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  # ... additional configuration
}
```

The key vault name includes a unique random suffix to ensure global uniqueness (e.g., `kv-myapp-dev-5c4t`).

#### Example 4: Custom Resource Group Name with Components
```hcl
resource "azurerm_resource_group" "example" {
  name     = "rg-${module.naming.web_app.unique_name}-${module.naming.web_app.slug}"
  location = "East US"
}
```

This demonstrates combining different naming components manually (e.g., `rg-myapp-dev-5c4t-wa`).

---

## Module Inputs

| Input | Type | Default | Description |
|-------|------|---------|-------------|
| `workload` | string | — | **Required**. Application or project name (1-20 chars, lowercase alphanumeric + hyphens) |
| `environment` | string | `null` | Environment name like "dev", "prod", "staging" (1-10 chars, lowercase alphanumeric). Leave null to exclude from names. |
| `region` | string | `null` | Azure region name (e.g., "eastus", "westeurope"). Resolved to region code automatically. |
| `unique_length` | number | `4` | Length of random unique suffix (1-4 characters). Controls suffix length in generated names. |
| `unique_seed` | string | `""` | Seed for random number generator. Use same seed for consistent naming across deployments. Leave empty for random seed. |
| `instance_number` | number | `1` | Instance identifier for multiple deployments (0-999). Use 0 to exclude from names. |

---

## Naming Convention Format

The module generates names following this general pattern:
```
[resource-type-abbreviation]-[workload]-[environment]-[region]-[unique-id]-[instance]
```

Examples:
- Storage Account: `stmyappdev0001` (no dashes allowed)
- Virtual Network: `vnet-myapp-dev-eus-5c4t` (with dashes)
- Key Vault: `kv-myapp-dev-5c4t` (globally unique)
- Web App: `wa-myapp-dev-001` (with instance number)

---

## Practical Scenarios

### Scenario 1: Multi-Environment Deployment
Deploy the same workload across multiple environments using the same module configuration:

```hcl
locals {
  environments = {
    dev  = { workload = "myapp", environment = "dev" }
    prod = { workload = "myapp", environment = "prod" }
  }
}

module "naming" {
  for_each = local.environments
  source  = "TaleLearnCode/naming/azurerm"
  version = "0.1.0"

  workload        = each.value.workload
  environment     = each.value.environment
  region          = "eastus"
  unique_seed     = "myapp"  # Keep consistent across environments
}
```

### Scenario 2: Scaling with Instance Numbers
Deploy multiple instances with sequential instance numbers:

```hcl
module "naming" {
  for_each = toset([1, 2, 3])
  source  = "TaleLearnCode/naming/azurerm"
  version = "0.1.0"

  workload        = "myapp"
  environment     = "prod"
  region          = "eastus"
  instance_number = tonumber(each.key)
}

# Results in: wa-myapp-prod-001, wa-myapp-prod-002, wa-myapp-prod-003
```

### Scenario 3: Consistent Naming with Deterministic Seed
Ensure consistent names across different Terraform runs by using a deterministic seed:

```hcl
module "naming" {
  source  = "TaleLearnCode/naming/azurerm"
  version = "0.1.0"

  workload        = "myapp"
  environment     = "dev"
  region          = "eastus"
  unique_seed     = "production-seed-v1"  # Same seed = same unique suffix
}
```

---

## Output Structure

All naming outputs follow a consistent structure:

```hcl
output "web_app" {
  value = {
    name          = "wa-myapp-dev-5c4t"
    unique_name   = "wa-myapp-dev-5c4t"
    slug          = "wa"
    allows_dashes = true
    min_length    = 2
    max_length    = 60
    scope         = "Global"
    regex         = "^[a-z0-9][a-z0-9-]*[a-z0-9]$"
  }
}
```

Use the `regex` pattern to validate resource names conform to Azure requirements in your own infrastructure code.

---

## Best Practices

1. **Use Consistent Workload Names**: Keep workload names consistent across your organization
2. **Leverage Unique Seeds**: Use deterministic seeds (`unique_seed`) to ensure consistent naming across environments
3. **Respect Resource Constraints**: Always validate generated names against Azure's constraints using the provided metadata
4. **Plan Instance Numbers**: Use meaningful instance numbers when scaling to multiple instances
5. **Environment Tagging**: Combine naming with Azure resource tags for comprehensive resource organization

---

## Running the Example

1. Set your Azure subscription:
   ```bash
   export AZURE_SUBSCRIPTION_ID="your-subscription-id"
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Review the generated names:
   ```bash
   terraform plan
   ```

4. Deploy the example resources:
   ```bash
   terraform apply
   ```

5. View the generated names:
   ```bash
   terraform output generated_names
   terraform output naming_metadata
   ```

---

## Notes

- The module resolves region names and display names to their short codes (e.g., "eastus" → "eus", "West Europe" → "weu")
- Random unique suffixes are deterministic when `unique_seed` is provided and consistent across runs
- Some resources (storage accounts) don't allow dashes; the module automatically handles this
- Always review the validation regex and constraints provided by the module for each resource type
