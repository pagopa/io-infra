<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 2.33.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.116.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.33.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.116.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_common_values"></a> [common\_values](#module\_common\_values) | ../../_modules/common_values | n/a |
| <a name="module_locked_profiles_storage"></a> [locked\_profiles\_storage](#module\_locked\_profiles\_storage) | github.com/pagopa/terraform-azurerm-v3//storage_account | v8.27.0 |
| <a name="module_pub_session_manager_staging"></a> [pub\_session\_manager\_staging](#module\_pub\_session\_manager\_staging) | pagopa-dx/azure-role-assignments/azurerm | ~>1.0 |
| <a name="module_session_manager_snet"></a> [session\_manager\_snet](#module\_session\_manager\_snet) | github.com/pagopa/terraform-azurerm-v3//subnet | v8.22.0 |
| <a name="module_session_manager_weu"></a> [session\_manager\_weu](#module\_session\_manager\_weu) | github.com/pagopa/terraform-azurerm-v3//app_service | v8.28.1 |
| <a name="module_session_manager_weu_staging"></a> [session\_manager\_weu\_staging](#module\_session\_manager\_weu\_staging) | github.com/pagopa/terraform-azurerm-v3//app_service_slot | v8.28.1 |
| <a name="module_tests"></a> [tests](#module\_tests) | ../../_modules/test_users | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_scheduled_query_rules_alert_v2.samlresponse_missing_detection_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert_v2) | resource |
| [azurerm_private_endpoint.locked_profiles_storage_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.session_manager_sites](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.staging_session_manager_sites](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_storage_table.locked_profiles](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) | resource |
| [azurerm_subnet_nat_gateway_association.session_manager_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_application_gateway.app_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_gateway) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_dns_a_record.api_app_io_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_a_record) | data source |
| [azurerm_dns_zone.io_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_zone) | data source |
| [azurerm_key_vault.auth](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.kv_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.app_backend_ALLOWED_CIE_TEST_FISCAL_CODES](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.app_backend_LV_TEST_USERS](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.app_backend_SAML_CERT](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.app_backend_SAML_KEY](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.functions_fast_login_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.functions_lollipop_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.service_bus_events_beta_testers](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.session_manager_ALLOW_BPD_IP_SOURCE_RANGE](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.session_manager_ALLOW_FIMS_IP_SOURCE_RANGE](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.session_manager_ALLOW_PAGOPA_IP_SOURCE_RANGE](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.session_manager_ALLOW_ZENDESK_IP_SOURCE_RANGE](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.session_manager_IOLOGIN_TEST_USERS](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.session_manager_JWT_ZENDESK_SUPPORT_TOKEN_SECRET](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.session_manager_TEST_LOGIN_PASSWORD](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.session_manager_UNIQUE_EMAIL_ENFORCEMENT_USER](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.session_manager_VALIDATION_COOKIE_TEST_USERS](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.session_manager_functions_profile_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_linux_function_app.function_lollipop_itn_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.itn_auth_lv_func](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.error_action_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.quarantine_error_action_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_nat_gateway.nat_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/nat_gateway) | data source |
| [azurerm_private_dns_zone.privatelink_azurewebsites_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_table_core_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_redis_cache.core_domain_redis_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/redis_cache) | data source |
| [azurerm_resource_group.core_domain_common_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_external](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.session_manager_rg_weu](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_servicebus_namespace.platform_service_bus_namespace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/servicebus_namespace) | data source |
| [azurerm_storage_account.logs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.lollipop_assertion_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.push_notifications_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.apim_itn_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.appgateway_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.private_endpoints_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.self_hosted_runner_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.common_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_insights_name"></a> [application\_insights\_name](#input\_application\_insights\_name) | Specifies the name of the Application Insights. | `string` | n/a | yes |
| <a name="input_cidr_subnet_fnlollipop"></a> [cidr\_subnet\_fnlollipop](#input\_cidr\_subnet\_fnlollipop) | Function Lollipop address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_fnlollipop_itn"></a> [cidr\_subnet\_fnlollipop\_itn](#input\_cidr\_subnet\_fnlollipop\_itn) | Function Lollipop address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_session_manager"></a> [cidr\_subnet\_session\_manager](#input\_cidr\_subnet\_session\_manager) | Session manager app service address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_shared_1"></a> [cidr\_subnet\_shared\_1](#input\_cidr\_subnet\_shared\_1) | n/a | `list(string)` | n/a | yes |
| <a name="input_dns_zone_io"></a> [dns\_zone\_io](#input\_dns\_zone\_io) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `"pagopa.it"` | no |
| <a name="input_function_lollipop_autoscale_default"></a> [function\_lollipop\_autoscale\_default](#input\_function\_lollipop\_autoscale\_default) | The number of instances that are available for scaling if metrics are not available for evaluation. | `number` | `3` | no |
| <a name="input_function_lollipop_autoscale_maximum"></a> [function\_lollipop\_autoscale\_maximum](#input\_function\_lollipop\_autoscale\_maximum) | The maximum number of instances for this resource. | `number` | `10` | no |
| <a name="input_function_lollipop_autoscale_minimum"></a> [function\_lollipop\_autoscale\_minimum](#input\_function\_lollipop\_autoscale\_minimum) | The minimum number of instances for this resource. | `number` | `3` | no |
| <a name="input_function_lollipop_kind"></a> [function\_lollipop\_kind](#input\_function\_lollipop\_kind) | App service plan kind | `string` | `null` | no |
| <a name="input_function_lollipop_sku_size"></a> [function\_lollipop\_sku\_size](#input\_function\_lollipop\_sku\_size) | App service plan sku size | `string` | `null` | no |
| <a name="input_function_public_autoscale_default"></a> [function\_public\_autoscale\_default](#input\_function\_public\_autoscale\_default) | The number of instances that are available for scaling if metrics are not available for evaluation. | `number` | `1` | no |
| <a name="input_function_public_autoscale_maximum"></a> [function\_public\_autoscale\_maximum](#input\_function\_public\_autoscale\_maximum) | The maximum number of instances for this resource. | `number` | `3` | no |
| <a name="input_function_public_autoscale_minimum"></a> [function\_public\_autoscale\_minimum](#input\_function\_public\_autoscale\_minimum) | The minimum number of instances for this resource. | `number` | `1` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | One of prod01, prod02 | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_location_string"></a> [location\_string](#input\_location\_string) | One of West Europe, North Europe | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_lollipop_enabled"></a> [lollipop\_enabled](#input\_lollipop\_enabled) | Lollipop function enabled? | `bool` | `false` | no |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_plan_shared_1_kind"></a> [plan\_shared\_1\_kind](#input\_plan\_shared\_1\_kind) | App service plan kind | `string` | `null` | no |
| <a name="input_plan_shared_1_sku_capacity"></a> [plan\_shared\_1\_sku\_capacity](#input\_plan\_shared\_1\_sku\_capacity) | Shared functions app plan capacity | `number` | `3` | no |
| <a name="input_plan_shared_1_sku_size"></a> [plan\_shared\_1\_sku\_size](#input\_plan\_shared\_1\_sku\_size) | App service plan sku size | `string` | `null` | no |
| <a name="input_plan_shared_1_sku_tier"></a> [plan\_shared\_1\_sku\_tier](#input\_plan\_shared\_1\_sku\_tier) | App service plan sku tier | `string` | `null` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_session_manager_plan_sku_name"></a> [session\_manager\_plan\_sku\_name](#input\_session\_manager\_plan\_sku\_name) | App service plan sku name | `string` | `"P1v3"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br/>  "CreatedBy": "Terraform"<br/>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
