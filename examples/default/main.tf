variable "subscription_id" {
  description = "The Azure subscription ID to deploy resources into."
  type        = string
}

terraform {
  required_version = "~> 1.6"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}

# Use the naming module to generate standardized names
module "naming" {
  source = "../.."

  workload        = "myapp"
  environment     = "dev"
  region          = "eastus"
  unique_length   = 4
  unique_seed     = "example"
  instance_number = 1
}

# Example: Create a resource group with generated name
resource "azurerm_resource_group" "example" {
  name     = "rg-${module.naming.web_app.unique_name}-${module.naming.web_app.slug}"
  location = "East US"
}

# Example: Create a storage account (no dashes allowed)
resource "azurerm_storage_account" "example" {
  name                     = module.naming.storage_account.name
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

# Example: Create a virtual network
resource "azurerm_virtual_network" "example" {
  name                = module.naming.virtual_network.name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# Example: Create a subnet
resource "azurerm_subnet" "example" {
  name                 = module.naming.subnet.name
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Example: Create a network security group
resource "azurerm_network_security_group" "example" {
  name                = module.naming.network_security_group.name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Example: Create a Key Vault
resource "azurerm_key_vault" "example" {
  name                = module.naming.key_vault.name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "List",
      "Create",
      "Delete",
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
    ]
  }
}

# Data source to get current Azure context
data "azurerm_client_config" "current" {}

# Output examples showing what names were generated
output "generated_names" {
  description = "Examples of generated resource names"
  value = {
    web_app                = module.naming.web_app.name
    storage_account        = module.naming.storage_account.name
    virtual_network        = module.naming.virtual_network.name
    subnet                 = module.naming.subnet.name
    network_security_group = module.naming.network_security_group.name
    key_vault              = module.naming.key_vault.name
  }
}

# Output naming metadata for different resource types
output "naming_metadata" {
  description = "Complete naming metadata including validation rules"
  value = {
    web_app = {
      name          = module.naming.web_app.name
      slug          = module.naming.web_app.slug
      allows_dashes = module.naming.web_app.allows_dashes
      min_length    = module.naming.web_app.min_length
      max_length    = module.naming.web_app.max_length
      scope         = module.naming.web_app.scope
      regex         = module.naming.web_app.regex
    }
    storage_account = {
      name          = module.naming.storage_account.name
      slug          = module.naming.storage_account.slug
      allows_dashes = module.naming.storage_account.allows_dashes
      min_length    = module.naming.storage_account.min_length
      max_length    = module.naming.storage_account.max_length
      scope         = module.naming.storage_account.scope
      regex         = module.naming.storage_account.regex
    }
  }
}