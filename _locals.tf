# ##############################################################################
# Locals: Resource Abbreviation Map
# ##############################################################################

locals {
  resource_abbr_map = {
    "app_configuration"      = "appcs"
    "cosmosdb_account_nosql" = "cosno",
    "key_vault"              = "kv"
    "resource_group"         = "rg"
    "servicebus_namespace"   = "sbns"
    "static_web_app"         = "stapp"
    "storage_account"        = "st"
  }
  resouce_type_regex = {
    "app_configuration"     = "^[a-zA-Z0-9_-]{5,50}$"
    "cosmosdb_account_nosql"= "^(?!.*--)(?!.*..)(?!.*.$)(?!.*-$)([a-z0-9]{3,44})$"
    "key_vault"             = "^([a-zA-Z][a-zA-Z0-9-]{1,22}[a-zA-Z0-9])$" # Should be include (?!.*-{2}.*), but Terraform does not support lookaheads
    "resource_group"        = "^(?!.*[\\.])[a-zA-Z0-9_\\.()-]{1,90}$"
    "servicebus_namespace"  = "^[a-zA-Z][a-zA-Z0-9-]{4,48}[a-zA-Z0-9]$"
    "static_web_app"        = "^[a-zA-Z0-9][a-zA-Z0-9-]{0,58}[a-zA-Z0-9]$"
    "storage_account"       = "^[a-z0-9]{3,24}$"
  }
}