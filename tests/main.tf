# Module for testing - provides the naming module to all tests
module "naming" {
  source = ".."

  # Default values - can be overridden by individual test runs
  workload        = var.workload
  environment     = var.environment
  region          = var.region
  unique_length   = var.unique_length
  unique_seed     = var.unique_seed
  instance_number = var.instance_number
}
