# Demo: Standard Resource Naming

This module produces a formatted Azure resource name. This example shows the standard usage of the module.

## Example Usage

```hcl
module "example" {
  source = "TaleLearnCode/regions/naming"
  version = "0.0.1-pre"
  custom_name = "myappdb001"
}

output "example_resource_name_output" {
  value = module.example_resource_name.resource_name
}
```

You are specifying three values:

- **custom_name**: Custom name to use instead of the generated name.

>  Setting any of the following values will have no effect when the custom_name is set to anything but null: srv_comp_abbr, name_prefix, name_suffix, environment.

> By convention, the module lower cases supplied name segments when generated the resource name. This is not the case when supplying a **custom_name**. The module will use the same case as provided.

This will result in an Azure Key Vault named: `myappdb001`.