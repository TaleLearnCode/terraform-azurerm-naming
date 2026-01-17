# =============================================================================
# Module:  Azure Resource Naming Generator
# File:    main.tf
# Purpose: Generates standardized names for Azure resources based on
#          workload, environment, region, unique suffix, and instance number.
# =============================================================================

# -----------------------------------------------------------------------------
# Fetch Azure regions data using the Azure Verified Module
# -----------------------------------------------------------------------------

module "regions" {
  source  = "Azure/avm-utl-regions/azurerm"
  version = "~> 0.9"

  enable_telemetry = false
}

# -----------------------------------------------------------------------------
# Generate random unique number based on seed
# -----------------------------------------------------------------------------

resource "random_integer" "unique" {
  min  = 0
  max  = pow(10, var.unique_length) - 1
  seed = var.unique_seed == "" ? null : var.unique_seed
  keepers = {
    workload    = var.workload
    environment = var.environment
    region      = var.region
    unique_seed = var.unique_seed
  }
}

# -----------------------------------------------------------------------------
# Format the unique number with leading zeros
# -----------------------------------------------------------------------------

locals {
  unique_number = format("%0${var.unique_length}d", random_integer.unique.result)

  # Resolve region to geo code
  region_code = var.region != null ? (
    try(
      module.regions.regions_by_name_or_display_name[var.region].geo_code != null ?
      module.regions.regions_by_name_or_display_name[var.region].geo_code :
      module.regions.regions_by_name_or_display_name[var.region].short_name,
      var.region
    )
  ) : null

  # Build name components
  components = {
    workload    = var.workload
    unique      = local.unique_number
    environment = var.environment
    region      = local.region_code
    instance    = var.instance_number > 0 ? format("%03d", var.instance_number) : null
  }
}

# -----------------------------------------------------------------------------
# Define all supported Azure resource types with their naming configurations
# -----------------------------------------------------------------------------

locals {
  resource_types = {

    # -----------------------------------------------------
    # AI + Machine Learning
    # -----------------------------------------------------

    ai_search = {
      abbreviation  = "srch"
      allows_dashes = true
      min_length    = 2
      max_length    = 64
      scope         = "Global"
      regex         = "^[a-z0-9][a-z0-9-]*[a-z0-9]$"
    }
    ai_services = {
      abbreviation  = "ais"
      allows_dashes = true
      min_length    = 2
      max_length    = 64
      scope         = "Global"
      regex         = "^[a-z0-9][a-z0-9-]*[a-z0-9]$"
    }
    foundry_account = {
      abbreviation  = "aif"
      allows_dashes = true
      min_length    = 2
      max_length    = 64
      scope         = "Global"
      regex         = "^[a-z0-9][a-z0-9-]*[a-z0-9]$"
    }
    foundry_project = {
      abbreviation  = "proj"
      allows_dashes = true
      min_length    = 1
      max_length    = 64
      scope         = "Resource Group"
      regex         = "^[a-z0-9][a-z0-9-]*[a-z0-9]$"
    }
    foundry_hub = {
      abbreviation  = "hub"
      allows_dashes = true
      min_length    = 1
      max_length    = 64
      scope         = "Resource Group"
      regex         = "^[a-z0-9][a-z0-9-]*[a-z0-9]$"
    }
    machine_learning_workspace = {
      abbreviation  = "mlw"
      allows_dashes = true
      min_length    = 3
      max_length    = 260
      scope         = "Resource Group"
      regex         = "^[a-zA-Z0-9][a-zA-Z0-9-._]*$"
    }
    azure_openai = {
      abbreviation  = "oai"
      allows_dashes = true
      min_length    = 2
      max_length    = 64
      scope         = "Global"
      regex         = "^[a-z0-9][a-z0-9-]*[a-z0-9]$"
    }
    bot_service = {
      abbreviation  = "bot"
      allows_dashes = true
      min_length    = 1
      max_length    = 64
      scope         = "Global"
      regex         = "^[a-z0-9][a-z0-9-]*[a-z0-9]$"
    }
    computer_vision = {
      abbreviation  = "cv"
      allows_dashes = true
      min_length    = 2
      max_length    = 64
      scope         = "Global"
      regex         = "^[a-z0-9][a-z0-9-]*[a-z0-9]$"
    }
    content_moderator = {
      abbreviation  = "cm"
      allows_dashes = true
      min_length    = 2
      max_length    = 64
      scope         = "Global"
      regex         = "^[a-z0-9][a-z0-9-]*[a-z0-9]$"
    }
    document_intelligence = {
      abbreviation  = "di"
      allows_dashes = true
      min_length    = 2
      max_length    = 64
      scope         = "Global"
      regex         = "^[a-z0-9][a-z0-9-]*[a-z0-9]$"
    }
    language_service = {
      abbreviation  = "lang"
      allows_dashes = true
      min_length    = 2
      max_length    = 64
      scope         = "Global"
      regex         = "^[a-z0-9][a-z0-9-]*[a-z0-9]$"
    }

    # -----------------------------------------------------
    # Analytics and IoT
    # -----------------------------------------------------

    analysis_services = {
      abbreviation  = "as"
      allows_dashes = true
      min_length    = 3
      max_length    = 63
      scope         = "Resource Group"
      regex         = "^[a-z][a-z0-9]*$"
    }
    databricks = {
      abbreviation  = "dbw"
      allows_dashes = true
      min_length    = 3
      max_length    = 30
      scope         = "Resource Group"
      regex         = "^[a-zA-Z0-9_-]*$"
    }
    data_explorer = {
      abbreviation  = "dec"
      allows_dashes = true
      min_length    = 1
      max_length    = 22
      scope         = "Global"
      regex         = "^[a-z][a-z0-9]*$"
    }
    data_factory = {
      abbreviation  = "adf"
      allows_dashes = true
      min_length    = 3
      max_length    = 63
      scope         = "Global"
      regex         = "^[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?$"
    }
    digital_twins = {
      abbreviation  = "dt"
      allows_dashes = true
      min_length    = 1
      max_length    = 63
      scope         = "Resource Group"
      regex         = "^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]?$"
    }
    event_hub_namespace = {
      abbreviation  = "evhns"
      allows_dashes = true
      min_length    = 1
      max_length    = 50
      scope         = "Global"
      regex         = "^[a-zA-Z0-9][a-zA-Z0-9-_]*[a-zA-Z0-9]?$"
    }
    event_hub = {
      abbreviation  = "evh"
      allows_dashes = true
      min_length    = 1
      max_length    = 256
      scope         = "Event Hub Namespace"
      regex         = "^[a-zA-Z0-9][a-zA-Z0-9._-]*[a-zA-Z0-9]?$"
    }
    event_grid_domain = {
      abbreviation  = "evgd"
      allows_dashes = true
      min_length    = 1
      max_length    = 50
      scope         = "Resource Group"
      regex         = "^[a-zA-Z0-9-]*[a-zA-Z0-9]?$"
    }
    iot_hub = {
      abbreviation  = "iot"
      allows_dashes = true
      min_length    = 3
      max_length    = 50
      scope         = "Global"
      regex         = "^[a-z0-9][a-z0-9-]*[a-z0-9]$"
    }

    # -----------------------------------------------------
    # Compute and Web
    # -----------------------------------------------------

    app_service_plan = {
      abbreviation  = "asp"
      allows_dashes = true
      min_length    = 1
      max_length    = 40
      scope         = "Resource Group"
      regex         = "^[a-zA-Z0-9-]*$"
    }
    availability_set = {
      abbreviation  = "avail"
      allows_dashes = true
      min_length    = 1
      max_length    = 80
      scope         = "Resource Group"
      regex         = "^[a-zA-Z0-9-_.]*$"
    }
    function_app = {
      abbreviation  = "func"
      allows_dashes = true
      min_length    = 1
      max_length    = 60
      scope         = "Global"
      regex         = "^[a-z0-9][a-z0-9-]*[a-z0-9]?$"
    }
    image_template = {
      abbreviation  = "it"
      allows_dashes = true
      min_length    = 1
      max_length    = 64
      scope         = "Resource Group"
      regex         = "^[a-zA-Z0-9-_]*$"
    }
    static_web_app = {
      abbreviation  = "stapp"
      allows_dashes = true
      min_length    = 1
      max_length    = 60
      scope         = "Global"
      regex         = "^[a-zA-Z0-9-]*$"
    }
    virtual_machine = {
      abbreviation  = "vm"
      allows_dashes = true
      min_length    = 1
      max_length    = 15
      scope         = "Resource Group"
      regex         = "^[a-zA-Z0-9-]*$"
    }
    virtual_machine_scale_set = {
      abbreviation  = "vmss"
      allows_dashes = true
      min_length    = 1
      max_length    = 15
      scope         = "Resource Group"
      regex         = "^[a-zA-Z][a-zA-Z0-9-]*$"
    }
    web_app = {
      abbreviation  = "app"
      allows_dashes = true
      min_length    = 1
      max_length    = 60
      scope         = "Global"
      regex         = "^[a-z0-9][a-z0-9-]*[a-z0-9]?$"
    }

    # -----------------------------------------------------
    # Containers
    # -----------------------------------------------------

    aks_cluster = {
      abbreviation  = "aks"
      allows_dashes = true
      min_length    = 1
      max_length    = 63
      scope         = "Resource Group"
      regex         = "^[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?$"
    }
    container_apps = {
      abbreviation  = "ca"
      allows_dashes = true
      min_length    = 1
      max_length    = 63
      scope         = "Resource Group"
      regex         = "^[a-z][a-z0-9-]*[a-z0-9]?$"
    }
    container_registry = {
      abbreviation  = "cr"
      allows_dashes = false
      min_length    = 5
      max_length    = 50
      scope         = "Global"
      regex         = "^[a-zA-Z0-9]*$"
    }

    # -----------------------------------------------------
    # Databases
    # -----------------------------------------------------

    cosmos_db_sql = {
      abbreviation  = "cosmos"
      allows_dashes = true
      min_length    = 3
      max_length    = 44
      scope         = "Global"
      regex         = "^[a-z0-9][a-z0-9-]*[a-z0-9]?$"
    }
    cache_redis = {
      abbreviation  = "redis"
      allows_dashes = true
      min_length    = 1
      max_length    = 63
      scope         = "Global"
      regex         = "^[a-z0-9][a-z0-9-]*[a-z0-9]?$"
    }
    sql_server = {
      abbreviation  = "sql"
      allows_dashes = true
      min_length    = 1
      max_length    = 63
      scope         = "Global"
      regex         = "^[a-z0-9][a-z0-9-]*[a-z0-9]?$"
    }
    sql_database = {
      abbreviation  = "sqldb"
      allows_dashes = true
      min_length    = 1
      max_length    = 128
      scope         = "SQL Server"
      regex         = "^[a-zA-Z0-9@_-]*$"
    }
    mysql_server = {
      abbreviation  = "mysql"
      allows_dashes = true
      min_length    = 3
      max_length    = 63
      scope         = "Global"
      regex         = "^[a-z0-9][a-z0-9-]*[a-z0-9]?$"
    }
    postgresql_server = {
      abbreviation  = "psql"
      allows_dashes = true
      min_length    = 3
      max_length    = 63
      scope         = "Global"
      regex         = "^[a-z0-9][a-z0-9-]*[a-z0-9]?$"
    }

    # -----------------------------------------------------
    # Integration
    # -----------------------------------------------------

    api_management = {
      abbreviation  = "apim"
      allows_dashes = true
      min_length    = 1
      max_length    = 50
      scope         = "Global"
      regex         = "^[a-zA-Z]([a-zA-Z0-9-]*[a-zA-Z0-9])?$"
    }
    service_bus_namespace = {
      abbreviation  = "sbns"
      allows_dashes = true
      min_length    = 6
      max_length    = 50
      scope         = "Global"
      regex         = "^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]?$"
    }
    logic_app = {
      abbreviation  = "logic"
      allows_dashes = true
      min_length    = 1
      max_length    = 80
      scope         = "Resource Group"
      regex         = "^[a-zA-Z0-9-_]*$"
    }

    # -----------------------------------------------------
    # Management and Governance
    # -----------------------------------------------------

    automation_account = {
      abbreviation  = "aa"
      allows_dashes = true
      min_length    = 6
      max_length    = 50
      scope         = "Resource Group"
      regex         = "^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]?$"
    }
    app_insights = {
      abbreviation  = "appi"
      allows_dashes = true
      min_length    = 1
      max_length    = 260
      scope         = "Resource Group"
      regex         = "^[a-zA-Z0-9-_.() ]*$"
    }
    log_analytics = {
      abbreviation  = "log"
      allows_dashes = true
      min_length    = 4
      max_length    = 63
      scope         = "Resource Group"
      regex         = "^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]?$"
    }

    # -----------------------------------------------------
    # Networking
    # -----------------------------------------------------

    application_gateway = {
      abbreviation  = "agw"
      allows_dashes = true
      min_length    = 1
      max_length    = 80
      scope         = "Resource Group"
      regex         = "^[a-zA-Z0-9-_]*$"
    }
    azure_firewall = {
      abbreviation  = "afw"
      allows_dashes = true
      min_length    = 1
      max_length    = 80
      scope         = "Resource Group"
      regex         = "^[a-zA-Z0-9-_]*$"
    }
    cdn_profile = {
      abbreviation  = "cdnp"
      allows_dashes = true
      min_length    = 1
      max_length    = 260
      scope         = "Resource Group"
      regex         = "^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]?$"
    }
    firewall_policy = {
      abbreviation  = "afwp"
      allows_dashes = true
      min_length    = 1
      max_length    = 80
      scope         = "Resource Group"
      regex         = "^[a-zA-Z0-9-_]*$"
    }
    load_balancer = {
      abbreviation  = "lb"
      allows_dashes = true
      min_length    = 1
      max_length    = 80
      scope         = "Resource Group"
      regex         = "^[a-zA-Z0-9-_]*$"
    }
    network_interface = {
      abbreviation  = "nic"
      allows_dashes = true
      min_length    = 1
      max_length    = 80
      scope         = "Resource Group"
      regex         = "^[a-zA-Z0-9-_]*$"
    }
    network_security_group = {
      abbreviation  = "nsg"
      allows_dashes = true
      min_length    = 1
      max_length    = 80
      scope         = "Resource Group"
      regex         = "^[a-zA-Z0-9-_]*$"
    }
    public_ip = {
      abbreviation  = "pip"
      allows_dashes = true
      min_length    = 1
      max_length    = 80
      scope         = "Resource Group"
      regex         = "^[a-zA-Z0-9-_]*$"
    }
    virtual_network = {
      abbreviation  = "vnet"
      allows_dashes = true
      min_length    = 2
      max_length    = 64
      scope         = "Resource Group"
      regex         = "^[a-zA-Z0-9-_]*$"
    }
    subnet = {
      abbreviation  = "snet"
      allows_dashes = true
      min_length    = 1
      max_length    = 80
      scope         = "Virtual Network"
      regex         = "^[a-zA-Z0-9-_]*$"
    }

    # -----------------------------------------------------
    # Security
    # -----------------------------------------------------

    key_vault = {
      abbreviation  = "kv"
      allows_dashes = true
      min_length    = 3
      max_length    = 24
      scope         = "Global"
      regex         = "^[a-zA-Z0-9-]*$"
    }
    managed_identity = {
      abbreviation  = "id"
      allows_dashes = true
      min_length    = 3
      max_length    = 128
      scope         = "Resource Group"
      regex         = "^[a-zA-Z0-9-]*$"
    }

    # -----------------------------------------------------
    # Storage
    # -----------------------------------------------------

    storage_account = {
      abbreviation  = "st"
      allows_dashes = false
      min_length    = 3
      max_length    = 24
      scope         = "Global"
      regex         = "^[a-z0-9]*$"
    }
    storage_sync = {
      abbreviation  = "sss"
      allows_dashes = true
      min_length    = 1
      max_length    = 260
      scope         = "Resource Group"
      regex         = "^[a-zA-Z0-9][a-zA-Z0-9-_.]*[a-zA-Z0-9]?$"
    }
  }
}

# -----------------------------------------------------------------------------
# Helper function to generate resource names
# -----------------------------------------------------------------------------

locals {
  # Create naming generator function with and without unique suffix
  generate_name = {
    with_dashes = {
      base_without_unique = "${local.components.workload}${var.environment != null ? "-${local.components.environment}" : ""}${local.components.region != null ? "-${local.components.region}" : ""}${local.components.instance != null ? "-${local.components.instance}" : ""}"
      base_with_unique    = "${local.components.workload}-${local.components.unique}${var.environment != null ? "-${local.components.environment}" : ""}${local.components.region != null ? "-${local.components.region}" : ""}${local.components.instance != null ? "-${local.components.instance}" : ""}"
    }
    without_dashes = {
      base_without_unique = "${local.components.workload}${var.environment != null ? local.components.environment : ""}${local.components.region != null ? local.components.region : ""}${local.components.instance != null ? local.components.instance : ""}"
      base_with_unique    = "${local.components.workload}${local.components.unique}${var.environment != null ? local.components.environment : ""}${local.components.region != null ? local.components.region : ""}${local.components.instance != null ? local.components.instance : ""}"
    }
  }
}

# -----------------------------------------------------------------------------
# Function to generate a resource name
# -----------------------------------------------------------------------------

locals {
  name_generator = merge(
    {
      for resource_type, config in local.resource_types : resource_type => {
        abbreviation  = config.abbreviation
        allows_dashes = config.allows_dashes
        min_length    = config.min_length
        max_length    = config.max_length
        scope         = config.scope
        regex         = config.regex
        # Name without unique suffix
        name = config.allows_dashes ? "${config.abbreviation}-${local.generate_name.with_dashes.base_without_unique}" : "${config.abbreviation}${local.generate_name.without_dashes.base_without_unique}"
        # Unique name includes the unique suffix
        unique_name = config.allows_dashes ? "${config.abbreviation}-${local.generate_name.with_dashes.base_with_unique}" : "${config.abbreviation}${local.generate_name.without_dashes.base_with_unique}"
      }
    }
  )
}