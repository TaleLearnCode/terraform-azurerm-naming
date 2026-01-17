# Examples

This directory contains example configurations demonstrating how to use the Azure Resource Naming module.

---

## Available Examples

### [Default](default/)

**Basic naming module usage with multiple resource types**

Demonstrates the core functionality of the Azure Resource Naming module with:
- Module configuration with workload, environment, region, and uniqueness settings
- Generating names for compute resources (Web App, Function App, Virtual Machine)
- Generating names for networking resources (Virtual Network, Subnet, Network Security Group)
- Generating names for storage resources (Storage Account)
- Generating names for security resources (Key Vault)
- Accessing naming metadata and validation rules
- Example resource deployments using generated names

**Key Features Demonstrated:**
- Basic module invocation with all configuration options
- Usage of generated names with Azure resources
- Accessing output metadata for validation and compliance
- Deterministic naming with fixed seeds for reproducibility

---

## General Example Guidelines

### Running Examples

All examples follow this standard workflow:

```bash
# Navigate to example directory
cd examples/<example-name>

# Initialize Terraform (downloads providers and modules)
terraform init

# Review planned changes
terraform plan

# Apply configuration
terraform apply

# View outputs
terraform output

# Destroy resources when done
terraform destroy
```

### Customizing Examples

Each example can be customized by modifying the module variables:

```hcl
module "naming" {
  source = "../../"

  # Customize these values
  workload        = "myapp"      # Change your application name
  environment     = "dev"        # Change environment (dev, prod, staging)
  region          = "eastus"     # Change Azure region
  unique_length   = 4            # Adjust unique suffix length (1-4)
  unique_seed     = "example"    # Use a deterministic seed
  instance_number = 1            # Set instance number (0 to exclude)
}
```

### Prerequisites

To run any example, you need:

1. **Terraform** (~> 1.6) - [Download](https://www.terraform.io/downloads.html)
2. **Azure Subscription** - [Create a free account](https://azure.microsoft.com/en-us/free/)
3. **Azure CLI** (optional) - For authentication
   ```bash
   # Login to Azure
   az login
   
   # Set subscription
   az account set --subscription "your-subscription-id"
   ```

4. **Environment Variable** (for examples that deploy resources):
   ```powershell
   # PowerShell
   $env:AZURE_SUBSCRIPTION_ID = "your-subscription-id"
   
   # Bash
   export AZURE_SUBSCRIPTION_ID="your-subscription-id"
   ```

### Understanding Outputs

After running `terraform plan` or `terraform apply`, you can view the generated names:

```bash
# View all outputs
terraform output

# View specific output
terraform output generated_names
terraform output naming_metadata

# Output in JSON format
terraform output -json
```

---

## Contributing Examples

To contribute new examples:

1. Create a new directory under `examples/`
2. Add `main.tf`, `variables.tf`, and `versions.tf`
3. Create a comprehensive `README.md` documenting the example
4. Ensure the example demonstrates a unique use case or scenario
5. Test with `terraform plan` and `terraform init`

## Support

For issues or questions:
- Check the [main README](../README.md) for module documentation
- Review [Azure Naming Conventions](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging)
- Consult the [Terraform Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
