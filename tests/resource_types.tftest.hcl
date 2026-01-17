# Test resource-specific naming rules
run "storage_account_no_dashes" {
  command = apply

  variables {
    workload    = "storage"
    environment = "prod"
    region      = "eastus"
    unique_seed = "stg"
  }

  assert {
    condition     = output.storage_account.allows_dashes == false
    error_message = "Storage account should not allow dashes"
  }

  assert {
    condition     = !strcontains(output.storage_account.name, "-")
    error_message = "Storage account name should not contain dashes"
  }

  assert {
    condition     = length(output.storage_account.name) >= output.storage_account.min_length
    error_message = "Storage account name length should meet minimum requirement"
  }

  assert {
    condition     = length(output.storage_account.name) <= output.storage_account.max_length
    error_message = "Storage account name length should not exceed maximum"
  }
}

# Test container registry naming
run "container_registry_constraints" {
  command = apply

  variables {
    workload    = "app"
    environment = "dev"
    region      = "westus"
    unique_seed = "cr"
  }

  assert {
    condition     = output.container_registry.allows_dashes == false
    error_message = "Container registry should not allow dashes"
  }

  assert {
    condition     = !strcontains(output.container_registry.name, "-")
    error_message = "Container registry name should not contain dashes"
  }

  assert {
    condition     = output.container_registry.max_length == 50
    error_message = "Container registry max length should be 50"
  }
}

# Test web app naming (allows dashes)
run "web_app_naming_rules" {
  command = apply

  variables {
    workload    = "myapp"
    environment = "prod"
    region      = "eastus"
    unique_seed = "webapp"
  }

  assert {
    condition     = output.web_app.allows_dashes == true
    error_message = "Web app should allow dashes"
  }

  assert {
    condition     = startswith(output.web_app.name, "app-")
    error_message = "Web app name should start with 'app-' abbreviation"
  }

  assert {
    condition     = output.web_app.scope == "Global"
    error_message = "Web app scope should be Global"
  }
}

# Test virtual machine naming
run "virtual_machine_naming_rules" {
  command = apply

  variables {
    workload    = "server"
    environment = "prod"
    region      = "eastus"
    unique_seed = "vm"
  }

  assert {
    condition     = output.virtual_machine.allows_dashes == true
    error_message = "Virtual machine should allow dashes"
  }

  assert {
    condition     = startswith(output.virtual_machine.name, "vm-")
    error_message = "VM name should start with 'vm-' abbreviation"
  }

  assert {
    condition     = output.virtual_machine.max_length == 15
    error_message = "VM max length should be 15 characters"
  }

  assert {
    condition     = output.virtual_machine.scope == "Resource Group"
    error_message = "VM scope should be Resource Group"
  }
}

# Test key vault naming
run "key_vault_naming_rules" {
  command = apply

  variables {
    workload    = "sec"
    environment = "prod"
    region      = "eastus"
    unique_seed = "kv"
  }

  assert {
    condition     = output.key_vault.allows_dashes == true
    error_message = "Key vault should allow dashes"
  }

  assert {
    condition     = startswith(output.key_vault.name, "kv-")
    error_message = "Key vault name should start with 'kv-' abbreviation"
  }

  assert {
    condition     = output.key_vault.min_length == 3
    error_message = "Key vault min length should be 3"
  }

  assert {
    condition     = output.key_vault.max_length == 24
    error_message = "Key vault max length should be 24"
  }
}

# Test SQL server naming
run "sql_server_naming_rules" {
  command = apply

  variables {
    workload    = "data"
    environment = "prod"
    region      = "eastus"
    unique_seed = "sql"
  }

  assert {
    condition     = output.sql_server.allows_dashes == true
    error_message = "SQL server should allow dashes"
  }

  assert {
    condition     = startswith(output.sql_server.name, "sql-")
    error_message = "SQL server name should start with 'sql-' abbreviation"
  }

  assert {
    condition     = output.sql_server.scope == "Global"
    error_message = "SQL server scope should be Global"
  }
}

# Test networking resources
run "virtual_network_naming_rules" {
  command = apply

  variables {
    workload    = "core"
    environment = "prod"
    region      = "eastus"
    unique_seed = "vnet"
  }

  assert {
    condition     = output.virtual_network.allows_dashes == true
    error_message = "Virtual network should allow dashes"
  }

  assert {
    condition     = startswith(output.virtual_network.name, "vnet-")
    error_message = "VNET name should start with 'vnet-' abbreviation"
  }
}

# Test function app naming
run "function_app_naming_rules" {
  command = apply

  variables {
    workload    = "processing"
    environment = "dev"
    region      = "westus"
    unique_seed = "func"
  }

  assert {
    condition     = output.function_app.allows_dashes == true
    error_message = "Function app should allow dashes"
  }

  assert {
    condition     = startswith(output.function_app.name, "func-")
    error_message = "Function app name should start with 'func-' abbreviation"
  }

  assert {
    condition     = output.function_app.scope == "Global"
    error_message = "Function app scope should be Global"
  }
}
