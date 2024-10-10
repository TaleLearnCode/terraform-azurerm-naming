locals {
  resource_abbr = lookup(local.resource_abbr_map, var.resource_type, "unknown")

  standard_name = lower(
    var.resource_type == "storage_account" ?
    "${local.resource_abbr}${var.name_prefix}${var.srv_comp_abbr}${var.name_suffix}${var.environment}${module.azure_regions.region.region_short}" :
    "${local.resource_abbr}-${var.name_prefix}${var.srv_comp_abbr}${var.name_suffix}-${var.environment}-${module.azure_regions.region.region_short}"
  )

  resource_name = coalesce(var.custom_name, local.standard_name)

  regex = lookup(local.resouce_type_regex, var.resource_type, "unknown")
 
}

# Removing validation for now; will add back in later
#resource "null_resource" "validate_name_format" {
#  count = can(regex(local.regex, local.resource_name)) ? 0 : 1
#
#  provisioner "local-exec" {
#    command = "echo 'Error: The concatenated name (${local.resource_name}) [${local.regex}] does not match the required format.' && exit 1"
#  }
#}