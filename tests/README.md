# Tests

This directory contains comprehensive test suites for the Azure Resource Naming module using Terraform's native testing framework.

## Overview

The test suite ensures:
- **Naming Convention Compliance** - All generated names follow Azure naming rules
- **Metadata Accuracy** - Validation metadata is correct for each resource type
- **Input Validation** - Variable constraints are properly enforced
- **Resource Type Support** - 59+ resource types generate valid names
- **Edge Cases** - Module handles boundary conditions correctly
- **Integration** - Multiple resource types work together correctly

## Test Organization

### [naming.tftest.hcl](naming.tftest.hcl)

**Core naming generation and composition tests**

Validates the fundamental naming logic:
- ✅ Basic naming with all components (workload, environment, region, instance)
- ✅ Minimal naming (only required workload parameter)
- ✅ Different unique suffix lengths (1-4 characters)
- ✅ Deterministic seeding for reproducibility
- ✅ Instance number formatting (zero-padded to 3 digits)
- ✅ Exclusion of instance number when set to 0
- ✅ Distinction between `name` and `unique_name` outputs

**Test Runs:**
- `basic_naming_with_all_components` - Full naming with all parameters
- `naming_with_minimal_components` - Only workload, no environment/region
- `naming_with_unique_length_1` - Single-character unique suffix
- `naming_with_unique_length_4` - Four-character unique suffix
- `naming_reproducibility_seed_v1` - Deterministic naming with seeds
- `naming_with_instance_number` - Instance number handling
- `naming_with_instance_number_zero` - Exclusion when instance=0

### [resource_types.tftest.hcl](resource_types.tftest.hcl)

**Resource-type-specific naming rules validation**

Tests Azure's unique naming constraints for different resource categories:
- ✅ Storage Account (no dashes allowed, global uniqueness)
- ✅ Container Registry (alphanumeric only, global scope)
- ✅ Web App (allows dashes, global scope)
- ✅ Virtual Machine (allows dashes, resource group scope, 15-char limit)
- ✅ Key Vault (allows dashes, global scope, 3-24 char limit)
- ✅ SQL Server (allows dashes, global scope)
- ✅ Virtual Network (allows dashes, resource group scope)
- ✅ Function App (lowercase alphanumeric with dashes, global scope)
- ✅ All resource-specific minimum and maximum length constraints
- ✅ Proper handling of dash/no-dash requirements

**Test Runs:**
- `storage_account_no_dashes` - Storage account constraints
- `container_registry_constraints` - Container registry rules
- `web_app_naming_rules` - Web app naming requirements
- `virtual_machine_naming_rules` - VM length and scope
- `key_vault_naming_rules` - Key vault constraints
- `sql_server_naming_rules` - SQL server rules
- `virtual_network_naming_rules` - VNET naming
- `function_app_naming_rules` - Function app rules

### [metadata.tftest.hcl](metadata.tftest.hcl)

**Output structure and validation metadata tests**

Validates that all outputs have complete and correct metadata:
- ✅ Correct slug/abbreviation for each resource type
- ✅ Present `name` and `unique_name` fields
- ✅ Present `allows_dashes` boolean flag
- ✅ Present `slug` abbreviation
- ✅ Present `min_length` and `max_length` constraints
- ✅ Present `scope` information (Global, Resource Group, Subscription, etc.)
- ✅ Present `regex` validation pattern
- ✅ Name length constraints are respected
- ✅ Scope values are correct (Global, Resource Group, etc.)

**Test Runs:**
- `output_metadata_structure` - All resource slugs correct
- `metadata_fields_completeness` - All fields present
- `name_length_constraints` - Names respect min/max lengths
- `scope_values_validation` - Scope values are accurate
- `regex_validation_compliance` - Names match regex patterns

### [validation.tftest.hcl](validation.tftest.hcl)

**Input variable validation and constraint enforcement**

Tests that invalid inputs are properly rejected and valid edge cases are accepted:

**Invalid Input Tests (should fail):**
- ❌ `invalid_workload_length_too_long` - Workload exceeds 20 characters
- ❌ `invalid_workload_uppercase` - Workload contains uppercase
- ❌ `invalid_environment_length` - Environment exceeds 10 characters
- ❌ `invalid_environment_uppercase` - Environment contains uppercase
- ❌ `invalid_unique_length_below_minimum` - unique_length < 1
- ❌ `invalid_unique_length_above_maximum` - unique_length > 4
- ❌ `invalid_instance_number_negative` - instance_number < 0
- ❌ `invalid_instance_number_too_large` - instance_number > 999

**Valid Edge Case Tests (should succeed):**
- ✅ `valid_minimum_workload` - Single character workload
- ✅ `valid_maximum_workload` - 20 character workload
- ✅ `valid_null_environment` - null environment parameter
- ✅ `valid_null_region` - null region parameter
- ✅ `valid_unique_length_minimum` - unique_length=1
- ✅ `valid_unique_length_maximum` - unique_length=4
- ✅ `valid_instance_number_zero` - instance_number=0 (excluded)

### [integration.tftest.hcl](integration.tftest.hcl)

**Multi-resource and real-world scenario tests**

Tests how the module performs with multiple resource types and realistic configurations:
- ✅ Multi-resource naming consistency (same workload across resource types)
- ✅ Environment variations (dev, staging, prod with same seed)
- ✅ No dash constraint compliance (storage, container registry)
- ✅ Global scope uniqueness consistency
- ✅ Resource group scoped naming
- ✅ Real-world multi-environment deployments

**Test Runs:**
- `multi_resource_naming` - Multiple resource types together
- `environment_variations_prod` - Production environment setup
- `environment_variations_staging` - Staging environment setup
- `environment_variations_dev` - Development environment setup
- `constraint_compliance_multi_resource` - Constraint consistency

## Running Tests

### Run All Tests

```bash
# From the module root directory
terraform test

# With verbose output
terraform test -verbose

# Show detailed test run information
terraform test -json
```

### Run Specific Test File

```bash
# Run only naming tests
terraform test -filter=naming.tftest.hcl

# Run only validation tests
terraform test -filter=validation.tftest.hcl

# Run only resource type tests
terraform test -filter=resource_types.tftest.hcl
```

### Run Specific Test Run

```bash
# Run single test by name
terraform test -run=basic_naming_with_all_components

# Run tests matching pattern
terraform test -run='naming_with_*'
```

### Debug Test Failures

```bash
# Show full debug output
TF_LOG=DEBUG terraform test

# Save debug logs to file
TF_LOG=DEBUG TF_LOG_PATH=terraform-debug.log terraform test

# Check specific assertion failure
terraform test -verbose
```

## Test Structure

Each test file follows this pattern:

```terraform-test
# Test description
run "test_name" {
  command = apply  # or plan

  # Input variables
  variables {
    workload = "test"
    # ... other variables
  }

  # Validation assertions
  assert {
    condition     = output.web_app.name != ""
    error_message = "Descriptive failure message"
  }
}
```

### Key Assertions

Tests use these common assertion patterns:

```terraform-test
# String matching
assert {
  condition     = startswith(output.web_app.name, "app-")
  error_message = "Name should start with abbreviation"
}

# Exact value matching
assert {
  condition     = output.web_app.slug == "app"
  error_message = "Slug should be 'app'"
}

# Numeric constraints
assert {
  condition     = length(output.web_app.name) <= output.web_app.max_length
  error_message = "Name exceeds maximum length"
}

# Pattern matching
assert {
  condition     = length(regexall("-\\d{4}$", output.web_app.unique_name)) > 0
  error_message = "Should end with 4-digit suffix"
}

# Boolean checks
assert {
  condition     = output.web_app.allows_dashes == true
  error_message = "Should allow dashes"
}
```

## Test Coverage

| Category | Tests | Coverage |
|----------|-------|----------|
| Naming Generation | 7 | Core naming logic with various parameters |
| Resource Types | 8 | 8+ specific resource type constraints |
| Validation | 15 | Input constraints and edge cases |
| Integration | 5 | Multi-resource scenarios |
| Metadata | 5 | Output structure and values |
| **Total** | **40+** | **Comprehensive module validation** |

## Expected Test Results

### Success Criteria

All tests should pass with:
```
3 passed in 15s
```

Output shows:
- ✅ `naming.tftest.hcl` passes
- ✅ `resource_types.tftest.hcl` passes
- ✅ `validation.tftest.hcl` passes
- ✅ `integration.tftest.hcl` passes
- ✅ `metadata.tftest.hcl` passes

### Test Failure Investigation

If a test fails:

1. **Read the error message** - Clearly indicates which assertion failed and why
2. **Check variables** - Verify the variables in the failing test
3. **Review assertions** - Look at the condition that failed
4. **Check module code** - Review [main.tf](../main.tf) for the related logic
5. **Run in verbose mode** - Use `terraform test -verbose` for detailed output

## Common Test Patterns

### Testing Name Components

```terraform-test
assert {
  condition     = strcontains(output.web_app.name, "testapp")
  error_message = "Name should include workload"
}

assert {
  condition     = strcontains(output.web_app.name, "dev")
  error_message = "Name should include environment"
}
```

### Testing Constraints

```terraform-test
assert {
  condition     = length(output.storage_account.name) >= 3
  error_message = "Name too short"
}

assert {
  condition     = length(output.storage_account.name) <= 24
  error_message = "Name too long"
}
```

### Testing Formatting

```terraform-test
assert {
  condition     = !strcontains(output.storage_account.name, "-")
  error_message = "Storage account names cannot contain dashes"
}

assert {
  condition     = strcontains(output.web_app.name, "001")
  error_message = "Instance number should be zero-padded"
}
```

## Test Data and Fixtures

The tests use consistent test data:

**Module Variables:**
- `workload` - Usually "test", "app", "myapp", "server", "sec", "data", "core"
- `environment` - "dev", "prod", "staging", null
- `region` - "eastus", "westus", "westeurope", null
- `unique_seed` - Deterministic values like "test", "prod", "webapp", "vm"
- `unique_length` - 1, 2, 3, or 4
- `instance_number` - 0, 1, 5

**Expected Outputs:**
Names follow patterns like:
- With dashes: `app-testapp-dev-eus-0001`
- Without dashes: `stmyappdev0001`
- Unique names: `app-testapp-dev-eus-5c4t`

## Extending Tests

To add new tests:

1. **Create a new run block** in the appropriate `.tftest.hcl` file
2. **Set test variables** for the scenario being tested
3. **Add assertions** validating the expected behavior
4. **Use descriptive names** following existing patterns
5. **Include error messages** that explain the failure

Example new test:

```terraform-test
run "new_naming_scenario" {
  command = apply

  variables {
    workload        = "custom"
    environment     = "staging"
    region          = "westeurope"
    unique_seed     = "new-scenario"
    instance_number = 3
  }

  assert {
    condition     = strcontains(output.web_app.name, "staging")
    error_message = "Should include staging environment"
  }

  assert {
    condition     = strcontains(output.web_app.name, "003")
    error_message = "Should format instance as 003"
  }
}
```

## Troubleshooting Test Issues

### Test Hangs

If tests appear to hang:
```bash
# Cancel with Ctrl+C
# Then check for terraform lock files
ls -la .terraform.lock.hcl
rm .terraform.lock.hcl

# Retry
terraform test
```

### Provider Issues

If you get "invalid provider" errors:
```bash
# Upgrade providers
terraform init -upgrade

# Clear provider cache
rm -rf .terraform/providers

# Reinitialize
terraform init
```

### Variable Constraint Failures

If validation tests fail unexpectedly:
```bash
# Review variable definitions in variables.tf
cat variables.tf

# Check validation rules
terraform validate
```

## CI/CD Integration

These tests are designed for automated testing:

```bash
# GitHub Actions example
- name: Run Terraform Tests
  run: |
    terraform init
    terraform test
```

## Performance

Test execution time:
- **Quick run** (terraform test): ~15-30 seconds
- **With cleanup**: ~30-60 seconds
- **Full test suite**: Completes in <1 minute

Tests are optimized to:
- Minimize API calls (local naming generation only)
- Use `plan` instead of `apply` where appropriate
- Run in parallel where safe

## Best Practices for Testing

1. **Keep tests focused** - Each test validates one specific behavior
2. **Use clear variable names** - Make it obvious what's being tested
3. **Write descriptive errors** - Help developers understand failures
4. **Test edge cases** - Boundary conditions are important
5. **Update tests with code** - When module changes, update tests
6. **Review test output** - Use verbose mode to understand what's happening

## Resources

- [Terraform Testing Documentation](https://developer.hashicorp.com/terraform/language/tests)
- [Module Main Logic](../main.tf)
- [Variable Definitions](../variables.tf)
- [Output Definitions](../outputs.tf)
- [Azure Naming Rules](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules)
