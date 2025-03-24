<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.92 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 3.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apim_itn"></a> [apim\_itn](#module\_apim\_itn) | ../_modules/apim | n/a |
| <a name="module_cosmos"></a> [cosmos](#module\_cosmos) | ../_modules/cosmos | n/a |
| <a name="module_networking"></a> [networking](#module\_networking) | ../_modules/networking | n/a |
| <a name="module_resource_groups"></a> [resource\_groups](#module\_resource\_groups) | ../_modules/resource_groups | n/a |
| <a name="module_storage_accounts"></a> [storage\_accounts](#module\_storage\_accounts) | ../_modules/storage_accounts | n/a |

## Resources

| Name | Type |
|------|------|
| [azuread_group.bonus_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cosmos_cgn"></a> [cosmos\_cgn](#output\_cosmos\_cgn) | n/a |
| <a name="output_resource_group_cgn"></a> [resource\_group\_cgn](#output\_resource\_group\_cgn) | n/a |
| <a name="output_resource_group_cgn_be"></a> [resource\_group\_cgn\_be](#output\_resource\_group\_cgn\_be) | n/a |
| <a name="output_storage_account_cgn"></a> [storage\_account\_cgn](#output\_storage\_account\_cgn) | n/a |
| <a name="output_storage_account_legal_backup"></a> [storage\_account\_legal\_backup](#output\_storage\_account\_legal\_backup) | n/a |
<!-- END_TF_DOCS -->
