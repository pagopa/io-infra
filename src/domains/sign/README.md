<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.33.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.33.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.40.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apim_io_sign_issuer_api_v1"></a> [apim\_io\_sign\_issuer\_api\_v1](#module\_apim\_io\_sign\_issuer\_api\_v1) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api | v4.1.3 |
| <a name="module_apim_io_sign_product"></a> [apim\_io\_sign\_product](#module\_apim\_io\_sign\_product) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product | v4.1.3 |
| <a name="module_apim_io_sign_support_api_v1"></a> [apim\_io\_sign\_support\_api\_v1](#module\_apim\_io\_sign\_support\_api\_v1) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api | v4.1.3 |
| <a name="module_apim_io_sign_support_product"></a> [apim\_io\_sign\_support\_product](#module\_apim\_io\_sign\_support\_product) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product | v4.1.3 |
| <a name="module_cosmosdb_account"></a> [cosmosdb\_account](#module\_cosmosdb\_account) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account | v4.1.8 |
| <a name="module_cosmosdb_sql_container_issuer-dossiers"></a> [cosmosdb\_sql\_container\_issuer-dossiers](#module\_cosmosdb\_sql\_container\_issuer-dossiers) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container | v4.1.11 |
| <a name="module_cosmosdb_sql_container_issuer-issuers"></a> [cosmosdb\_sql\_container\_issuer-issuers](#module\_cosmosdb\_sql\_container\_issuer-issuers) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container | v4.1.11 |
| <a name="module_cosmosdb_sql_container_issuer-issuers-by-vat-number"></a> [cosmosdb\_sql\_container\_issuer-issuers-by-vat-number](#module\_cosmosdb\_sql\_container\_issuer-issuers-by-vat-number) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container | v4.1.11 |
| <a name="module_cosmosdb_sql_container_issuer-issuers-whitelist"></a> [cosmosdb\_sql\_container\_issuer-issuers-whitelist](#module\_cosmosdb\_sql\_container\_issuer-issuers-whitelist) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container | v4.1.11 |
| <a name="module_cosmosdb_sql_container_issuer-signature-requests"></a> [cosmosdb\_sql\_container\_issuer-signature-requests](#module\_cosmosdb\_sql\_container\_issuer-signature-requests) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container | v4.1.11 |
| <a name="module_cosmosdb_sql_container_issuer-uploads"></a> [cosmosdb\_sql\_container\_issuer-uploads](#module\_cosmosdb\_sql\_container\_issuer-uploads) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container | v4.1.11 |
| <a name="module_cosmosdb_sql_container_user-signature-requests"></a> [cosmosdb\_sql\_container\_user-signature-requests](#module\_cosmosdb\_sql\_container\_user-signature-requests) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container | v4.1.11 |
| <a name="module_cosmosdb_sql_container_user-signatures"></a> [cosmosdb\_sql\_container\_user-signatures](#module\_cosmosdb\_sql\_container\_user-signatures) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container | v4.1.11 |
| <a name="module_cosmosdb_sql_database_issuer"></a> [cosmosdb\_sql\_database\_issuer](#module\_cosmosdb\_sql\_database\_issuer) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_database | v4.1.3 |
| <a name="module_cosmosdb_sql_database_user"></a> [cosmosdb\_sql\_database\_user](#module\_cosmosdb\_sql\_database\_user) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_database | v4.1.3 |
| <a name="module_event_hub"></a> [event\_hub](#module\_event\_hub) | git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub | v4.1.7 |
| <a name="module_io_sign_eventhub_snet"></a> [io\_sign\_eventhub\_snet](#module\_io\_sign\_eventhub\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v4.1.4 |
| <a name="module_io_sign_issuer_func"></a> [io\_sign\_issuer\_func](#module\_io\_sign\_issuer\_func) | git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app | v6.2.1 |
| <a name="module_io_sign_issuer_func_staging_slot"></a> [io\_sign\_issuer\_func\_staging\_slot](#module\_io\_sign\_issuer\_func\_staging\_slot) | git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot | v6.0.1 |
| <a name="module_io_sign_snet"></a> [io\_sign\_snet](#module\_io\_sign\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v4.1.4 |
| <a name="module_io_sign_storage"></a> [io\_sign\_storage](#module\_io\_sign\_storage) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v4.1.5 |
| <a name="module_io_sign_support_func"></a> [io\_sign\_support\_func](#module\_io\_sign\_support\_func) | git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app | v6.1.0 |
| <a name="module_io_sign_support_func_staging_slot"></a> [io\_sign\_support\_func\_staging\_slot](#module\_io\_sign\_support\_func\_staging\_slot) | git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot | v6.1.0 |
| <a name="module_io_sign_support_snet"></a> [io\_sign\_support\_snet](#module\_io\_sign\_support\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v4.1.4 |
| <a name="module_io_sign_user_func"></a> [io\_sign\_user\_func](#module\_io\_sign\_user\_func) | git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app | v6.2.1 |
| <a name="module_io_sign_user_func_staging_slot"></a> [io\_sign\_user\_func\_staging\_slot](#module\_io\_sign\_user\_func\_staging\_slot) | git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot | v6.0.1 |
| <a name="module_io_sign_user_snet"></a> [io\_sign\_user\_snet](#module\_io\_sign\_user\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v4.1.4 |
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault | v6.2.2 |
| <a name="module_key_vault_secrets"></a> [key\_vault\_secrets](#module\_key\_vault\_secrets) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query | v4.1.3 |
| <a name="module_landing_cdn"></a> [landing\_cdn](#module\_landing\_cdn) | git::https://github.com/pagopa/terraform-azurerm-v3.git//cdn | v6.3.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_api_operation_policy.get_signer_by_fiscal_code_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_named_value.io_fn_sign_issuer_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.io_fn_sign_issuer_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.io_fn_sign_support_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.io_fn_sign_support_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.io_sign_cosmosdb_issuer_container_name](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.io_sign_cosmosdb_issuer_issuers_collection_name](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.io_sign_cosmosdb_issuer_whitelist_collection_name_new](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.io_sign_cosmosdb_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.io_sign_cosmosdb_name](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_dns_cname_record.dkim1_mailup_firma_io_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_cname_record.dkim2_mailup_firma_io_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_cname_record.ses_validation_firma_io_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_mx_record.ses_mx_firma_io_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_mx_record) | resource |
| [azurerm_dns_txt_record.dmarc_mailup_firma_io_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_txt_record.spf1_mailup_firma_io_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_zone.firma_io_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) | resource |
| [azurerm_key_vault_access_policy.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_contributors](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_sign](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_platform_iac_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.integration_event_hub_jaas_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.integration_event_hub_secrets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_monitor_action_group.email_fci_tech](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.slack_fci_tech](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_autoscale_setting.io_sign_issuer_func](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.io_sign_support_func](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.io_sign_user_func](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_metric_alert.io_sign_issuer_http_server_errors](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.io_sign_issuer_response_time](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.io_sign_support_http_server_errors](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.io_sign_support_response_time](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.io_sign_user_helathcheck](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.io_sign_user_http_server_errors](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.io_sign_user_response_time](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.io_sign_qtsp_avg_async_time](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_network_security_group.io_sign_eventhub_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.io_sign_issuer_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.io_sign_support_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.io_sign_user_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_portal_dashboard.io_sign_user_dashboard](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/portal_dashboard) | resource |
| [azurerm_private_endpoint.blob](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.io_sign_issuer_func](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.io_sign_issuer_func_staging](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.io_sign_support_func](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.io_sign_support_func_staging](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.io_sign_user_func](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.io_sign_user_func_staging](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.backend_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.data_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.integration_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_container.filled_modules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.signed_documents](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.uploaded_documents](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.validated_documents](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_management_policy.io_sign_storage_management_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) | resource |
| [azurerm_storage_queue.on_signature_request_ready](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.on_signature_request_rejected](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.on_signature_request_signed](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.on_signature_request_wait_for_signature](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.waiting_for_documents_to_fill](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.waiting_for_qtsp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.waiting_for_signature_request_updates](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_subnet_nat_gateway_association.io_sign_issuer_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_subnet_nat_gateway_association.io_sign_support_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_subnet_nat_gateway_association.io_sign_user_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_contributors](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_sign](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_service_principal.platform_iac_sp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azurerm_api_management.apim_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_dns_zone.io_italia_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_zone) | data source |
| [azurerm_key_vault.core_kv_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.monitor_fci_tech_email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_fci_tech_slack_email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_nat_gateway.nat_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/nat_gateway) | data source |
| [azurerm_private_dns_zone.privatelink_azurewebsites_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_blob_core_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_documents_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_file_core_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_queue_core_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_servicebus_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_table_core_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.core_ext](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.core_rg_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.private_endpoints_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cosmos"></a> [cosmos](#input\_cosmos) | n/a | <pre>object({<br>    zone_redundant = bool<br>    additional_geo_locations = list(object({<br>      location          = string<br>      failover_priority = number<br>      zone_redundant    = bool<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_dns_default_ttl_sec"></a> [dns\_default\_ttl\_sec](#input\_dns\_default\_ttl\_sec) | Default TTL for DNS | `number` | `3600` | no |
| <a name="input_dns_ses_validation"></a> [dns\_ses\_validation](#input\_dns\_ses\_validation) | CNAME records to validate SES domain identity | <pre>list(object({<br>    name   = string<br>    record = string<br>  }))</pre> | n/a | yes |
| <a name="input_dns_zone_name"></a> [dns\_zone\_name](#input\_dns\_zone\_name) | The name for the DNS zone | `string` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_integration_hub"></a> [integration\_hub](#input\_integration\_hub) | The configuration, hubs and keys of the event hub relative to external integration | <pre>object({<br>    auto_inflate_enabled     = bool<br>    sku_name                 = string<br>    capacity                 = number<br>    maximum_throughput_units = number<br>    zone_redundant           = bool<br>    alerts_enabled           = bool<br>    ip_rules = list(object({<br>      ip_mask = string<br>      action  = string<br>    }))<br>    hubs = list(object({<br>      name              = string<br>      partitions        = number<br>      message_retention = number<br>      consumers         = list(string)<br>      keys = list(object({<br>        name   = string<br>        listen = bool<br>        send   = bool<br>        manage = bool<br>      }))<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_io_sign_database_issuer"></a> [io\_sign\_database\_issuer](#input\_io\_sign\_database\_issuer) | n/a | <pre>map(<br>    object({<br>      max_throughput = number<br>      ttl            = number<br>    })<br>  )</pre> | n/a | yes |
| <a name="input_io_sign_database_user"></a> [io\_sign\_database\_user](#input\_io\_sign\_database\_user) | n/a | <pre>map(<br>    object({<br>      max_throughput = number<br>      ttl            = number<br>    })<br>  )</pre> | n/a | yes |
| <a name="input_io_sign_issuer_func"></a> [io\_sign\_issuer\_func](#input\_io\_sign\_issuer\_func) | n/a | <pre>object({<br>    sku_tier          = string<br>    sku_size          = string<br>    autoscale_default = number<br>    autoscale_minimum = number<br>    autoscale_maximum = number<br>  })</pre> | n/a | yes |
| <a name="input_io_sign_support_func"></a> [io\_sign\_support\_func](#input\_io\_sign\_support\_func) | n/a | <pre>object({<br>    sku_tier          = string<br>    sku_size          = string<br>    autoscale_default = number<br>    autoscale_minimum = number<br>    autoscale_maximum = number<br>  })</pre> | n/a | yes |
| <a name="input_io_sign_user_func"></a> [io\_sign\_user\_func](#input\_io\_sign\_user\_func) | n/a | <pre>object({<br>    sku_tier          = string<br>    sku_size          = string<br>    autoscale_default = number<br>    autoscale_minimum = number<br>    autoscale_maximum = number<br>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_storage_account"></a> [storage\_account](#input\_storage\_account) | The configuration of the storage account storing documents | <pre>object({<br>    enable_versioning             = bool<br>    delete_after_days             = number<br>    replication_type              = string<br>    enable_low_availability_alert = bool<br>  })</pre> | n/a | yes |
| <a name="input_subnets_cidrs"></a> [subnets\_cidrs](#input\_subnets\_cidrs) | The CIDR address prefixes of the subnets | <pre>map(<br>    list(string)<br>  )</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->