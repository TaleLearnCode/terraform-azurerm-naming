# Contributing to Azure Resource Naming Module

Thank you for your interest in contributing to the Azure Resource Naming module! This document provides guidelines for contributing code, documentation, and other improvements.

## Code of Conduct

This project adheres to the Contributor Covenant Code of Conduct. By participating, you are expected to uphold this code.

## Getting Started

### Prerequisites

- **Terraform**: Version 1.6 or later
- **Git**: For version control
- **GitHub Account**: To fork and submit PRs

### Setup Development Environment

1. **Fork the Repository**
   ```bash
   # Click "Fork" on GitHub
   git clone https://github.com/YOUR-USERNAME/terraform-azurerm-naming.git
   cd terraform-azurerm-naming
   ```

2. **Create a Feature Branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or for fixes:
   git checkout -b fix/your-fix-name
   ```

3. **Install Development Tools**
   ```bash
   # Terraform (via tfenv recommended)
   brew install tfenv
   tfenv install 1.8
   
   # TFLint
   brew install tflint
   
   # TFSec
   brew install tfsec
   ```

## Workflow for Contributions

### 1. Make Your Changes

**For New Features:**
```hcl
# Example: Adding support for a new resource type
# File: main.tf

resource_type_name = {
  abbreviation  = "xxx"
  allows_dashes = true
  min_length    = X
  max_length    = X
  scope         = "Resource Group"
  regex         = "^[a-zA-Z0-9-]*$"
}
```

**For Bug Fixes:**
- Identify the issue
- Write a test case that reproduces the bug
- Fix the code
- Verify test passes

### 2. Format and Validate Locally

Before submitting a PR, run these checks locally:

```bash
# Format code
terraform fmt -recursive

# Validate syntax
terraform validate

# Run TFLint
tflint

# Run TFSec
tfsec .

# Run tests
terraform test
```

### 3. Write or Update Tests

All changes should include appropriate tests.

**Test file locations:**
- Unit tests: `/tests/naming.tftest.hcl`
- Resource-specific tests: `/tests/resource_types.tftest.hcl`
- Input validation: `/tests/validation.tftest.hcl`
- Integration tests: `/tests/integration.tftest.hcl`

**Example test:**
```terraform-test
run "my_new_test" {
  command = apply

  variables {
    workload        = "test"
    environment     = "dev"
    region          = "eastus"
    unique_seed     = "myseed"
  }

  assert {
    condition     = output.web_app.name != ""
    error_message = "Should generate a name"
  }
}
```

### 4. Update Documentation

- **main.tf changes** → Update code comments
- **variables.tf changes** → Update variable descriptions
- **outputs.tf changes** → Update output descriptions
- **New resource types** → Update README.md examples
- **New features** → Update CHANGELOG.md (in PR description)

### 5. Commit with Conventional Commits

Use conventional commit format for clear commit history:

```bash
# Feature
git commit -m "feat: add support for new resource type"

# Bug fix
git commit -m "fix: correct naming logic for storage accounts"

# Documentation
git commit -m "docs: update README with new examples"

# Tests
git commit -m "test: add validation for edge case"

# Chore
git commit -m "chore: update dependencies"

# Breaking change
git commit -m "feat: refactor naming algorithm

BREAKING CHANGE: Output format changed from X to Y"
```

### 6. Push and Create Pull Request

```bash
git push origin feature/your-feature-name
```

Then create a PR on GitHub with:

- **Title**: Clear description of changes
- **Description**: Why this change is needed
- **Related Issues**: References to issues (Fixes #123)
- **Type**: feat, fix, docs, test, chore

### 7. Automated Checks

GitHub Actions will automatically run:

- ✅ **Validate Workflow**
  - `terraform fmt -check`
  - `terraform validate`
  - `tflint`
  - `tfsec`
  - Module structure validation

- ✅ **Test Workflow**
  - `terraform test` on Terraform 1.6, 1.7, 1.8
  - Example validation on Terraform 1.6, 1.8

- ✅ **Code Quality Workflow**
  - Vulnerability scanning
  - Secret detection
  - Documentation check

### 8. Address Review Feedback

- Make requested changes
- Commit and push (PR updates automatically)
- Respond to comments
- Request re-review

### 9. Merge and Release

Once approved and all checks pass:

1. **Maintainer merges your PR** to main branch
2. **Release workflow automatically:**
   - Detects semantic version (feat = minor, fix = patch)
   - Creates Git tag
   - Updates CHANGELOG.md
   - Creates GitHub Release

## Commit Message Guidelines

### Format
```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types
- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation only changes
- **style**: Changes that don't affect code meaning (formatting, etc.)
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **perf**: A code change that improves performance
- **test**: Adding missing tests or correcting existing tests
- **chore**: Changes to build process, dependencies, etc.

### Scope
- `naming` - Core naming logic
- `examples` - Examples
- `tests` - Test suite
- `docs` - Documentation
- `ci` - CI/CD workflows
- `deps` - Dependencies

### Subject
- Use imperative mood ("add" not "added" or "adds")
- Don't capitalize first letter
- No period (.) at the end
- Limit to 50 characters

### Body
- Explain what and why, not how
- Wrap at 72 characters
- Separate from subject with blank line

### Footer
- Reference issues: `Fixes #123`, `Closes #456`
- Break changes: `BREAKING CHANGE: description`

### Example
```
feat(naming): add support for Azure Bastion

Add naming convention for Azure Bastion resource type.
Includes slug "bast", global scope, and dash support.

Fixes #123
```

## Testing Guidelines

### Running Tests Locally

```bash
# Run all tests
terraform test

# Run specific test file
terraform test -filter=naming.tftest.hcl

# Run specific test
terraform test -run=basic_naming_with_all_components

# Verbose output
terraform test -verbose
```

### Test Coverage

- **Unit tests**: Core naming logic
- **Resource type tests**: Each resource type constraints
- **Validation tests**: Input validation edge cases
- **Integration tests**: Multiple resources working together

### When to Add Tests

- ✅ Always add tests for new features
- ✅ Add tests when fixing bugs
- ✅ Update tests when changing outputs
- ✅ Add edge case tests

## Code Review Process

### What Reviewers Look For

1. **Code Quality**
   - Follows Terraform conventions
   - Clear variable/resource names
   - Proper comments

2. **Testing**
   - Comprehensive test coverage
   - Tests pass locally
   - Edge cases covered

3. **Documentation**
   - README updated if needed
   - Code comments clear
   - Examples work

4. **Security**
   - No hardcoded secrets
   - Proper input validation
   - Safe defaults

### Responding to Review Comments

- **Questions**: Clarify your approach
- **Suggestions**: Consider alternative approaches
- **Requests**: Make changes or explain why not
- **Approvals**: Address any remaining comments

## Updating Documentation

### README.md

When adding new features:

1. Add example in Usage section
2. Update Feature list
3. Update Inputs/Outputs tables
4. Add to Examples section

### examples/default/README.md

- Add examples using new resource type
- Update scenario documentation
- Test examples run successfully

### CHANGELOG.md

The release workflow automatically updates this, but note:

- Don't manually edit for new versions
- Maintain version format: `## [X.Y.Z] - YYYY-MM-DD`
- Include Added, Fixed, Changed sections

## Troubleshooting

### Local Tests Fail But CI Passes

```bash
# Clear Terraform cache
rm -rf .terraform .terraform.lock.hcl

# Reinitialize
terraform init

# Run tests again
terraform test
```

### Format Failures

```bash
# Auto-fix formatting
terraform fmt -recursive
```

### Provider Issues

```bash
# Upgrade providers
terraform init -upgrade

# Check versions
terraform version
```

## Release Process

### Understanding Semantic Versioning

The release automation uses conventional commits to determine version bumps:

- **v0.0.1 → v0.0.2**: `fix:` commits (patch)
- **v0.0.1 → v0.1.0**: `feat:` commits (minor)
- **v0.1.0 → v1.0.0**: `BREAKING CHANGE:` (major)

### Manual Release (if needed)

```bash
# Tag manually
git tag -a v0.1.0 -m "Release v0.1.0"
git push origin v0.1.0

# Or use GitHub Releases UI
```

### Skip Release

To skip release on a particular merge:

```bash
git commit -m "chore: update docs [skip release]"
```

## Getting Help

- **Issues**: Create GitHub issues for bugs or features
- **Discussions**: Use GitHub Discussions for questions
- **Email**: Contact maintainers directly if needed

## Code Style

### Terraform Style

```hcl
# Resources and variables: snake_case
resource "azurerm_resource_group" "example" {
  name     = "rg-example"
  location = "eastus"
}

variable "resource_name" {
  type = string
}

# Locals: Use for computed values
locals {
  resource_prefix = "rg"
  full_name      = "${local.resource_prefix}-${var.environment}"
}
```

### Comments

```hcl
# Single line comment

# Multi-line comment
# explaining complex logic
# across multiple lines

resource "example" "name" {
  # Explain the why, not the what
  property = "value"
}
```

## Additional Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [Azure Naming Conventions](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Module Best Practices](https://www.terraform.io/language/modules/develop)

## Questions?

Feel free to ask questions in:
- GitHub Issues
- GitHub Discussions
- Pull Request comments

Thank you for contributing! 🎉
