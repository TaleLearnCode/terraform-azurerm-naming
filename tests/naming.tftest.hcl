# Test basic naming generation with all components
run "basic_naming_with_all_components" {
  command = apply

  variables {
    workload        = "testapp"
    environment     = "dev"
    region          = "eastus"
    unique_length   = 4
    unique_seed     = "test"
    instance_number = 1
  }

  assert {
    condition     = startswith(output.web_app.name, "app-")
    error_message = "Web app name should start with 'app-' abbreviation"
  }

  assert {
    condition     = strcontains(output.web_app.name, "testapp")
    error_message = "Web app name should contain workload name"
  }

  assert {
    condition     = strcontains(output.web_app.name, "dev")
    error_message = "Web app name should contain environment"
  }

  assert {
    condition     = strcontains(output.web_app.name, "eus")
    error_message = "Web app name should contain region"
  }

  assert {
    condition     = output.web_app.allows_dashes == true
    error_message = "Web app should allow dashes"
  }

  # unique_name should include the unique suffix while name should not
  assert {
    condition     = output.web_app.unique_name != output.web_app.name
    error_message = "unique_name should differ from name by including the unique suffix"
  }
}

# Test naming with minimal components (only workload, no environment or region)
run "naming_with_minimal_components" {
  command = apply

  variables {
    workload    = "app"
    environment = null
    region      = null
    unique_seed = "min"
  }

  assert {
    condition     = startswith(output.web_app.name, "app-")
    error_message = "Web app name should start with abbreviation"
  }

  assert {
    condition     = strcontains(output.web_app.name, "app")
    error_message = "Web app name should contain workload"
  }

  assert {
    condition     = !strcontains(output.web_app.name, "-prod") && !strcontains(output.web_app.name, "-dev")
    error_message = "Name should not contain environment when null"
  }
}

# Test different unique_length values
run "naming_with_unique_length_1" {
  command = apply

  variables {
    workload        = "test"
    environment     = null
    region          = null
    instance_number = 0
    unique_length   = 1
    unique_seed     = "single"
  }

  assert {
    condition     = length(regexall("-\\d{1}$", output.web_app.unique_name)) > 0
    error_message = "unique_name should end with a single-digit unique suffix"
  }
}

run "naming_with_unique_length_4" {
  command = apply

  variables {
    workload        = "test"
    environment     = null
    region          = null
    instance_number = 0
    unique_length   = 4
    unique_seed     = "quad"
  }

  assert {
    condition     = length(regexall("-\\d{4}$", output.web_app.unique_name)) > 0
    error_message = "unique_name should end with a 4-digit unique suffix"
  }
}

# Test deterministic seeding for reproducibility
run "naming_reproducibility_seed_v1" {
  command = apply

  variables {
    workload    = "app"
    environment = "prod"
    unique_seed = "baseline"
  }

  assert {
    condition     = output.web_app.name != ""
    error_message = "Should generate a name with seed"
  }
}

# Test instance number formatting
run "naming_with_instance_number" {
  command = apply

  variables {
    workload        = "test"
    instance_number = 5
    unique_seed     = "inst"
  }

  assert {
    condition     = strcontains(output.web_app.name, "005")
    error_message = "Instance number should be zero-padded to 3 digits"
  }
}

# Test instance number exclusion when zero
run "naming_with_instance_number_zero" {
  command = apply

  variables {
    workload        = "test"
    instance_number = 0
    unique_seed     = "noinst"
  }

  assert {
    condition     = !strcontains(output.web_app.name, "-000") && !strcontains(output.web_app.name, "000-")
    error_message = "Should not include instance number when set to 0"
  }
}
