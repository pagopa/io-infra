<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.96.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 3.1.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.94.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_app_services"></a> [app\_services](#module\_app\_services) | ../../_modules/app_services | n/a |
| <a name="module_cdn"></a> [cdn](#module\_cdn) | ../../_modules/cdn | n/a |
| <a name="module_networking"></a> [networking](#module\_networking) | ../../_modules/networking | n/a |
| <a name="module_postgresql"></a> [postgresql](#module\_postgresql) | ../../_modules/postgresql | n/a |
| <a name="module_resource_groups"></a> [resource\_groups](#module\_resource\_groups) | ../../_modules/resource_groups | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_role_assignment.admins_group_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.devs_group_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azuread_group.svc_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.svc_devs](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
