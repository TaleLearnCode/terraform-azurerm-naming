# GitHub Actions Workflows

This directory contains automated workflows for CI/CD, testing, security scanning, and release management for the Terraform Azure Naming module.

## 📋 Workflows Overview

### [validate.yml](workflows/validate.yml)
**Code Quality & Security Enforcement**

Runs on every push and pull request to ensure code quality and security standards.

**Triggers:**
- Pull requests (opened, synchronize, reopened)
- Push to main branch
- Manual trigger (workflow_dispatch)

**Jobs:**
- **Code Quality**: Runs Terraform fmt, validate, and TFLint checks
- **Security Scan**: Executes TFSec security scanning with SARIF output
- **CodeQL Analysis**: Detects potential security vulnerabilities
- **Module Structure**: Validates module organization and naming conventions

**Requirements:**
- Terraform v1.9+
- Valid HCL formatting
- All TFLint rules pass
- All TFSec security checks pass

**Artifacts:**
- `tflint.sarif` - TFLint results (on failure)
- `tfsec.sarif` - TFSec results (on failure)

---

### [test.yml](workflows/test.yml)
**Multi-Version Testing**

Validates the module and examples work correctly across supported environments.

**Triggers:**
- Pull requests (opened, synchronize, reopened)
- Push to main branch
- Manual trigger (workflow_dispatch)

**Jobs:**
- **Terraform Test**: Runs module tests using `terraform test` command
  - Tests: v1.9
  - Generates detailed test logs

- **Examples Validation**: Plans example configurations
  - Tests: v1.9
  - Examples: default
  - Validates that example configurations can be planned successfully
  
- **Test Summary**: Aggregates results and comments on PRs
  - Downloads all test artifacts
  - Posts summary to PR comments

**Requirements:**
- GitHub Secrets:
  - `TEST_SUBSCRIPTION_ID`: Azure subscription ID for testing
  - `AZURE_CREDENTIALS`: JSON-formatted Azure service principal credentials

**Artifacts:**
- `terraform-test-results-*`: Test execution logs
- `example-plan-*`: Terraform plan outputs

**Azure Authentication:**
Requires `AZURE_CREDENTIALS` secret with the following JSON format:
```json
{
  "clientId": "...",
  "clientSecret": "...",
  "subscriptionId": "...",
  "tenantId": "..."
}
```

---

### [release.yml](workflows/release.yml)
**Semantic Versioning & Release Management**

Automatically creates releases based on conventional commits.

**Triggers:**
- Push to main branch (after successful test/validate workflows)
- Manual trigger (workflow_dispatch) with optional version input

**Version Bumping Logic:**
- `BREAKING CHANGE:` in commit → Major version bump
- `feat:` prefix → Minor version bump
- `fix:` prefix → Patch version bump

**Jobs:**
- **Create Release**:
  1. Analyzes commits since the last tag
  2. Determines appropriate version bump
  3. Generates a changelog entry
  4. Updates CHANGELOG.md
  5. Creates a git tag and GitHub release

**Skip Release:**
Add `[skip release]` to the commit message to skip release creation:

```bash
git commit -m "chore: minor update [skip release]"
```

**Artifacts:**
- Git tag created: `v{major}.{minor}.{patch}`
- GitHub Release with changelog

**Conventional Commits Format:**
```
feat: short description           # Minor version bump
fix: short description            # Patch version bump
BREAKING CHANGE: description      # Major version bump
chore: short description          # No version bump
docs: short description           # No version bump
```

---

### [quality.yml](workflows/quality.yml)
**Security & Dependency Checks**

Scans for vulnerabilities, secrets, and outdated dependencies.

**Triggers:**
- Pull requests (opened, synchronize, reopened)
- Push to main branch
- Scheduled daily at 2:00 AM UTC
- Manual trigger (workflow_dispatch)

**Jobs:**
- **Code Quality**: Vulnerability and secret scanning
  - **Trivy**: Scans Terraform files for known vulnerabilities
  - **TruffleHog**: Detects accidentally committed secrets
  
- **Documentation**: Validates documentation requirements
  - Checks for README.md
  - Validates CONTRIBUTING.md exists
  
- **Dependency Check**: Reviews module dependencies
  - Validates terraform version constraints
  - Checks provider version constraints

**Artifacts:**
- Trivy vulnerability report (if issues found)
- TruffleHog scan results (if secrets detected)

---

## 🔧 Configuration Files

### [.tflint.hcl](../.tflint.hcl)
TFLint configuration for Terraform code linting and best practices enforcement.

**Key Rules:**
- Terraform syntax validation
- Naming convention enforcement
- Best practice checks
- Custom rules for module structure

**Update:**
Modify `.tflint.hcl` to adjust which linting rules are enforced.

---

### [.tfsec.yaml](../.tfsec.yaml)
TFSec configuration for security scanning and compliance checks.

**Features:**
- Scans for security misconfigurations
- Outputs in SARIF format for GitHub integration
- Configurable severity thresholds

**Update:**
Modify `.tfsec.yaml` to adjust security scanning rules and severity levels.

---

### [.github/dependabot.yml](dependabot.yml)
Automated dependency update configuration.

**Features:**
- Monitors GitHub Actions for updates
- Creates PRs for outdated actions
- Monitors Terraform provider updates

**Update:**
Modify `dependabot.yml` to adjust update frequency and targets.

---

## 🚀 Status Badges

Add these badges to your README.md to display workflow status:

```markdown
[![Validate](https://github.com/YOUR_ORG/naming/actions/workflows/validate.yml/badge.svg)](https://github.com/YOUR_ORG/naming/actions/workflows/validate.yml)
[![Test](https://github.com/YOUR_ORG/naming/actions/workflows/test.yml/badge.svg)](https://github.com/YOUR_ORG/naming/actions/workflows/test.yml)
[![Release](https://github.com/YOUR_ORG/naming/actions/workflows/release.yml/badge.svg)](https://github.com/YOUR_ORG/naming/actions/workflows/release.yml)
[![Quality](https://github.com/YOUR_ORG/naming/actions/workflows/quality.yml/badge.svg)](https://github.com/YOUR_ORG/naming/actions/workflows/quality.yml)
```

Replace `YOUR_ORG` with your GitHub organization/username.

---

## 📝 GitHub Secrets Required

Configure these secrets in your GitHub repository settings under **Settings → Secrets and variables → Actions**:

| Secret | Description | Example |
|--------|-------------|---------|
| `TEST_SUBSCRIPTION_ID` | Azure subscription ID for testing | `00000000-0000-0000-0000-000000000000` |
| `AZURE_CREDENTIALS` | Azure service principal credentials (JSON) | See test.yml section |
| `GITHUB_TOKEN` | Automatically provided by GitHub Actions | (Auto-configured) |

---

## 🔐 Setting up Azure Authentication

To enable Azure testing in the test workflow:

1. **Create an Azure Service Principal:**
   ```bash
   az ad sp create-for-rbac --name "terraform-ci" --role Contributor --scopes /subscriptions/{subscription-id}
   ```

2. **Create the AZURE_CREDENTIALS secret** with the output:
   ```json
   {
     "clientId": "...",
     "clientSecret": "...",
     "subscriptionId": "...",
     "tenantId": "..."
   }
   ```

3. **Create the TEST_SUBSCRIPTION_ID secret** with your subscription ID

---

## 📊 Workflow Status

View all workflows and their status in the [Actions tab](../../actions) of the repository.

### Recent Workflow Runs
- Latest push/PR triggers validate.yml → test.yml → quality.yml
- Main branch pushes additionally trigger release.yml
- Scheduled quality.yml runs daily

---

## 🐛 Troubleshooting

### Validation Failures
Check the validate.yml logs for:
- TFLint errors: See `.tflint.hcl` for rule configuration
- TFSec errors: See `.tfsec.yaml` for security rule configuration
- Format issues: Run `terraform fmt -recursive` locally

### Test Failures
Check test.yml logs for:
- Azure authentication errors: Verify `AZURE_CREDENTIALS` secret is configured
- Terraform version incompatibilities: Module requires Terraform >= 1.9
- Missing variables: Ensure `TEST_SUBSCRIPTION_ID` secret is set

### Release Issues
Check release.yml logs for:
- Commit format: Use [conventional commits](#releaseyml)
- Git configuration: Verify user.email and user.name are set
- Tag conflicts: Remove conflicting tags with `git tag -d {tag} && git push origin :refs/tags/{tag}`

---

## 📚 Additional Resources

- [Terraform Testing Documentation](https://developer.hashicorp.com/terraform/language/tests)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [TFLint Documentation](https://github.com/terraform-linters/tflint)
- [TFSec Documentation](https://aquasecurity.github.io/tfsec/)

---

## 📄 Contributing

See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines on submitting changes and working with these workflows.
