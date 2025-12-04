<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | ~> 2.7 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 4.36.0 |
| <a name="requirement_dx"></a> [dx](#requirement\_dx) | ~> 0.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 3.6.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.36.0 |
| <a name="provider_dx"></a> [dx](#provider\_dx) | ~> 0.4 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apim_itn"></a> [apim\_itn](#module\_apim\_itn) | ../_modules/apim | n/a |
| <a name="module_app_backend_weu"></a> [app\_backend\_weu](#module\_app\_backend\_weu) | ../_modules/app_backend | n/a |
| <a name="module_application_gateway_itn"></a> [application\_gateway\_itn](#module\_application\_gateway\_itn) | ../_modules/app_gateway | n/a |
| <a name="module_application_gateway_weu"></a> [application\_gateway\_weu](#module\_application\_gateway\_weu) | ../_modules/application_gateway | n/a |
| <a name="module_assets_cdn_weu"></a> [assets\_cdn\_weu](#module\_assets\_cdn\_weu) | ../_modules/assets_cdn | n/a |
| <a name="module_assets_locales_cdn"></a> [assets\_locales\_cdn](#module\_assets\_locales\_cdn) | ../_modules/assets_locales_cdn | n/a |
| <a name="module_containers_services"></a> [containers\_services](#module\_containers\_services) | ../_modules/function_services/containers | n/a |
| <a name="module_continua_app_service"></a> [continua\_app\_service](#module\_continua\_app\_service) | ../_modules/app_continua | n/a |
| <a name="module_cosmos_api_weu"></a> [cosmos\_api\_weu](#module\_cosmos\_api\_weu) | ../_modules/cosmos_api | n/a |
| <a name="module_event_hubs_weu"></a> [event\_hubs\_weu](#module\_event\_hubs\_weu) | ../_modules/event_hubs | n/a |
| <a name="module_function_app_admin"></a> [function\_app\_admin](#module\_function\_app\_admin) | ../_modules/function_admin | n/a |
| <a name="module_function_app_elt"></a> [function\_app\_elt](#module\_function\_app\_elt) | ../_modules/function_elt | n/a |
| <a name="module_function_app_services"></a> [function\_app\_services](#module\_function\_app\_services) | ../_modules/function_services/function-app | n/a |
| <a name="module_function_assets_cdn_itn"></a> [function\_assets\_cdn\_itn](#module\_function\_assets\_cdn\_itn) | ../_modules/function_assets_cdn | n/a |
| <a name="module_github_runner_itn"></a> [github\_runner\_itn](#module\_github\_runner\_itn) | ../_modules/github_runner | n/a |
| <a name="module_global"></a> [global](#module\_global) | ../_modules/global | n/a |
| <a name="module_monitoring_itn"></a> [monitoring\_itn](#module\_monitoring\_itn) | ../_modules/monitoring | n/a |
| <a name="module_monitoring_weu"></a> [monitoring\_weu](#module\_monitoring\_weu) | ../_modules/monitoring | n/a |
| <a name="module_platform_api_gateway_apim_itn"></a> [platform\_api\_gateway\_apim\_itn](#module\_platform\_api\_gateway\_apim\_itn) | ../_modules/platform_api_gateway | n/a |
| <a name="module_platform_service_bus_namespace_itn"></a> [platform\_service\_bus\_namespace\_itn](#module\_platform\_service\_bus\_namespace\_itn) | ../_modules/platform_service_bus | n/a |
| <a name="module_private_endpoints"></a> [private\_endpoints](#module\_private\_endpoints) | ../_modules/private_endpoint | n/a |
| <a name="module_redis_weu"></a> [redis\_weu](#module\_redis\_weu) | ../_modules/redis | n/a |
| <a name="module_storage_accounts"></a> [storage\_accounts](#module\_storage\_accounts) | ../_modules/storage_accounts | n/a |
| <a name="module_storage_accounts_itn"></a> [storage\_accounts\_itn](#module\_storage\_accounts\_itn) | ../_modules/storage_accounts | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_secret.cosmos_api_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.cosmos_api_primary_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.st_app_primary_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.st_logs_primary_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_resource_group.github_runner](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.apim_client_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.dev_portal_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.svc_devs_itn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [dx_available_subnet_cidr.next_cidr_snet_agw](https://registry.terraform.io/providers/pagopa-dx/azure/latest/docs/resources/available_subnet_cidr) | resource |
| [azuread_group.admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.auth_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.auth_devs](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.bonus_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.com_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.com_devs](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.platform_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.svc_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.svc_devs](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.wallet_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_service_principal.apim_client_svc](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.dev_portal_svc](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_container_app.services_app_backend_function_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_app) | data source |
| [azurerm_key_vault.ioweb_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.itn_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_linux_function_app.com_citizen_func](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.eucovidcert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.function_assets_cdn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.function_profile](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.io_fims_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.io_sign_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.lollipop_function](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.services_app_backend_function_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.wallet_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.wallet_user_uat](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_web_app.firmaconio_selfcare_web_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_web_app) | data source |
| [azurerm_subnet.admin_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.cosmos_api_allowed](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.itn_auth_lv_func_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.itn_auth_prof_async_func_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_user_assigned_identity.auth_n_identity_infra_cd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [azurerm_user_assigned_identity.auth_n_identity_infra_ci](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [azurerm_user_assigned_identity.bonus_infra_cd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [azurerm_user_assigned_identity.com_infra_cd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [azurerm_user_assigned_identity.managed_identity_io_infra_cd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [azurerm_user_assigned_identity.managed_identity_io_infra_ci](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [terraform_remote_state.core](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_apim"></a> [apim](#output\_apim) | n/a |
| <a name="output_pep_subnets"></a> [pep\_subnets](#output\_pep\_subnets) | n/a |
| <a name="output_private_endpoints"></a> [private\_endpoints](#output\_private\_endpoints) | n/a |
| <a name="output_virtual_networks"></a> [virtual\_networks](#output\_virtual\_networks) | n/a |
<!-- END_TF_DOCS -->
