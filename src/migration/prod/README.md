# prod

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | <= 1.15.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.116.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.116.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_migrate_cosmos_accounts"></a> [migrate\_cosmos\_accounts](#module\_migrate\_cosmos\_accounts) | ../../_modules/data_factory_cosmos | n/a |
| <a name="module_migrate_storage_accounts"></a> [migrate\_storage\_accounts](#module\_migrate\_storage\_accounts) | ../../_modules/data_factory_storage_account | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_data_factory.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory) | resource |
| [azurerm_data_factory_integration_runtime_azure.azure_runtime](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_integration_runtime_azure) | resource |
| [azurerm_resource_group.migration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_data_factory"></a> [data\_factory](#output\_data\_factory) | n/a |
| <a name="output_data_factory_cosmos_pipelines"></a> [data\_factory\_cosmos\_pipelines](#output\_data\_factory\_cosmos\_pipelines) | n/a |
| <a name="output_data_factory_st_pipelines"></a> [data\_factory\_st\_pipelines](#output\_data\_factory\_st\_pipelines) | n/a |
<!-- END_TF_DOCS -->
