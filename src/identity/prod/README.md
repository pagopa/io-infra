# IO Infra - Identity

<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.116.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm.prod-cgn"></a> [azurerm.prod-cgn](#provider\_azurerm.prod-cgn) | 3.116.0 |
| <a name="provider_azurerm.prod-selc"></a> [azurerm.prod-selc](#provider\_azurerm.prod-selc) | 3.116.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_federated_identities"></a> [federated\_identities](#module\_federated\_identities) | pagopa-dx/azure-federated-identity-with-github/azurerm | ~>0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_role_assignment.cd_cgn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cd_cgn_iac_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cd_selc_evhns](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.ci_cgn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.ci_cgn_iac_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_subscription.cgn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
