<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 2.33.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.112.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.33.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.112.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 3.4.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apim_v2_messages_citizen_l1_api_v1"></a> [apim\_v2\_messages\_citizen\_l1\_api\_v1](#module\_apim\_v2\_messages\_citizen\_l1\_api\_v1) | github.com/pagopa/terraform-azurerm-v3//api_management_api | v8.40.0 |
| <a name="module_apim_v2_messages_citizen_l2_api_v1"></a> [apim\_v2\_messages\_citizen\_l2\_api\_v1](#module\_apim\_v2\_messages\_citizen\_l2\_api\_v1) | github.com/pagopa/terraform-azurerm-v3//api_management_api | v8.40.0 |
| <a name="module_apim_v2_messages_sending_external_api_v1"></a> [apim\_v2\_messages\_sending\_external\_api\_v1](#module\_apim\_v2\_messages\_sending\_external\_api\_v1) | github.com/pagopa/terraform-azurerm-v3//api_management_api | v8.17.0 |
| <a name="module_apim_v2_messages_sending_internal_api_v1"></a> [apim\_v2\_messages\_sending\_internal\_api\_v1](#module\_apim\_v2\_messages\_sending\_internal\_api\_v1) | github.com/pagopa/terraform-azurerm-v3//api_management_api | v8.27.0 |
| <a name="module_apim_v2_product_messages_backend"></a> [apim\_v2\_product\_messages\_backend](#module\_apim\_v2\_product\_messages\_backend) | github.com/pagopa/terraform-azurerm-v3//api_management_product | v8.27.0 |
| <a name="module_apim_v2_product_notifications"></a> [apim\_v2\_product\_notifications](#module\_apim\_v2\_product\_notifications) | github.com/pagopa/terraform-azurerm-v3//api_management_product | v8.27.0 |
| <a name="module_apim_v2_service_messages_internal_api_v1"></a> [apim\_v2\_service\_messages\_internal\_api\_v1](#module\_apim\_v2\_service\_messages\_internal\_api\_v1) | github.com/pagopa/terraform-azurerm-v3//api_management_api | v8.27.0 |
| <a name="module_apim_v2_service_messages_manage_api_v1"></a> [apim\_v2\_service\_messages\_manage\_api\_v1](#module\_apim\_v2\_service\_messages\_manage\_api\_v1) | github.com/pagopa/terraform-azurerm-v3//api_management_api | v8.27.0 |
| <a name="module_azure_storage_account"></a> [azure\_storage\_account](#module\_azure\_storage\_account) | github.com/pagopa/dx//infra/modules/azure_storage_account | main |
| <a name="module_common_values"></a> [common\_values](#module\_common\_values) | ../../_modules/common_values | n/a |
| <a name="module_cosmosdb_account_mongodb_reminder"></a> [cosmosdb\_account\_mongodb\_reminder](#module\_cosmosdb\_account\_mongodb\_reminder) | github.com/pagopa/terraform-azurerm-v3//cosmosdb_account | v8.27.0 |
| <a name="module_cosmosdb_account_remote_content"></a> [cosmosdb\_account\_remote\_content](#module\_cosmosdb\_account\_remote\_content) | github.com/pagopa/terraform-azurerm-v3//cosmosdb_account | v8.27.0 |
| <a name="module_cosmosdb_sql_database_remote_content"></a> [cosmosdb\_sql\_database\_remote\_content](#module\_cosmosdb\_sql\_database\_remote\_content) | github.com/pagopa/terraform-azurerm-v3//cosmosdb_sql_database | v8.27.0 |
| <a name="module_io-backend_notification_v2_api_v1"></a> [io-backend\_notification\_v2\_api\_v1](#module\_io-backend\_notification\_v2\_api\_v1) | github.com/pagopa/terraform-azurerm-v3//api_management_api | v8.27.0 |
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | github.com/pagopa/terraform-azurerm-v3//key_vault | v8.27.0 |
| <a name="module_mongdb_collection_reminder"></a> [mongdb\_collection\_reminder](#module\_mongdb\_collection\_reminder) | github.com/pagopa/terraform-azurerm-v3//cosmosdb_mongodb_collection | v8.27.0 |
| <a name="module_mongdb_collection_reminder_sharded"></a> [mongdb\_collection\_reminder\_sharded](#module\_mongdb\_collection\_reminder\_sharded) | github.com/pagopa/terraform-azurerm-v3//cosmosdb_mongodb_collection | v8.27.0 |
| <a name="module_push_notif_beta_storage"></a> [push\_notif\_beta\_storage](#module\_push\_notif\_beta\_storage) | github.com/pagopa/terraform-azurerm-v3//storage_account | v8.27.0 |
| <a name="module_push_notifications_storage"></a> [push\_notifications\_storage](#module\_push\_notifications\_storage) | github.com/pagopa/terraform-azurerm-v3//storage_account | v8.27.0 |
| <a name="module_redis_messages"></a> [redis\_messages](#module\_redis\_messages) | github.com/pagopa/terraform-azurerm-v3//redis_cache | v8.27.0 |
| <a name="module_reminder_mysql_db_server_snet"></a> [reminder\_mysql\_db\_server\_snet](#module\_reminder\_mysql\_db\_server\_snet) | github.com/pagopa/terraform-azurerm-v3//subnet | v8.27.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_group.apimessagereadadvanced_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.apimessagewriteadvanced_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.apinewmessagenotify_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.apipaymentupdater_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.apiremindernotify_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.apiremotecontentconfigurationwrite](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group.apithirdpartymessagewrite_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_group_user.payment_group_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group_user) | resource |
| [azurerm_api_management_group_user.reminder_group_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group_user) | resource |
| [azurerm_api_management_named_value.io_messages_backend_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.io_p_messages_sending_func_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_subscription.messages_backend_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_api_management_subscription.payment_updater_reminder_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_api_management_subscription.reminder_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |
| [azurerm_api_management_user.reminder_user_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_user) | resource |
| [azurerm_cosmosdb_mongo_database.db_reminder](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_cosmosdb_sql_container.message_configuration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_container) | resource |
| [azurerm_cosmosdb_sql_container.user_configurations](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_container) | resource |
| [azurerm_key_vault_access_policy.access_policy_kv_io_infra_cd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.access_policy_kv_io_infra_ci](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_platform_iac_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.api_storage_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.appinsights_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.appinsights_instrumentation_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.cosmos_api_master_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.messages_io-p-message-reminder-send-weu-prod01-evh-reminder_jaas-connection-string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.messages_io-p-message-status-weu-prod01-evh-reminder_jaas-connection-string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.messages_io-p-messages-weu-prod01-evh-reminder_jaas-connection-string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.mongodb_connection_string_reminder](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.notifications_storage_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.payments_io-p-payment-updates-weu-prod01-evh-reminder_jaas-connection-string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.push_notifications_storage_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.reminder_mysql_db_server_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.reminder_paymentapi_subscription_primary_key_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.reminder_subscription_primary_key_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_mysql_flexible_database.reminder_mysql_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_database) | resource |
| [azurerm_mysql_flexible_server.reminder_mysql_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server) | resource |
| [azurerm_mysql_flexible_server_configuration.max_connections](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server_configuration) | resource |
| [azurerm_private_endpoint.cosno_reminder_itn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.cosno_remote_content_itn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.app_messages_common_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.data_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.notifications_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_queue.push_notifications_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_table.notificationhub_beta_test_users_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_service_principal.platform_iac_sp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azurerm_api_management.apim_v2_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_api_management_product.apim_v2_product_services](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_product) | data source |
| [azurerm_api_management_product.payment_updater_product_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_product) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_cosmosdb_account.cosmos_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/cosmosdb_account) | data source |
| [azurerm_eventhub_authorization_rule.io-p-payments-weu-prod01-evh-ns_payment-updates_io-p-reminder](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.messages-weu-prod01-evh_message-reminder-send_io-reminder](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.messages-weu-prod01-evh_message-status_io-reminder](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.messages-weu-prod01-evh_messages_io-reminder](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_key_vault_secret.io_messages_backend_func_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.io_p_messages_sending_func_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.reminder_mysql_db_server_adm_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.reminder_mysql_db_server_adm_username](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.error_action_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.privatelink_documents_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_mongo_cosmos_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_mysql_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_postgres_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_redis_cache](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.api_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.notifications_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.azdoa_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.pep_subnet_itn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.private_endpoints_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_user_assigned_identity.managed_identity_io_messages_cd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [azurerm_user_assigned_identity.managed_identity_io_messages_ci](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [azurerm_virtual_network.vnet_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [http_http.messages_citizen_openapi](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.messages_sending_external_openapi](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.messages_sending_internal_openapi](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.service_messages_internal_openapi](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.service_messages_manage_openapi](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_insights_name"></a> [application\_insights\_name](#input\_application\_insights\_name) | Specifies the name of the Application Insights. | `string` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_enable_azdoa"></a> [enable\_azdoa](#input\_enable\_azdoa) | Specifies Azure Devops Agent enabling | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
