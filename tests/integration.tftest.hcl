# Test multiple common resource types together
run "multi_resource_naming" {
  command = apply

  variables {
    workload    = "myapp"
    environment = "prod"
    region      = "eastus"
    unique_seed = "multi"
  }

  assert {
    condition     = output.web_app.name != ""
    error_message = "Should generate web app name"
  }

  assert {
    condition     = output.storage_account.name != ""
    error_message = "Should generate storage account name"
  }

  assert {
    condition     = output.virtual_network.name != ""
    error_message = "Should generate vnet name"
  }

  assert {
    condition     = output.key_vault.name != ""
    error_message = "Should generate key vault name"
  }

  assert {
    condition     = output.sql_server.name != ""
    error_message = "Should generate SQL server name"
  }

  assert {
    condition     = strcontains(output.web_app.name, "myapp") && strcontains(output.storage_account.name, "myapp") && strcontains(output.virtual_network.name, "myapp")
    error_message = "All names should contain the workload"
  }

  assert {
    condition     = !strcontains(output.storage_account.name, "-") && !strcontains(output.container_registry.name, "-")
    error_message = "Storage and container registry names should not contain dashes"
  }
}

# Test different environments with same seed
run "environment_variations_prod" {
  command = apply

  variables {
    workload    = "app"
    environment = "prod"
    unique_seed = "envtest"
  }

  assert {
    condition     = strcontains(output.web_app.name, "prod")
    error_message = "Should include 'prod' environment in name"
  }
}

run "environment_variations_dev" {
  command = apply

  variables {
    workload    = "app"
    environment = "dev"
    unique_seed = "envtest"
  }

  assert {
    condition     = strcontains(output.web_app.name, "dev")
    error_message = "Should include 'dev' environment in name"
  }
}

run "environment_variations_staging" {
  command = apply

  variables {
    workload    = "app"
    environment = "staging"
    unique_seed = "envtest"
  }

  assert {
    condition     = strcontains(output.web_app.name, "staging")
    error_message = "Should include 'staging' environment in name"
  }
}

# Test different regions resolve properly
run "region_east_us" {
  command = apply

  variables {
    workload = "app"
    region   = "eastus"
  }

  assert {
    condition     = strcontains(output.web_app.name, "eus")
    error_message = "Should resolve eastus region"
  }
}

run "region_west_us" {
  command = apply

  variables {
    workload = "app"
    region   = "westus"
  }

  assert {
    condition     = strcontains(output.web_app.name, "wus")
    error_message = "Should resolve westus region"
  }
}

run "region_west_europe" {
  command = apply

  variables {
    workload = "app"
    region   = "westeurope"
  }

  assert {
    condition     = strcontains(output.web_app.name, "we")
    error_message = "Should resolve westeurope region"
  }
}

# Test all AI and ML resources
run "ai_ml_resources" {
  command = apply

  variables {
    workload = "ai"
  }

  assert {
    condition     = output.ai_search.name != ""
    error_message = "Should generate AI Search name"
  }

  assert {
    condition     = output.azure_openai.name != ""
    error_message = "Should generate Azure OpenAI name"
  }

  assert {
    condition     = output.machine_learning_workspace.name != ""
    error_message = "Should generate ML Workspace name"
  }

  assert {
    condition     = output.bot_service.name != ""
    error_message = "Should generate Bot Service name"
  }
}

# Test all compute resources
run "compute_resources" {
  command = apply

  variables {
    workload = "compute"
    region   = "eastus"
  }

  assert {
    condition     = output.virtual_machine.name != ""
    error_message = "Should generate Virtual Machine name"
  }

  assert {
    condition     = output.web_app.name != ""
    error_message = "Should generate Web App name"
  }

  assert {
    condition     = output.function_app.name != ""
    error_message = "Should generate Function App name"
  }

  assert {
    condition     = output.app_service_plan.name != ""
    error_message = "Should generate App Service Plan name"
  }
}

# Test all networking resources
run "networking_resources" {
  command = apply

  variables {
    workload = "network"
    region   = "eastus"
  }

  assert {
    condition     = output.virtual_network.name != ""
    error_message = "Should generate VNET name"
  }

  assert {
    condition     = output.subnet.name != ""
    error_message = "Should generate subnet name"
  }

  assert {
    condition     = output.network_security_group.name != ""
    error_message = "Should generate NSG name"
  }

  assert {
    condition     = output.public_ip.name != ""
    error_message = "Should generate Public IP name"
  }

  assert {
    condition     = output.load_balancer.name != ""
    error_message = "Should generate Load Balancer name"
  }

  assert {
    condition     = output.application_gateway.name != ""
    error_message = "Should generate Application Gateway name"
  }
}

# Test all database resources
run "database_resources" {
  command = apply

  variables {
    workload = "database"
    region   = "eastus"
  }

  assert {
    condition     = output.sql_server.name != ""
    error_message = "Should generate SQL Server name"
  }

  assert {
    condition     = output.sql_database.name != ""
    error_message = "Should generate SQL Database name"
  }

  assert {
    condition     = output.mysql_server.name != ""
    error_message = "Should generate MySQL name"
  }

  assert {
    condition     = output.postgresql_server.name != ""
    error_message = "Should generate PostgreSQL name"
  }

  assert {
    condition     = output.cosmos_db_sql.name != ""
    error_message = "Should generate Cosmos DB name"
  }

  assert {
    condition     = output.cache_redis.name != ""
    error_message = "Should generate Redis name"
  }
}
