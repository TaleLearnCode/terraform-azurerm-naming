# =============================================================================
# Module:  Azure Resource Naming Generator
# File:    outputs.tf
# Purpose: Module outputs for all supported Azure resource types.
# =============================================================================

# -----------------------------------------------------------------------------
# AI + Machine Learning
# -----------------------------------------------------------------------------

output "ai_search" {
  description = "Naming convention for Azure AI Search"
  value = {
    name          = local.name_generator.ai_search.name
    unique_name   = local.name_generator.ai_search.unique_name
    allows_dashes = local.name_generator.ai_search.allows_dashes
    slug          = local.name_generator.ai_search.abbreviation
    min_length    = local.name_generator.ai_search.min_length
    max_length    = local.name_generator.ai_search.max_length
    scope         = local.name_generator.ai_search.scope
    regex         = local.name_generator.ai_search.regex
  }
}

output "ai_services" {
  description = "Naming convention for Azure AI Services"
  value = {
    name          = local.name_generator.ai_services.name
    unique_name   = local.name_generator.ai_services.unique_name
    allows_dashes = local.name_generator.ai_services.allows_dashes
    slug          = local.name_generator.ai_services.abbreviation
    min_length    = local.name_generator.ai_services.min_length
    max_length    = local.name_generator.ai_services.max_length
    scope         = local.name_generator.ai_services.scope
    regex         = local.name_generator.ai_services.regex
  }
}

output "foundry_account" {
  description = "Naming convention for Foundry Account"
  value = {
    name          = local.name_generator.foundry_account.name
    unique_name   = local.name_generator.foundry_account.unique_name
    allows_dashes = local.name_generator.foundry_account.allows_dashes
    slug          = local.name_generator.foundry_account.abbreviation
    min_length    = local.name_generator.foundry_account.min_length
    max_length    = local.name_generator.foundry_account.max_length
    scope         = local.name_generator.foundry_account.scope
    regex         = local.name_generator.foundry_account.regex
  }
}

output "foundry_project" {
  description = "Naming convention for Foundry Project"
  value = {
    name          = local.name_generator.foundry_project.name
    unique_name   = local.name_generator.foundry_project.unique_name
    allows_dashes = local.name_generator.foundry_project.allows_dashes
    slug          = local.name_generator.foundry_project.abbreviation
    min_length    = local.name_generator.foundry_project.min_length
    max_length    = local.name_generator.foundry_project.max_length
    scope         = local.name_generator.foundry_project.scope
    regex         = local.name_generator.foundry_project.regex
  }
}

output "foundry_hub" {
  description = "Naming convention for Foundry Hub"
  value = {
    name          = local.name_generator.foundry_hub.name
    unique_name   = local.name_generator.foundry_hub.unique_name
    allows_dashes = local.name_generator.foundry_hub.allows_dashes
    slug          = local.name_generator.foundry_hub.abbreviation
    min_length    = local.name_generator.foundry_hub.min_length
    max_length    = local.name_generator.foundry_hub.max_length
    scope         = local.name_generator.foundry_hub.scope
    regex         = local.name_generator.foundry_hub.regex
  }
}

output "machine_learning_workspace" {
  description = "Naming convention for Azure Machine Learning Workspace"
  value = {
    name          = local.name_generator.machine_learning_workspace.name
    unique_name   = local.name_generator.machine_learning_workspace.unique_name
    allows_dashes = local.name_generator.machine_learning_workspace.allows_dashes
    slug          = local.name_generator.machine_learning_workspace.abbreviation
    min_length    = local.name_generator.machine_learning_workspace.min_length
    max_length    = local.name_generator.machine_learning_workspace.max_length
    scope         = local.name_generator.machine_learning_workspace.scope
    regex         = local.name_generator.machine_learning_workspace.regex
  }
}

output "azure_openai" {
  description = "Naming convention for Azure OpenAI Service"
  value = {
    name          = local.name_generator.azure_openai.name
    unique_name   = local.name_generator.azure_openai.unique_name
    allows_dashes = local.name_generator.azure_openai.allows_dashes
    slug          = local.name_generator.azure_openai.abbreviation
    min_length    = local.name_generator.azure_openai.min_length
    max_length    = local.name_generator.azure_openai.max_length
    scope         = local.name_generator.azure_openai.scope
    regex         = local.name_generator.azure_openai.regex
  }
}

output "bot_service" {
  description = "Naming convention for Bot Service"
  value = {
    name          = local.name_generator.bot_service.name
    unique_name   = local.name_generator.bot_service.unique_name
    allows_dashes = local.name_generator.bot_service.allows_dashes
    slug          = local.name_generator.bot_service.abbreviation
    min_length    = local.name_generator.bot_service.min_length
    max_length    = local.name_generator.bot_service.max_length
    scope         = local.name_generator.bot_service.scope
    regex         = local.name_generator.bot_service.regex
  }
}

output "computer_vision" {
  description = "Naming convention for Computer Vision"
  value = {
    name          = local.name_generator.computer_vision.name
    unique_name   = local.name_generator.computer_vision.unique_name
    allows_dashes = local.name_generator.computer_vision.allows_dashes
    slug          = local.name_generator.computer_vision.abbreviation
    min_length    = local.name_generator.computer_vision.min_length
    max_length    = local.name_generator.computer_vision.max_length
    scope         = local.name_generator.computer_vision.scope
    regex         = local.name_generator.computer_vision.regex
  }
}

output "content_moderator" {
  description = "Naming convention for Content Moderator"
  value = {
    name          = local.name_generator.content_moderator.name
    unique_name   = local.name_generator.content_moderator.unique_name
    allows_dashes = local.name_generator.content_moderator.allows_dashes
    slug          = local.name_generator.content_moderator.abbreviation
    min_length    = local.name_generator.content_moderator.min_length
    max_length    = local.name_generator.content_moderator.max_length
    scope         = local.name_generator.content_moderator.scope
    regex         = local.name_generator.content_moderator.regex
  }
}

output "document_intelligence" {
  description = "Naming convention for Document Intelligence"
  value = {
    name          = local.name_generator.document_intelligence.name
    unique_name   = local.name_generator.document_intelligence.unique_name
    allows_dashes = local.name_generator.document_intelligence.allows_dashes
    slug          = local.name_generator.document_intelligence.abbreviation
    min_length    = local.name_generator.document_intelligence.min_length
    max_length    = local.name_generator.document_intelligence.max_length
    scope         = local.name_generator.document_intelligence.scope
    regex         = local.name_generator.document_intelligence.regex
  }
}

output "language_service" {
  description = "Naming convention for Language Service"
  value = {
    name          = local.name_generator.language_service.name
    unique_name   = local.name_generator.language_service.unique_name
    allows_dashes = local.name_generator.language_service.allows_dashes
    slug          = local.name_generator.language_service.abbreviation
    min_length    = local.name_generator.language_service.min_length
    max_length    = local.name_generator.language_service.max_length
    scope         = local.name_generator.language_service.scope
    regex         = local.name_generator.language_service.regex
  }
}

# -----------------------------------------------------------------------------
# Analytics and IoT
# -----------------------------------------------------------------------------

output "analysis_services" {
  description = "Naming convention for Analysis Services"
  value = {
    name          = local.name_generator.analysis_services.name
    unique_name   = local.name_generator.analysis_services.unique_name
    allows_dashes = local.name_generator.analysis_services.allows_dashes
    slug          = local.name_generator.analysis_services.abbreviation
    min_length    = local.name_generator.analysis_services.min_length
    max_length    = local.name_generator.analysis_services.max_length
    scope         = local.name_generator.analysis_services.scope
    regex         = local.name_generator.analysis_services.regex
  }
}

output "databricks" {
  description = "Naming convention for Azure Databricks"
  value = {
    name          = local.name_generator.databricks.name
    unique_name   = local.name_generator.databricks.unique_name
    allows_dashes = local.name_generator.databricks.allows_dashes
    slug          = local.name_generator.databricks.abbreviation
    min_length    = local.name_generator.databricks.min_length
    max_length    = local.name_generator.databricks.max_length
    scope         = local.name_generator.databricks.scope
    regex         = local.name_generator.databricks.regex
  }
}

output "data_explorer" {
  description = "Naming convention for Azure Data Explorer"
  value = {
    name          = local.name_generator.data_explorer.name
    unique_name   = local.name_generator.data_explorer.unique_name
    allows_dashes = local.name_generator.data_explorer.allows_dashes
    slug          = local.name_generator.data_explorer.abbreviation
    min_length    = local.name_generator.data_explorer.min_length
    max_length    = local.name_generator.data_explorer.max_length
    scope         = local.name_generator.data_explorer.scope
    regex         = local.name_generator.data_explorer.regex
  }
}

output "data_factory" {
  description = "Naming convention for Azure Data Factory"
  value = {
    name          = local.name_generator.data_factory.name
    unique_name   = local.name_generator.data_factory.unique_name
    allows_dashes = local.name_generator.data_factory.allows_dashes
    slug          = local.name_generator.data_factory.abbreviation
    min_length    = local.name_generator.data_factory.min_length
    max_length    = local.name_generator.data_factory.max_length
    scope         = local.name_generator.data_factory.scope
    regex         = local.name_generator.data_factory.regex
  }
}

output "digital_twins" {
  description = "Naming convention for Azure Digital Twins"
  value = {
    name          = local.name_generator.digital_twins.name
    unique_name   = local.name_generator.digital_twins.unique_name
    allows_dashes = local.name_generator.digital_twins.allows_dashes
    slug          = local.name_generator.digital_twins.abbreviation
    min_length    = local.name_generator.digital_twins.min_length
    max_length    = local.name_generator.digital_twins.max_length
    scope         = local.name_generator.digital_twins.scope
    regex         = local.name_generator.digital_twins.regex
  }
}

output "event_hub_namespace" {
  description = "Naming convention for Event Hub Namespace"
  value = {
    name          = local.name_generator.event_hub_namespace.name
    unique_name   = local.name_generator.event_hub_namespace.unique_name
    allows_dashes = local.name_generator.event_hub_namespace.allows_dashes
    slug          = local.name_generator.event_hub_namespace.abbreviation
    min_length    = local.name_generator.event_hub_namespace.min_length
    max_length    = local.name_generator.event_hub_namespace.max_length
    scope         = local.name_generator.event_hub_namespace.scope
    regex         = local.name_generator.event_hub_namespace.regex
  }
}

output "event_hub" {
  description = "Naming convention for Event Hub"
  value = {
    name          = local.name_generator.event_hub.name
    unique_name   = local.name_generator.event_hub.unique_name
    allows_dashes = local.name_generator.event_hub.allows_dashes
    slug          = local.name_generator.event_hub.abbreviation
    min_length    = local.name_generator.event_hub.min_length
    max_length    = local.name_generator.event_hub.max_length
    scope         = local.name_generator.event_hub.scope
    regex         = local.name_generator.event_hub.regex
  }
}

output "event_grid_domain" {
  description = "Naming convention for Event Grid Domain"
  value = {
    name          = local.name_generator.event_grid_domain.name
    unique_name   = local.name_generator.event_grid_domain.unique_name
    allows_dashes = local.name_generator.event_grid_domain.allows_dashes
    slug          = local.name_generator.event_grid_domain.abbreviation
    min_length    = local.name_generator.event_grid_domain.min_length
    max_length    = local.name_generator.event_grid_domain.max_length
    scope         = local.name_generator.event_grid_domain.scope
    regex         = local.name_generator.event_grid_domain.regex
  }
}

output "iot_hub" {
  description = "Naming convention for IoT Hub"
  value = {
    name          = local.name_generator.iot_hub.name
    unique_name   = local.name_generator.iot_hub.unique_name
    allows_dashes = local.name_generator.iot_hub.allows_dashes
    slug          = local.name_generator.iot_hub.abbreviation
    min_length    = local.name_generator.iot_hub.min_length
    max_length    = local.name_generator.iot_hub.max_length
    scope         = local.name_generator.iot_hub.scope
    regex         = local.name_generator.iot_hub.regex
  }
}

# -----------------------------------------------------------------------------
# Compute and Web
# -----------------------------------------------------------------------------

output "app_service_plan" {
  description = "Naming convention for App Service Plan"
  value = {
    name          = local.name_generator.app_service_plan.name
    unique_name   = local.name_generator.app_service_plan.unique_name
    allows_dashes = local.name_generator.app_service_plan.allows_dashes
    slug          = local.name_generator.app_service_plan.abbreviation
    min_length    = local.name_generator.app_service_plan.min_length
    max_length    = local.name_generator.app_service_plan.max_length
    scope         = local.name_generator.app_service_plan.scope
    regex         = local.name_generator.app_service_plan.regex
  }
}

output "availability_set" {
  description = "Naming convention for Availability Set"
  value = {
    name          = local.name_generator.availability_set.name
    unique_name   = local.name_generator.availability_set.unique_name
    allows_dashes = local.name_generator.availability_set.allows_dashes
    slug          = local.name_generator.availability_set.abbreviation
    min_length    = local.name_generator.availability_set.min_length
    max_length    = local.name_generator.availability_set.max_length
    scope         = local.name_generator.availability_set.scope
    regex         = local.name_generator.availability_set.regex
  }
}

output "function_app" {
  description = "Naming convention for Function App"
  value = {
    name          = local.name_generator.function_app.name
    unique_name   = local.name_generator.function_app.unique_name
    allows_dashes = local.name_generator.function_app.allows_dashes
    slug          = local.name_generator.function_app.abbreviation
    min_length    = local.name_generator.function_app.min_length
    max_length    = local.name_generator.function_app.max_length
    scope         = local.name_generator.function_app.scope
    regex         = local.name_generator.function_app.regex
  }
}

output "image_template" {
  description = "Naming convention for Image Template"
  value = {
    name          = local.name_generator.image_template.name
    unique_name   = local.name_generator.image_template.unique_name
    allows_dashes = local.name_generator.image_template.allows_dashes
    slug          = local.name_generator.image_template.abbreviation
    min_length    = local.name_generator.image_template.min_length
    max_length    = local.name_generator.image_template.max_length
    scope         = local.name_generator.image_template.scope
    regex         = local.name_generator.image_template.regex
  }
}

output "static_web_app" {
  description = "Naming convention for Static Web App"
  value = {
    name          = local.name_generator.static_web_app.name
    unique_name   = local.name_generator.static_web_app.unique_name
    allows_dashes = local.name_generator.static_web_app.allows_dashes
    slug          = local.name_generator.static_web_app.abbreviation
    min_length    = local.name_generator.static_web_app.min_length
    max_length    = local.name_generator.static_web_app.max_length
    scope         = local.name_generator.static_web_app.scope
    regex         = local.name_generator.static_web_app.regex
  }
}

output "virtual_machine" {
  description = "Naming convention for Virtual Machine"
  value = {
    name          = local.name_generator.virtual_machine.name
    unique_name   = local.name_generator.virtual_machine.unique_name
    allows_dashes = local.name_generator.virtual_machine.allows_dashes
    slug          = local.name_generator.virtual_machine.abbreviation
    min_length    = local.name_generator.virtual_machine.min_length
    max_length    = local.name_generator.virtual_machine.max_length
    scope         = local.name_generator.virtual_machine.scope
    regex         = local.name_generator.virtual_machine.regex
  }
}

output "virtual_machine_scale_set" {
  description = "Naming convention for Virtual Machine Scale Set"
  value = {
    name          = local.name_generator.virtual_machine_scale_set.name
    unique_name   = local.name_generator.virtual_machine_scale_set.unique_name
    allows_dashes = local.name_generator.virtual_machine_scale_set.allows_dashes
    slug          = local.name_generator.virtual_machine_scale_set.abbreviation
    min_length    = local.name_generator.virtual_machine_scale_set.min_length
    max_length    = local.name_generator.virtual_machine_scale_set.max_length
    scope         = local.name_generator.virtual_machine_scale_set.scope
    regex         = local.name_generator.virtual_machine_scale_set.regex
  }
}

output "web_app" {
  description = "Naming convention for Web App"
  value = {
    name          = local.name_generator.web_app.name
    unique_name   = local.name_generator.web_app.unique_name
    allows_dashes = local.name_generator.web_app.allows_dashes
    slug          = local.name_generator.web_app.abbreviation
    min_length    = local.name_generator.web_app.min_length
    max_length    = local.name_generator.web_app.max_length
    scope         = local.name_generator.web_app.scope
    regex         = local.name_generator.web_app.regex
  }
}

# -----------------------------------------------------------------------------
# Containers
# -----------------------------------------------------------------------------

output "aks_cluster" {
  description = "Naming convention for AKS Cluster"
  value = {
    name          = local.name_generator.aks_cluster.name
    unique_name   = local.name_generator.aks_cluster.unique_name
    allows_dashes = local.name_generator.aks_cluster.allows_dashes
    slug          = local.name_generator.aks_cluster.abbreviation
    min_length    = local.name_generator.aks_cluster.min_length
    max_length    = local.name_generator.aks_cluster.max_length
    scope         = local.name_generator.aks_cluster.scope
    regex         = local.name_generator.aks_cluster.regex
  }
}

output "container_apps" {
  description = "Naming convention for Container Apps"
  value = {
    name          = local.name_generator.container_apps.name
    unique_name   = local.name_generator.container_apps.unique_name
    allows_dashes = local.name_generator.container_apps.allows_dashes
    slug          = local.name_generator.container_apps.abbreviation
    min_length    = local.name_generator.container_apps.min_length
    max_length    = local.name_generator.container_apps.max_length
    scope         = local.name_generator.container_apps.scope
    regex         = local.name_generator.container_apps.regex
  }
}

output "container_registry" {
  description = "Naming convention for Container Registry"
  value = {
    name          = local.name_generator.container_registry.name
    unique_name   = local.name_generator.container_registry.unique_name
    allows_dashes = local.name_generator.container_registry.allows_dashes
    slug          = local.name_generator.container_registry.abbreviation
    min_length    = local.name_generator.container_registry.min_length
    max_length    = local.name_generator.container_registry.max_length
    scope         = local.name_generator.container_registry.scope
    regex         = local.name_generator.container_registry.regex
  }
}

# -----------------------------------------------------------------------------
# Databases
# -----------------------------------------------------------------------------

output "cosmos_db_sql" {
  description = "Naming convention for Cosmos DB (NoSQL)"
  value = {
    name          = local.name_generator.cosmos_db_sql.name
    unique_name   = local.name_generator.cosmos_db_sql.unique_name
    allows_dashes = local.name_generator.cosmos_db_sql.allows_dashes
    slug          = local.name_generator.cosmos_db_sql.abbreviation
    min_length    = local.name_generator.cosmos_db_sql.min_length
    max_length    = local.name_generator.cosmos_db_sql.max_length
    scope         = local.name_generator.cosmos_db_sql.scope
    regex         = local.name_generator.cosmos_db_sql.regex
  }
}

output "cache_redis" {
  description = "Naming convention for Azure Cache for Redis"
  value = {
    name          = local.name_generator.cache_redis.name
    unique_name   = local.name_generator.cache_redis.unique_name
    allows_dashes = local.name_generator.cache_redis.allows_dashes
    slug          = local.name_generator.cache_redis.abbreviation
    min_length    = local.name_generator.cache_redis.min_length
    max_length    = local.name_generator.cache_redis.max_length
    scope         = local.name_generator.cache_redis.scope
    regex         = local.name_generator.cache_redis.regex
  }
}

output "sql_server" {
  description = "Naming convention for SQL Server"
  value = {
    name          = local.name_generator.sql_server.name
    unique_name   = local.name_generator.sql_server.unique_name
    allows_dashes = local.name_generator.sql_server.allows_dashes
    slug          = local.name_generator.sql_server.abbreviation
    min_length    = local.name_generator.sql_server.min_length
    max_length    = local.name_generator.sql_server.max_length
    scope         = local.name_generator.sql_server.scope
    regex         = local.name_generator.sql_server.regex
  }
}

output "sql_database" {
  description = "Naming convention for SQL Database"
  value = {
    name          = local.name_generator.sql_database.name
    unique_name   = local.name_generator.sql_database.unique_name
    allows_dashes = local.name_generator.sql_database.allows_dashes
    slug          = local.name_generator.sql_database.abbreviation
    min_length    = local.name_generator.sql_database.min_length
    max_length    = local.name_generator.sql_database.max_length
    scope         = local.name_generator.sql_database.scope
    regex         = local.name_generator.sql_database.regex
  }
}

output "mysql_server" {
  description = "Naming convention for MySQL Server"
  value = {
    name          = local.name_generator.mysql_server.name
    unique_name   = local.name_generator.mysql_server.unique_name
    allows_dashes = local.name_generator.mysql_server.allows_dashes
    slug          = local.name_generator.mysql_server.abbreviation
    min_length    = local.name_generator.mysql_server.min_length
    max_length    = local.name_generator.mysql_server.max_length
    scope         = local.name_generator.mysql_server.scope
    regex         = local.name_generator.mysql_server.regex
  }
}

output "postgresql_server" {
  description = "Naming convention for PostgreSQL Server"
  value = {
    name          = local.name_generator.postgresql_server.name
    unique_name   = local.name_generator.postgresql_server.unique_name
    allows_dashes = local.name_generator.postgresql_server.allows_dashes
    slug          = local.name_generator.postgresql_server.abbreviation
    min_length    = local.name_generator.postgresql_server.min_length
    max_length    = local.name_generator.postgresql_server.max_length
    scope         = local.name_generator.postgresql_server.scope
    regex         = local.name_generator.postgresql_server.regex
  }
}

# -----------------------------------------------------------------------------
# Integration
# -----------------------------------------------------------------------------

output "api_management" {
  description = "Naming convention for API Management"
  value = {
    name          = local.name_generator.api_management.name
    unique_name   = local.name_generator.api_management.unique_name
    allows_dashes = local.name_generator.api_management.allows_dashes
    slug          = local.name_generator.api_management.abbreviation
    min_length    = local.name_generator.api_management.min_length
    max_length    = local.name_generator.api_management.max_length
    scope         = local.name_generator.api_management.scope
    regex         = local.name_generator.api_management.regex
  }
}

output "service_bus_namespace" {
  description = "Naming convention for Service Bus Namespace"
  value = {
    name          = local.name_generator.service_bus_namespace.name
    unique_name   = local.name_generator.service_bus_namespace.unique_name
    allows_dashes = local.name_generator.service_bus_namespace.allows_dashes
    slug          = local.name_generator.service_bus_namespace.abbreviation
    min_length    = local.name_generator.service_bus_namespace.min_length
    max_length    = local.name_generator.service_bus_namespace.max_length
    scope         = local.name_generator.service_bus_namespace.scope
    regex         = local.name_generator.service_bus_namespace.regex
  }
}

output "logic_app" {
  description = "Naming convention for Logic App"
  value = {
    name          = local.name_generator.logic_app.name
    unique_name   = local.name_generator.logic_app.unique_name
    allows_dashes = local.name_generator.logic_app.allows_dashes
    slug          = local.name_generator.logic_app.abbreviation
    min_length    = local.name_generator.logic_app.min_length
    max_length    = local.name_generator.logic_app.max_length
    scope         = local.name_generator.logic_app.scope
    regex         = local.name_generator.logic_app.regex
  }
}

# -----------------------------------------------------------------------------
# Management and Governance
# -----------------------------------------------------------------------------

output "automation_account" {
  description = "Naming convention for Automation Account"
  value = {
    name          = local.name_generator.automation_account.name
    unique_name   = local.name_generator.automation_account.unique_name
    allows_dashes = local.name_generator.automation_account.allows_dashes
    slug          = local.name_generator.automation_account.abbreviation
    min_length    = local.name_generator.automation_account.min_length
    max_length    = local.name_generator.automation_account.max_length
    scope         = local.name_generator.automation_account.scope
    regex         = local.name_generator.automation_account.regex
  }
}

output "app_insights" {
  description = "Naming convention for Application Insights"
  value = {
    name          = local.name_generator.app_insights.name
    unique_name   = local.name_generator.app_insights.unique_name
    allows_dashes = local.name_generator.app_insights.allows_dashes
    slug          = local.name_generator.app_insights.abbreviation
    min_length    = local.name_generator.app_insights.min_length
    max_length    = local.name_generator.app_insights.max_length
    scope         = local.name_generator.app_insights.scope
    regex         = local.name_generator.app_insights.regex
  }
}

output "log_analytics" {
  description = "Naming convention for Log Analytics Workspace"
  value = {
    name          = local.name_generator.log_analytics.name
    unique_name   = local.name_generator.log_analytics.unique_name
    allows_dashes = local.name_generator.log_analytics.allows_dashes
    slug          = local.name_generator.log_analytics.abbreviation
    min_length    = local.name_generator.log_analytics.min_length
    max_length    = local.name_generator.log_analytics.max_length
    scope         = local.name_generator.log_analytics.scope
    regex         = local.name_generator.log_analytics.regex
  }
}

# -----------------------------------------------------------------------------
# Networking
# -----------------------------------------------------------------------------

output "application_gateway" {
  description = "Naming convention for Application Gateway"
  value = {
    name          = local.name_generator.application_gateway.name
    unique_name   = local.name_generator.application_gateway.unique_name
    allows_dashes = local.name_generator.application_gateway.allows_dashes
    slug          = local.name_generator.application_gateway.abbreviation
    min_length    = local.name_generator.application_gateway.min_length
    max_length    = local.name_generator.application_gateway.max_length
    scope         = local.name_generator.application_gateway.scope
    regex         = local.name_generator.application_gateway.regex
  }
}

output "azure_firewall" {
  description = "Naming convention for Azure Firewall"
  value = {
    name          = local.name_generator.azure_firewall.name
    unique_name   = local.name_generator.azure_firewall.unique_name
    allows_dashes = local.name_generator.azure_firewall.allows_dashes
    slug          = local.name_generator.azure_firewall.abbreviation
    min_length    = local.name_generator.azure_firewall.min_length
    max_length    = local.name_generator.azure_firewall.max_length
    scope         = local.name_generator.azure_firewall.scope
    regex         = local.name_generator.azure_firewall.regex
  }
}

output "cdn_profile" {
  description = "Naming convention for CDN Profile"
  value = {
    name          = local.name_generator.cdn_profile.name
    unique_name   = local.name_generator.cdn_profile.unique_name
    allows_dashes = local.name_generator.cdn_profile.allows_dashes
    slug          = local.name_generator.cdn_profile.abbreviation
    min_length    = local.name_generator.cdn_profile.min_length
    max_length    = local.name_generator.cdn_profile.max_length
    scope         = local.name_generator.cdn_profile.scope
    regex         = local.name_generator.cdn_profile.regex
  }
}

output "firewall_policy" {
  description = "Naming convention for Firewall Policy"
  value = {
    name          = local.name_generator.firewall_policy.name
    unique_name   = local.name_generator.firewall_policy.unique_name
    allows_dashes = local.name_generator.firewall_policy.allows_dashes
    slug          = local.name_generator.firewall_policy.abbreviation
    min_length    = local.name_generator.firewall_policy.min_length
    max_length    = local.name_generator.firewall_policy.max_length
    scope         = local.name_generator.firewall_policy.scope
    regex         = local.name_generator.firewall_policy.regex
  }
}

output "load_balancer" {
  description = "Naming convention for Load Balancer"
  value = {
    name          = local.name_generator.load_balancer.name
    unique_name   = local.name_generator.load_balancer.unique_name
    allows_dashes = local.name_generator.load_balancer.allows_dashes
    slug          = local.name_generator.load_balancer.abbreviation
    min_length    = local.name_generator.load_balancer.min_length
    max_length    = local.name_generator.load_balancer.max_length
    scope         = local.name_generator.load_balancer.scope
    regex         = local.name_generator.load_balancer.regex
  }
}

output "network_interface" {
  description = "Naming convention for Network Interface"
  value = {
    name          = local.name_generator.network_interface.name
    unique_name   = local.name_generator.network_interface.unique_name
    allows_dashes = local.name_generator.network_interface.allows_dashes
    slug          = local.name_generator.network_interface.abbreviation
    min_length    = local.name_generator.network_interface.min_length
    max_length    = local.name_generator.network_interface.max_length
    scope         = local.name_generator.network_interface.scope
    regex         = local.name_generator.network_interface.regex
  }
}

output "network_security_group" {
  description = "Naming convention for Network Security Group"
  value = {
    name          = local.name_generator.network_security_group.name
    unique_name   = local.name_generator.network_security_group.unique_name
    allows_dashes = local.name_generator.network_security_group.allows_dashes
    slug          = local.name_generator.network_security_group.abbreviation
    min_length    = local.name_generator.network_security_group.min_length
    max_length    = local.name_generator.network_security_group.max_length
    scope         = local.name_generator.network_security_group.scope
    regex         = local.name_generator.network_security_group.regex
  }
}

output "public_ip" {
  description = "Naming convention for Public IP"
  value = {
    name          = local.name_generator.public_ip.name
    unique_name   = local.name_generator.public_ip.unique_name
    allows_dashes = local.name_generator.public_ip.allows_dashes
    slug          = local.name_generator.public_ip.abbreviation
    min_length    = local.name_generator.public_ip.min_length
    max_length    = local.name_generator.public_ip.max_length
    scope         = local.name_generator.public_ip.scope
    regex         = local.name_generator.public_ip.regex
  }
}

output "virtual_network" {
  description = "Naming convention for Virtual Network"
  value = {
    name          = local.name_generator.virtual_network.name
    unique_name   = local.name_generator.virtual_network.unique_name
    allows_dashes = local.name_generator.virtual_network.allows_dashes
    slug          = local.name_generator.virtual_network.abbreviation
    min_length    = local.name_generator.virtual_network.min_length
    max_length    = local.name_generator.virtual_network.max_length
    scope         = local.name_generator.virtual_network.scope
    regex         = local.name_generator.virtual_network.regex
  }
}

output "subnet" {
  description = "Naming convention for Subnet"
  value = {
    name          = local.name_generator.subnet.name
    unique_name   = local.name_generator.subnet.unique_name
    allows_dashes = local.name_generator.subnet.allows_dashes
    slug          = local.name_generator.subnet.abbreviation
    min_length    = local.name_generator.subnet.min_length
    max_length    = local.name_generator.subnet.max_length
    scope         = local.name_generator.subnet.scope
    regex         = local.name_generator.subnet.regex
  }
}

# -----------------------------------------------------------------------------
# Security
# -----------------------------------------------------------------------------

output "key_vault" {
  description = "Naming convention for Key Vault"
  value = {
    name          = local.name_generator.key_vault.name
    unique_name   = local.name_generator.key_vault.unique_name
    allows_dashes = local.name_generator.key_vault.allows_dashes
    slug          = local.name_generator.key_vault.abbreviation
    min_length    = local.name_generator.key_vault.min_length
    max_length    = local.name_generator.key_vault.max_length
    scope         = local.name_generator.key_vault.scope
    regex         = local.name_generator.key_vault.regex
  }
}

output "managed_identity" {
  description = "Naming convention for Managed Identity"
  value = {
    name          = local.name_generator.managed_identity.name
    unique_name   = local.name_generator.managed_identity.unique_name
    allows_dashes = local.name_generator.managed_identity.allows_dashes
    slug          = local.name_generator.managed_identity.abbreviation
    min_length    = local.name_generator.managed_identity.min_length
    max_length    = local.name_generator.managed_identity.max_length
    scope         = local.name_generator.managed_identity.scope
    regex         = local.name_generator.managed_identity.regex
  }
}

# -----------------------------------------------------------------------------
# Storage
# -----------------------------------------------------------------------------

output "storage_account" {
  description = "Naming convention for Storage Account"
  value = {
    name          = local.name_generator.storage_account.name
    unique_name   = local.name_generator.storage_account.unique_name
    allows_dashes = local.name_generator.storage_account.allows_dashes
    slug          = local.name_generator.storage_account.abbreviation
    min_length    = local.name_generator.storage_account.min_length
    max_length    = local.name_generator.storage_account.max_length
    scope         = local.name_generator.storage_account.scope
    regex         = local.name_generator.storage_account.regex
  }
}

output "storage_sync" {
  description = "Naming convention for Storage Sync Service"
  value = {
    name          = local.name_generator.storage_sync.name
    unique_name   = local.name_generator.storage_sync.unique_name
    allows_dashes = local.name_generator.storage_sync.allows_dashes
    slug          = local.name_generator.storage_sync.abbreviation
    min_length    = local.name_generator.storage_sync.min_length
    max_length    = local.name_generator.storage_sync.max_length
    scope         = local.name_generator.storage_sync.scope
    regex         = local.name_generator.storage_sync.regex
  }
}