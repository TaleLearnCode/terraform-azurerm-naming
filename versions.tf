# =============================================================================
# Module:  Azure Resource Naming Generator
# File:    versions.tf
# Purpose: Specifies the required Terraform version and provider versions.
# =============================================================================

terraform {
  required_version = "~> 1.6"

  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~> 2.4"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}