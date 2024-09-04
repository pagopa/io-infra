<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.114.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_event_hubs_weu"></a> [event\_hubs\_weu](#module\_event\_hubs\_weu) | ../_modules/event_hubs | n/a |
| <a name="module_global"></a> [global](#module\_global) | ../_modules/global | n/a |
| <a name="module_monitoring_weu"></a> [monitoring\_weu](#module\_monitoring\_weu) | ../_modules/monitoring | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management.apim_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_monitor_action_group.error_action_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_public_ip.appgateway_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/public_ip) | data source |
| [azurerm_resource_group.common_weu](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_virtual_network.weu_beta](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.weu_prod01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [terraform_remote_state.core](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
