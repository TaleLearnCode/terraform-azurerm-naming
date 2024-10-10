# Azure Resource Naming Terraform Module

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md)

This Terraform module provides names for Azure resources compliant to the Microsoft Cloud Adoption Framework (CAF) naming standard.

## Providers

No providers.

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| Regions | TaleLearnCode/regions/azurerm | ~> .0.0.1-pre |

## Resources

No resources.

## Usage

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

For more detailed instructions on using this module: please refer to the appropriate example:

- [Default](examples/default/README.md)
- [Custom Name](examples/custom_name/README.md)

## Inputs

| Name          | Description                                                   | Type   | Default | Required |
| ------------- | ------------------------------------------------------------- | ------ | ------- | -------- |
| custom_name   | If set, the custom name to use instead of the generated name. | string | NULL    | no       |
| environment   | The environment where the resources are deployed to.          | string | N/A     | yes      |
| location      | The Azure Region in which all resources will be created       | string | N/A     | yes      |
| name_prefix   | Optional prefix to apply to the generated name.               | string | ""      | no       |
| name_suffix   | Optional suffix to apply to the generated name.               | string | ""      | no       |
| srv_comp_abbr | The abbreviation of the service or component for which the resources are being created for. | string | NULL    | no       |
| resource_type | The type of resource being created.                           | string | N/A     | yes      |

### Resource Types

The `resource_type` input is looking for one of the following values:

| resource_type  | Azure Resource Type  |
| -------------- | -------------------- |
| app_configuration      | Azure App Configuration       |
| cosmosdb_account_nosql | Azure Cosmos DB NoSQL account |
| key_vault              | Azure Key Vault               |
| resource_group         | Azure Resource Group          |
| servicebus_namespace   | Azure Service Bus namespace   |
| static_web_app         | Azure Static Web App          |
| storage_account        | Storage Account               |

## Outputs

| Name          | Description                      |
|---------------|----------------------------------|
| resource_name | The name of the target resource. |