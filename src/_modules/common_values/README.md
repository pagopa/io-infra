# Retrieve Common Values

## Description

This Terraform module does not require any input and provides some outputs containg common information for whole `io-infra` repository.
To update the module with new information add into the outputs.tf
```hcl
output "some_resource_name" {
  description = <<EOF
  WHAT: short description about what this value is for
  HOW: short description about how this value will be used (optional)
  EOF

  value = "example_value"
}
```

## Usage

To use this module, include it in your Terraform configuration and access the outputs to retrieve the informations.

### Example Usage

```hcl
module "common_names" {
  source = "../../_modules/common_values"
}

output "some_resource_name" {
  value = module.common_names.some_resource_name
}
```