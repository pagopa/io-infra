<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.116.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.116.0 |
| <a name="provider_azurerm.prod-trial"></a> [azurerm.prod-trial](#provider\_azurerm.prod-trial) | 3.116.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apim_weu"></a> [apim\_weu](#module\_apim\_weu) | ../_modules/apim | n/a |
| <a name="module_app_backend_li_weu"></a> [app\_backend\_li\_weu](#module\_app\_backend\_li\_weu) | ../_modules/app_backend | n/a |
| <a name="module_app_backend_weu"></a> [app\_backend\_weu](#module\_app\_backend\_weu) | ../_modules/app_backend | n/a |
| <a name="module_application_gateway_weu"></a> [application\_gateway\_weu](#module\_application\_gateway\_weu) | ../_modules/application_gateway | n/a |
| <a name="module_assets_cdn_weu"></a> [assets\_cdn\_weu](#module\_assets\_cdn\_weu) | ../_modules/assets_cdn | n/a |
| <a name="module_cosmos_api_weu"></a> [cosmos\_api\_weu](#module\_cosmos\_api\_weu) | ../_modules/cosmos_api | n/a |
| <a name="module_event_hubs_weu"></a> [event\_hubs\_weu](#module\_event\_hubs\_weu) | ../_modules/event_hubs | n/a |
| <a name="module_github_runner_itn"></a> [github\_runner\_itn](#module\_github\_runner\_itn) | ../_modules/github_runner | n/a |
| <a name="module_global"></a> [global](#module\_global) | ../_modules/global | n/a |
| <a name="module_monitoring_weu"></a> [monitoring\_weu](#module\_monitoring\_weu) | ../_modules/monitoring | n/a |
| <a name="module_private_endpoints"></a> [private\_endpoints](#module\_private\_endpoints) | ../_modules/private_endpoint | n/a |
| <a name="module_redis_weu"></a> [redis\_weu](#module\_redis\_weu) | ../_modules/redis | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.github_runner](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_api_management.trial_system](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_linux_function_app.app_messages_xl](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.eucovidcert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.function_assets_cdn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.function_cgn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.function_profile](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.io_sign_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.lollipop_function](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.services_app_backend_function_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.wallet_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_web_app.firmaconio_selfcare_web_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_web_app) | data source |
| [azurerm_subnet.admin_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.cosmos_api_allowed](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.itn_auth_fast_login_func_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.itn_auth_lv_func_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.itn_msgs_sending_func_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.services_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.weu_prod01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [terraform_remote_state.core](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
