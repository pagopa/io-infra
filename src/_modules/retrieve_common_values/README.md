# Retrieve Common Values

## Description

This Terraform module does not require any input and provides some outputs containg common information for whole io-infra repository.
To update the module with new information add into the locals.tf
```hcl
# WHAT: short description about what this value is for
# HOW: short description about how this value will be used (optional)
some_resource_name = "example_value"
```
And add the output into outputs.tf
```hcl
# WHAT: short description about what this value is for
# HOW: short description about how this value will be used (optional)
some_resource_name = "example_value"
```

## Usage

To use this module, include it in your Terraform configuration and access the outputs to retrieve the informations.

### Example Usage

```hcl
module "common_names" {
  source = "../../_modules/retrieve_common_values"
}

output "some_resource_name" {
  value = module.common_names.some_resource_name
}
```