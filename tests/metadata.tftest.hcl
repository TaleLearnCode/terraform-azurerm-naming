# Test metadata output structure for all resource types
run "output_metadata_structure" {
  command = apply

  variables {
    workload = "test"
  }

  # Test AI + ML outputs
  assert {
    condition     = output.ai_search.slug == "srch"
    error_message = "AI Search slug should be 'srch'"
  }

  assert {
    condition     = output.machine_learning_workspace.slug == "mlw"
    error_message = "ML Workspace slug should be 'mlw'"
  }

  # Test Compute outputs
  assert {
    condition     = output.virtual_machine.slug == "vm"
    error_message = "VM slug should be 'vm'"
  }

  assert {
    condition     = output.web_app.slug == "app"
    error_message = "Web app slug should be 'app'"
  }

  assert {
    condition     = output.function_app.slug == "func"
    error_message = "Function app slug should be 'func'"
  }

  # Test Container outputs
  assert {
    condition     = output.aks_cluster.slug == "aks"
    error_message = "AKS slug should be 'aks'"
  }

  assert {
    condition     = output.container_registry.slug == "cr"
    error_message = "Container registry slug should be 'cr'"
  }

  # Test Database outputs
  assert {
    condition     = output.sql_server.slug == "sql"
    error_message = "SQL server slug should be 'sql'"
  }

  assert {
    condition     = output.cosmos_db_sql.slug == "cosmos"
    error_message = "Cosmos DB slug should be 'cosmos'"
  }

  assert {
    condition     = output.cache_redis.slug == "redis"
    error_message = "Redis slug should be 'redis'"
  }

  # Test Networking outputs
  assert {
    condition     = output.virtual_network.slug == "vnet"
    error_message = "VNET slug should be 'vnet'"
  }

  assert {
    condition     = output.subnet.slug == "snet"
    error_message = "Subnet slug should be 'snet'"
  }

  assert {
    condition     = output.network_security_group.slug == "nsg"
    error_message = "NSG slug should be 'nsg'"
  }

  assert {
    condition     = output.public_ip.slug == "pip"
    error_message = "Public IP slug should be 'pip'"
  }

  # Test Security outputs
  assert {
    condition     = output.key_vault.slug == "kv"
    error_message = "Key Vault slug should be 'kv'"
  }

  assert {
    condition     = output.managed_identity.slug == "id"
    error_message = "Managed Identity slug should be 'id'"
  }

  # Test Storage outputs
  assert {
    condition     = output.storage_account.slug == "st"
    error_message = "Storage account slug should be 'st'"
  }
}

# Test metadata fields exist and are valid
run "metadata_fields_completeness" {
  command = apply

  variables {
    workload = "test"
  }

  assert {
    condition     = output.web_app.name != ""
    error_message = "web_app should have name output"
  }

  assert {
    condition     = output.web_app.unique_name != ""
    error_message = "web_app should have unique_name output"
  }

  assert {
    condition     = output.web_app.allows_dashes != null
    error_message = "web_app should have allows_dashes output"
  }

  assert {
    condition     = output.web_app.slug != ""
    error_message = "web_app should have slug output"
  }

  assert {
    condition     = output.web_app.min_length > 0
    error_message = "web_app should have min_length output"
  }

  assert {
    condition     = output.web_app.max_length > 0
    error_message = "web_app should have max_length output"
  }

  assert {
    condition     = output.web_app.scope != ""
    error_message = "web_app should have scope output"
  }

  assert {
    condition     = output.web_app.regex != ""
    error_message = "web_app should have regex output"
  }
}

# Test name length constraints
run "name_length_constraints" {
  command = apply

  variables {
    workload = "test"
  }

  assert {
    condition     = length(output.web_app.name) >= output.web_app.min_length
    error_message = "web_app name should meet minimum length requirement"
  }

  assert {
    condition     = length(output.web_app.name) <= output.web_app.max_length
    error_message = "web_app name should not exceed maximum length"
  }

  assert {
    condition     = length(output.storage_account.name) >= output.storage_account.min_length
    error_message = "storage_account name should meet minimum length requirement"
  }

  assert {
    condition     = length(output.storage_account.name) <= output.storage_account.max_length
    error_message = "storage_account name should not exceed maximum length"
  }

  assert {
    condition     = length(output.key_vault.name) >= output.key_vault.min_length
    error_message = "key_vault name should meet minimum length requirement"
  }

  assert {
    condition     = length(output.key_vault.name) <= output.key_vault.max_length
    error_message = "key_vault name should not exceed maximum length"
  }

  assert {
    condition     = length(output.virtual_machine.name) >= output.virtual_machine.min_length
    error_message = "vm name should meet minimum length requirement"
  }

  assert {
    condition     = length(output.virtual_machine.name) <= output.virtual_machine.max_length
    error_message = "vm name should not exceed maximum length"
  }
}

# Test scope values
run "scope_values" {
  command = apply

  variables {
    workload = "test"
  }

  assert {
    condition     = contains(["Global", "Resource Group", "Virtual Network", "SQL Server", "Event Hub Namespace", "Service Bus"], output.web_app.scope)
    error_message = "web_app scope should be valid"
  }

  assert {
    condition     = contains(["Global", "Resource Group", "Virtual Network", "SQL Server", "Event Hub Namespace", "Service Bus"], output.storage_account.scope)
    error_message = "storage_account scope should be valid"
  }

  assert {
    condition     = contains(["Global", "Resource Group", "Virtual Network", "SQL Server", "Event Hub Namespace", "Service Bus"], output.virtual_network.scope)
    error_message = "virtual_network scope should be valid"
  }
}

# Test unique_name contains slug and unique number
run "unique_name_format" {
  command = apply

  variables {
    workload    = "test"
    unique_seed = "uname"
  }

  assert {
    condition     = startswith(output.web_app.unique_name, "app")
    error_message = "unique_name should start with resource type slug"
  }

  assert {
    condition     = strcontains(output.storage_account.unique_name, output.storage_account.slug)
    error_message = "unique_name should contain resource type slug"
  }
}
