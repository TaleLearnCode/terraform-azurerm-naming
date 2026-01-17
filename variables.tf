# =============================================================================
# Module:  Azure Resource Naming Generator
# File:    variables.tf
# Purpose: Input variables for generating standardized names for Azure resources
#          based on workload, environment, region, unique suffix, and instance number.
# =============================================================================

variable "workload" {
  description = "The name of the workload, application, or project that the resource is a part of."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]{1,20}$", var.workload))
    error_message = "Workload must be 1-20 characters, lowercase alphanumeric with hyphens allowed."
  }
}

variable "environment" {
  description = "The environment name (e.g., prod, dev, qa, stage, test). If null, will not be included in the name."
  type        = string
  default     = null

  validation {
    condition     = var.environment == null || can(regex("^[a-z0-9]{1,10}$", var.environment))
    error_message = "Environment must be 1-10 characters, lowercase alphanumeric. Leave null to exclude."
  }
}

variable "region" {
  description = "The Azure region name or display name. If null, region lookup will be skipped and must be determined by the caller."
  type        = string
  default     = null
}

variable "unique_length" {
  description = "The length of the unique random number suffix. Must be between 1 and 4."
  type        = number
  default     = 4

  validation {
    condition     = var.unique_length >= 1 && var.unique_length <= 4
    error_message = "Unique length must be between 1 and 4."
  }
}

variable "unique_seed" {
  description = "The seed for the random unique number generator. If empty, a random seed will be used."
  type        = string
  default     = ""
}

variable "instance_number" {
  description = "The instance number or count for the resource. If 0, it will not be included in the name."
  type        = number
  default     = 0

  validation {
    condition     = var.instance_number >= 0 && var.instance_number <= 999
    error_message = "Instance number must be between 0 and 999."
  }
}