# #############################################################################
# Variables
# #############################################################################

variable "resource_type" {
  type        = string
  description = "The type of resource being created."
}

variable "location" {
  type        = string
  description = "The Azure Region in which all resources will be created."
}

variable "environment" {
  type        = string
  description = "The environment within the resources are being deployed to."
}

variable "name_prefix" {
  type        = string
  default     = ""
  description = "Optional prefix to apply to the generated name."
}

variable "name_suffix" {
  type        = string
  default     = ""
  description = "Optional suffix to apply to the generated name."
}

variable "srv_comp_abbr" {
  type        = string
  default     = ""
  description = "The abbreviation of the service component for which the resources are being created."
}

variable "custom_name" {
  type        = string
  default     = null
  description = "If set, custom name to use instead of the generated name"
}