# Test input variable validation
run "invalid_workload_length_too_long" {
  command = plan

  variables {
    workload = "this-is-a-very-long-workload-name-that-exceeds-the-maximum"
  }

  expect_failures = [
    var.workload,
  ]
}

run "invalid_workload_uppercase" {
  command = plan

  variables {
    workload = "MyApp"
  }

  expect_failures = [
    var.workload,
  ]
}

run "invalid_environment_length" {
  command = plan

  variables {
    workload    = "app"
    environment = "this-environment-is-way-too-long-for-the-constraint"
  }

  expect_failures = [
    var.environment,
  ]
}

run "invalid_environment_uppercase" {
  command = plan

  variables {
    workload    = "app"
    environment = "PROD"
  }

  expect_failures = [
    var.environment,
  ]
}

run "invalid_unique_length_below_minimum" {
  command = plan

  variables {
    workload      = "app"
    unique_length = 0
  }

  expect_failures = [
    var.unique_length,
  ]
}

run "invalid_unique_length_above_maximum" {
  command = plan

  variables {
    workload      = "app"
    unique_length = 5
  }

  expect_failures = [
    var.unique_length,
  ]
}

run "invalid_instance_number_negative" {
  command = plan

  variables {
    workload        = "app"
    instance_number = -1
  }

  expect_failures = [
    var.instance_number,
  ]
}

run "invalid_instance_number_too_large" {
  command = plan

  variables {
    workload        = "app"
    instance_number = 1000
  }

  expect_failures = [
    var.instance_number,
  ]
}

# Test valid edge cases (should succeed)
run "valid_minimum_workload" {
  command = plan

  variables {
    workload = "a"
  }

  assert {
    condition     = output.web_app.name != ""
    error_message = "Should generate name with single character workload"
  }
}

run "valid_maximum_workload" {
  command = plan

  variables {
    workload = "a-very-long-workload"
  }

  assert {
    condition     = output.web_app.name != ""
    error_message = "Should generate name with 20 character workload"
  }
}

run "valid_null_environment" {
  command = plan

  variables {
    workload    = "app"
    environment = null
  }

  assert {
    condition     = output.web_app.name != ""
    error_message = "Should generate name with null environment"
  }
}

run "valid_null_region" {
  command = plan

  variables {
    workload = "app"
    region   = null
  }

  assert {
    condition     = output.web_app.name != ""
    error_message = "Should generate name with null region"
  }
}

run "valid_unique_length_minimum" {
  command = plan

  variables {
    workload      = "app"
    unique_length = 1
  }

  assert {
    condition     = output.web_app.name != ""
    error_message = "Should generate name with unique_length=1"
  }
}

run "valid_unique_length_maximum" {
  command = plan

  variables {
    workload      = "app"
    unique_length = 4
  }

  assert {
    condition     = output.web_app.name != ""
    error_message = "Should generate name with unique_length=4"
  }
}

run "valid_instance_number_zero" {
  command = plan

  variables {
    workload        = "app"
    instance_number = 0
  }

  assert {
    condition     = output.web_app.name != ""
    error_message = "Should generate name with instance_number=0"
  }
}

run "valid_instance_number_maximum" {
  command = plan

  variables {
    workload        = "app"
    instance_number = 999
  }

  assert {
    condition     = output.web_app.name != ""
    error_message = "Should generate name with instance_number=999"
  }
}
