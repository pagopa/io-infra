<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.112.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_container_registry"></a> [container\_registry](#module\_container\_registry) | ../_modules/container_registry | n/a |
| <a name="module_global"></a> [global](#module\_global) | ../_modules/global | n/a |
| <a name="module_key_vault_weu"></a> [key\_vault\_weu](#module\_key\_vault\_weu) | ../_modules/key_vaults | n/a |
| <a name="module_networking_itn"></a> [networking\_itn](#module\_networking\_itn) | ../_modules/networking | n/a |
| <a name="module_networking_weu"></a> [networking\_weu](#module\_networking\_weu) | ../_modules/networking | n/a |
| <a name="module_vnet_peering_itn"></a> [vnet\_peering\_itn](#module\_vnet\_peering\_itn) | ../_modules/vnet_peering | n/a |
| <a name="module_vnet_peering_weu"></a> [vnet\_peering\_weu](#module\_vnet\_peering\_weu) | ../_modules/vnet_peering | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_api_management.apim_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_public_ip.appgateway_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/public_ip) | data source |
| [azurerm_resource_group.vnet_weu](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_virtual_network.weu_beta](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.weu_prod01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_networking_itn"></a> [networking\_itn](#output\_networking\_itn) | n/a |
| <a name="output_networking_weu"></a> [networking\_weu](#output\_networking\_weu) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
