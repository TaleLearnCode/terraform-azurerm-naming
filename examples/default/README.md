# Example: Standard Resource Naming

This module produces a formatted Azure resource name. This example shows the standard usage of the module.

## Example Usage

```hcl
module "example" {
  source = "TaleLearnCode/regions/naming"
  version = "0.0.1-pre"

  resource_type  = "key_vault"
  name_prefix    = "myapp"
  srv_comp_abbr  = "db"
  name_suffix    = "001"
  location       = "northcentralus"
  environment    = "prod"
}

output "example" {
  value = module.example.resource_name # kv-myappdb001-usnc-prod
}
```

You are specifying three values:

- **resource_type**: The type of resource being created.

- **name_prefix**: Optional prefix to apply to the generated name.

- **src_comp_abbr**: The abbreviation of the service component for which the resources are being created.

- **name_suffix**: Optional suffix to apply to the generated name.

- **location**: The Azure Region in which all resources will be created.

- **environment**: The environment within the resources are being deployed to. Valid values are 'dev', 'qa', 'e2e', and 'prod'.


>  Setting any of the following values will have no effect when the custom_name is set to anything but null: srv_comp_abbr, name_prefix, name_suffix, environment.

> By convention, the module lower cases supplied name segments when generated the resource name. This is not the case when supplying a **custom_name**. The module will use the same case as provided.

This will result in an Azure Key Vault named: `kv-myappdb001-usnc-prod`.