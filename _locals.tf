# ##############################################################################
# Locals: Resource Abbreviation Map
# ##############################################################################

locals {
  resource_abbr_map = {
    "app_configuration"       = "appcs"
    "app_service_plan"        = "asp"
    "application_insights"    = "appi"
    "cosmosdb_account_nosql"  = "cosno",
    "function_app"            = "func"
    "key_vault"               = "kv"
    "log_analytics_workspace" = "log"
    "resource_group"          = "rg"
    "servicebus_namespace"    = "sbns"
    "static_web_app"          = "stapp"
    "storage_account"         = "st"
  }
  resouce_type_regex = {
    "app_configuration"       = "^[a-zA-Z0-9_-]{5,50}$"
    "app_service_plan"        = "^[a-zA-Z0-9-]{1,40}$"
    "application_insights"    = "^[^%&\\/]{1,260}$"
    "cosmosdb_account_nosql"  = "^(?!.*--)(?!.*..)(?!.*.$)(?!.*-$)([a-z0-9]{3,44})$"
    "function_app"            = "^[a-zA-Z0-9][a-zA-Z0-9-]{0,58}[a-zA-Z0-9]$"
    "key_vault"               = "^([a-zA-Z][a-zA-Z0-9-]{1,22}[a-zA-Z0-9])$" # Should be include (?!.*-{2}.*), but Terraform does not support lookaheads
    "log_analytics_workspace" = "^[a-zA-Z0-9-]{4,63}$"
    "resource_group"          = "^(?!.*[\\.])[a-zA-Z0-9_\\.()-]{1,90}$"
    "servicebus_namespace"    = "^[a-zA-Z][a-zA-Z0-9-]{4,48}[a-zA-Z0-9]$"
    "static_web_app"          = "^[a-zA-Z0-9][a-zA-Z0-9-]{0,58}[a-zA-Z0-9]$"
    "storage_account"         = "^[a-z0-9]{3,24}$"
  }
}