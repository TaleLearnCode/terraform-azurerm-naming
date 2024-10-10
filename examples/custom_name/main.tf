module "example" {
  source = "TaleLearnCode/regions/naming"
  version = "0.0.1-pre"
  custom_name = "myappdb001"
}

output "example_resource_name_output" {
  value = module.example_resource_name.resource_name
}