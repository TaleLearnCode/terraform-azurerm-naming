# Test variables - these can be overridden in individual test runs
variable "workload" {
  description = "The workload name for the resource"
  type        = string
  default     = "test"
}

variable "environment" {
  description = "The environment name"
  type        = string
  default     = null
}

variable "region" {
  description = "The Azure region"
  type        = string
  default     = null
}

variable "unique_length" {
  description = "Length of unique number"
  type        = number
  default     = 4
}

variable "unique_seed" {
  description = "Seed for unique number generation"
  type        = string
  default     = ""
}

variable "instance_number" {
  description = "Instance number"
  type        = number
  default     = 1
}
