# TFLint Configuration
# Enforces Terraform best practices and style conventions

plugin "terraform" {
  enabled = true
  version = "0.3.0"
}

# Required version check
rule "terraform_required_version" {
  enabled = true
}

# Required providers check
rule "terraform_required_providers" {
  enabled = true
}

# Naming convention checks (snake_case)
rule "terraform_naming_convention" {
  enabled = true
  format  = "snake_case"
}

# Ensure all variables are documented
rule "terraform_documented_variables" {
  enabled = true
}

# Ensure all outputs are documented
rule "terraform_documented_outputs" {
  enabled = true
}

# Enforce comment syntax
rule "terraform_comment_syntax" {
  enabled = true
}

# Module version pinning
rule "terraform_module_pinned_source" {
  enabled = true
}

# Prevent deprecated interpolation
rule "terraform_deprecated_interpolation" {
  enabled = true
}

# Unused variables
rule "terraform_unused_declarations" {
  enabled = true
}
