# functions

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 2.33.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.116.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.116.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_admin_snet"></a> [admin\_snet](#module\_admin\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v8.52.0 |
| <a name="module_common_values"></a> [common\_values](#module\_common\_values) | ../../_modules/common_values | n/a |
| <a name="module_db_subscription_cidrs_container"></a> [db\_subscription\_cidrs\_container](#module\_db\_subscription\_cidrs\_container) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container | v8.52.0 |
| <a name="module_db_subscription_profileemails_container"></a> [db\_subscription\_profileemails\_container](#module\_db\_subscription\_profileemails\_container) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container | v8.52.0 |
| <a name="module_function_admin"></a> [function\_admin](#module\_function\_admin) | git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app | v8.52.0 |
| <a name="module_function_admin_staging_slot"></a> [function\_admin\_staging\_slot](#module\_function\_admin\_staging\_slot) | git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot | v8.52.0 |
| <a name="module_function_assets_cdn"></a> [function\_assets\_cdn](#module\_function\_assets\_cdn) | git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app | v8.52.0 |
| <a name="module_function_assets_cdn_autoscale"></a> [function\_assets\_cdn\_autoscale](#module\_function\_assets\_cdn\_autoscale) | pagopa-dx/azure-app-service-plan-autoscaler/azurerm | ~> 0.0 |
| <a name="module_function_assets_cdn_snet"></a> [function\_assets\_cdn\_snet](#module\_function\_assets\_cdn\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v8.52.0 |
| <a name="module_function_assets_cdn_staging_slot"></a> [function\_assets\_cdn\_staging\_slot](#module\_function\_assets\_cdn\_staging\_slot) | git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot | v8.52.0 |
| <a name="module_function_services"></a> [function\_services](#module\_function\_services) | git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app | v8.52.0 |
| <a name="module_function_services_staging_slot"></a> [function\_services\_staging\_slot](#module\_function\_services\_staging\_slot) | git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot | v8.52.0 |
| <a name="module_services_snet"></a> [services\_snet](#module\_services\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v8.52.0 |
| <a name="module_tests"></a> [tests](#module\_tests) | ../../_modules/test_users | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_autoscale_setting.function_admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.function_services_autoscale](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_metric_alert.function_assets_health_check](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.function_assets_http_server_errors](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.function_assets_response_time](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert_v2.alert_failed_delete_procedure](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert_v2) | resource |
| [azurerm_monitor_scheduled_query_rules_alert_v2.alert_failed_download_procedure](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert_v2) | resource |
| [azurerm_resource_group.admin_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.services_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.function_admin_apim_itn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.function_admin_slot_apim_itn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_api_management.apim_itn_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_cosmosdb_account.cosmos_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/cosmosdb_account) | data source |
| [azurerm_key_vault.common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.key_vault_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.ad_APPCLIENT_APIM_ID](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.ad_APPCLIENT_APIM_SECRET](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.adb2c_TENANT_NAME](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.adb2c_TOKEN_ATTRIBUTE_NAME](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.apim_IO_GDPR_SERVICE_KEY](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.common_AZURE_TENANT_ID](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.common_MAILUP_SECRET](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.common_MAILUP_USERNAME](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.common_SENDGRID_APIKEY](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.devportal_CLIENT_ID](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.devportal_CLIENT_SECRET](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fn_admin_ASSETS_URL](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fn_admin_AZURE_SUBSCRIPTION_ID](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fn_admin_INSTANT_DELETE_ENABLED_USERS](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fn_admin_SESSION_MANAGER_INTERNAL_KEY](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fn_app_KEY_SPIDLOGS_PRIV](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fn_services_beta_users](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fn_services_email_service_blacklist_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fn_services_io_service_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fn_services_mailup_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fn_services_mailup_username](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fn_services_notification_service_blacklist_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fn_services_pagopa_ecommerce_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fn_services_sandbox_fiscal_code](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fn_services_webhook_channel_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.sending_func_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.sending_func_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_linux_function_app.session_manager_internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_monitor_action_group.error_action_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.io_auth_error_action_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.io_com_action_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.privatelink_blob_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_queue_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_table_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.backend_messages_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.assets_cdn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.citizen_auth_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.ioweb_spid_logs_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.locked_profiles_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.logs02](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.storage_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.userbackups](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.userdatadownload](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.apim_itn_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.azdoa_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.function_eucovidcert_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.gh_runner](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.private_endpoints_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_subnet_fnadmin"></a> [cidr\_subnet\_fnadmin](#input\_cidr\_subnet\_fnadmin) | Function Admin address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_fncdnassets"></a> [cidr\_subnet\_fncdnassets](#input\_cidr\_subnet\_fncdnassets) | Fn assets address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_services"></a> [cidr\_subnet\_services](#input\_cidr\_subnet\_services) | Function services address space. | `list(string)` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_function_admin_autoscale_default"></a> [function\_admin\_autoscale\_default](#input\_function\_admin\_autoscale\_default) | The number of instances that are available for scaling if metrics are not available for evaluation. | `number` | `1` | no |
| <a name="input_function_admin_autoscale_maximum"></a> [function\_admin\_autoscale\_maximum](#input\_function\_admin\_autoscale\_maximum) | The maximum number of instances for this resource. | `number` | `3` | no |
| <a name="input_function_admin_autoscale_minimum"></a> [function\_admin\_autoscale\_minimum](#input\_function\_admin\_autoscale\_minimum) | The minimum number of instances for this resource. | `number` | `1` | no |
| <a name="input_function_admin_kind"></a> [function\_admin\_kind](#input\_function\_admin\_kind) | App service plan kind | `string` | `null` | no |
| <a name="input_function_admin_locked_profiles_table_name"></a> [function\_admin\_locked\_profiles\_table\_name](#input\_function\_admin\_locked\_profiles\_table\_name) | Locked profiles table name | `string` | `"lockedprofiles"` | no |
| <a name="input_function_admin_sku_size"></a> [function\_admin\_sku\_size](#input\_function\_admin\_sku\_size) | App service plan sku size | `string` | `null` | no |
| <a name="input_function_admin_sku_tier"></a> [function\_admin\_sku\_tier](#input\_function\_admin\_sku\_tier) | App service plan sku tier | `string` | `null` | no |
| <a name="input_function_assets_cdn_autoscale_default"></a> [function\_assets\_cdn\_autoscale\_default](#input\_function\_assets\_cdn\_autoscale\_default) | The number of instances that are available for scaling if metrics are not available for evaluation. | `number` | `1` | no |
| <a name="input_function_assets_cdn_autoscale_maximum"></a> [function\_assets\_cdn\_autoscale\_maximum](#input\_function\_assets\_cdn\_autoscale\_maximum) | The maximum number of instances for this resource. | `number` | `3` | no |
| <a name="input_function_assets_cdn_autoscale_minimum"></a> [function\_assets\_cdn\_autoscale\_minimum](#input\_function\_assets\_cdn\_autoscale\_minimum) | The minimum number of instances for this resource. | `number` | `1` | no |
| <a name="input_function_assets_cdn_kind"></a> [function\_assets\_cdn\_kind](#input\_function\_assets\_cdn\_kind) | App service plan kind | `string` | `null` | no |
| <a name="input_function_assets_cdn_sku_size"></a> [function\_assets\_cdn\_sku\_size](#input\_function\_assets\_cdn\_sku\_size) | App service plan sku size | `string` | `null` | no |
| <a name="input_function_assets_cdn_sku_tier"></a> [function\_assets\_cdn\_sku\_tier](#input\_function\_assets\_cdn\_sku\_tier) | App service plan sku tier | `string` | `null` | no |
| <a name="input_function_services_autoscale_default"></a> [function\_services\_autoscale\_default](#input\_function\_services\_autoscale\_default) | The number of instances that are available for scaling if metrics are not available for evaluation. | `number` | `1` | no |
| <a name="input_function_services_autoscale_maximum"></a> [function\_services\_autoscale\_maximum](#input\_function\_services\_autoscale\_maximum) | The maximum number of instances for this resource. | `number` | `30` | no |
| <a name="input_function_services_autoscale_minimum"></a> [function\_services\_autoscale\_minimum](#input\_function\_services\_autoscale\_minimum) | The minimum number of instances for this resource. | `number` | `1` | no |
| <a name="input_function_services_count"></a> [function\_services\_count](#input\_function\_services\_count) | n/a | `number` | `2` | no |
| <a name="input_function_services_kind"></a> [function\_services\_kind](#input\_function\_services\_kind) | App service plan kind | `string` | `null` | no |
| <a name="input_function_services_sku_size"></a> [function\_services\_sku\_size](#input\_function\_services\_sku\_size) | App service plan sku size | `string` | `null` | no |
| <a name="input_function_services_sku_tier"></a> [function\_services\_sku\_tier](#input\_function\_services\_sku\_tier) | App service plan sku tier | `string` | `null` | no |
| <a name="input_function_services_subscription_cidrs_max_thoughput"></a> [function\_services\_subscription\_cidrs\_max\_thoughput](#input\_function\_services\_subscription\_cidrs\_max\_thoughput) | n/a | `number` | `1000` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"westeurope"` | no |
| <a name="input_location_in"></a> [location\_in](#input\_location\_in) | n/a | `string` | `"italynorth"` | no |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of weu, neu | `string` | n/a | yes |
| <a name="input_lock_enable"></a> [lock\_enable](#input\_lock\_enable) | Apply locks to block accedentaly deletions. | `bool` | `false` | no |
| <a name="input_pn_service_id"></a> [pn\_service\_id](#input\_pn\_service\_id) | The Service ID of PN service | `string` | `"01G40DWQGKY5GRWSNM4303VNRP"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"io"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
