# Test Users Module

## Description

This Terraform module does not require any input and provides an output containing a map of test users. It is designed to be simple and returns a predefined set of users, useful for testing environments or simulations.

## Usage

To use this module, include it in your Terraform configuration and access the `users` output to retrieve the map of test users.

### Example Usage

```hcl
module "test_users" {
  source = "../../common/_modules"
}

output "test_users" {
  value = module.test_users.users
}
```

