# GitHub Actions Workflow Generation Prompt

Use this prompt with GitHub Copilot to generate CI/CD workflows for your Terraform project:

---

## Prompt for Copilot

I need you to generate a complete GitHub Actions CI/CD pipeline for a public Terraform module hosted on the Terraform Registry. The module is for Azure resources and requires Terraform >= 1.9.

### Requirements:

**Workflow 1: Validate (validate.yml)**
- Trigger: Pull requests (opened, synchronize, reopened), push to main, manual
- Jobs:
  1. Code Quality: Run terraform init -backend=false, terraform fmt -check, terraform validate, and tflint
  2. Security Scan: Run tfsec with SARIF output to tfsec.sarif
  3. CodeQL: Use github/codeql-action@v3 for security vulnerability detection
  4. Module Structure: Validate README.md, examples/, tests/ directories exist
- Use Terraform v1.9
- Upload SARIF files from tflint and tfsec (conditional, if files exist)
- Use these action versions: hashicorp/setup-terraform@v3, aquasecurity/tfsec-action@v1.0.6, github/codeql-action@v3

**Workflow 2: Test (test.yml)**
- Trigger: Pull requests (opened, synchronize, reopened), push to main, manual
- Jobs:
  1. Terraform Test: Run terraform test -verbose with Terraform v1.9, upload test logs to artifacts
  2. Examples Validation: For each example in examples/ directory, run terraform init, validate, and plan with subscription_id variable using TEST_SUBSCRIPTION_ID secret. Include Azure login with AZURE_CREDENTIALS secret.
  3. Test Summary: Download all artifacts, create step summary, comment on PRs with results
- Use actions/upload-artifact@v4 and actions/download-artifact@v4
- Add fail-fast: false for matrix strategy
- Include retention-days for artifacts

**Workflow 3: Release (release.yml)**
- Trigger: Push to main, manual with optional version input
- Jobs:
  1. Analyze commits since last tag using git log
  2. Determine version bump based on conventional commits:
     - BREAKING CHANGE: = major bump
     - feat: = minor bump
     - fix: = patch bump
  3. Skip if commits contain [skip release]
  4. Generate changelog entry from commit messages
  5. Update CHANGELOG.md with new entry
  6. Create git tag (v{major}.{minor}.{patch})
  7. Create GitHub Release with changelog
- Use semantic versioning
- Configure Git user for commits
- Include installation example in release body

**Workflow 4: Quality (quality.yml)**
- Trigger: Pull requests (opened, synchronize, reopened), push to main, scheduled daily, manual
- Jobs:
  1. Code Quality: Run Trivy to scan for vulnerabilities, TruffleHog to detect secrets
  2. Documentation: Verify README.md and CONTRIBUTING.md exist
  3. Dependency Check: Validate terraform version constraints in code
- Schedule: Daily at 2:00 AM UTC
- Continue on error for non-blocking checks

### Configuration Files Needed:

1. `.tflint.hcl`: Configure terraform plugin with source = "github.com/terraform-linters/tflint-ruleset-terraform" and version = "0.3.0"
2. `.tfsec.yaml`: Configure for SARIF output format with WARNING severity minimum
3. `.github/dependabot.yml`: Enable automated updates for GitHub Actions and terraform providers

### GitHub Secrets Required:
- TEST_SUBSCRIPTION_ID: Azure subscription ID for testing
- AZURE_CREDENTIALS: JSON-formatted Azure service principal with clientId, clientSecret, subscriptionId, tenantId

### Important Notes:
- All workflows must use v4 of artifact actions (not deprecated v3)
- Terraform version must be 1.9+ for avm module compatibility
- Release workflow should add [skip release] to its commit to prevent loops
- Example plans should use ARM_SUBSCRIPTION_ID environment variable
- CodeQL should use v3 (v2 is deprecated)
- Include proper error handling and allow conditional failures where appropriate
- Add GitHub step summaries and PR comments for visibility

Generate the complete workflow files, configuration files, and ensure they follow GitHub Actions best practices.

---

## How to Use This Prompt

1. Copy the entire prompt above
2. Open GitHub Copilot chat in VS Code
3. Paste the prompt
4. Ask Copilot to generate the workflows
5. Review the generated files before committing
6. Adjust paths, tool versions, and terraform versions as needed for your specific project

## Customization Tips

Before using the prompt, update these values for your specific project:

- **Terraform Version**: Change `1.9` if your module requires a different version
- **Tool Versions**: 
  - Update `aquasecurity/tfsec-action@v1.0.6` if a newer version is available
  - Update `github/codeql-action@v3` version as needed
  - Update TFLint version from `0.3.0` if newer versions are released
- **Schedule**: Change `cron: '0 2 * * *'` in quality.yml to different time if needed
- **Azure Resources**: Adjust example paths from `examples/${{ matrix.example }}` if your examples are in a different location
- **Retention Days**: Modify artifact `retention-days` values based on your needs

## Post-Generation Steps

After generating the workflows:

1. **Review each workflow file** for correctness and adjust trigger conditions
2. **Create GitHub secrets** in your repository:
   - Navigate to Settings → Secrets and variables → Actions
   - Add TEST_SUBSCRIPTION_ID and AZURE_CREDENTIALS
3. **Test locally**: Run `terraform test` and `terraform fmt -check` to ensure compatibility
4. **Commit configuration files**: Add .tflint.hcl, .tfsec.yaml, .github/dependabot.yml
5. **Create branch protection rules**: Require workflow status checks before merging
6. **Add badges** to main README.md pointing to workflow status

