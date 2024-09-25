<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | <= 1.9.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 2.33.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.110.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | <= 2.3.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | <= 3.4.3 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | <= 4.0.4 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api_v2_services"></a> [api\_v2\_services](#module\_api\_v2\_services) | github.com/pagopa/terraform-azurerm-v3//api_management_api | v8.27.0 |
| <a name="module_apim_v2_io_backend_app_api_v1"></a> [apim\_v2\_io\_backend\_app\_api\_v1](#module\_apim\_v2\_io\_backend\_app\_api\_v1) | github.com/pagopa/terraform-azurerm-v3//api_management_api | v8.27.0 |
| <a name="module_apim_v2_io_backend_auth_api_v1"></a> [apim\_v2\_io\_backend\_auth\_api\_v1](#module\_apim\_v2\_io\_backend\_auth\_api\_v1) | github.com/pagopa/terraform-azurerm-v3//api_management_api | v8.27.0 |
| <a name="module_apim_v2_io_backend_bpd_api_v1"></a> [apim\_v2\_io\_backend\_bpd\_api\_v1](#module\_apim\_v2\_io\_backend\_bpd\_api\_v1) | github.com/pagopa/terraform-azurerm-v3//api_management_api | v8.27.0 |
| <a name="module_apim_v2_io_backend_cgn_api_v1"></a> [apim\_v2\_io\_backend\_cgn\_api\_v1](#module\_apim\_v2\_io\_backend\_cgn\_api\_v1) | github.com/pagopa/terraform-azurerm-v3//api_management_api | v8.27.0 |
| <a name="module_apim_v2_io_backend_eucovidcert_api_v1"></a> [apim\_v2\_io\_backend\_eucovidcert\_api\_v1](#module\_apim\_v2\_io\_backend\_eucovidcert\_api\_v1) | github.com/pagopa/terraform-azurerm-v3//api_management_api | v8.27.0 |
| <a name="module_apim_v2_io_backend_mitvoucher_api_v1"></a> [apim\_v2\_io\_backend\_mitvoucher\_api\_v1](#module\_apim\_v2\_io\_backend\_mitvoucher\_api\_v1) | github.com/pagopa/terraform-azurerm-v3//api_management_api | v8.27.0 |
| <a name="module_apim_v2_io_backend_myportal_api_v1"></a> [apim\_v2\_io\_backend\_myportal\_api\_v1](#module\_apim\_v2\_io\_backend\_myportal\_api\_v1) | github.com/pagopa/terraform-azurerm-v3//api_management_api | v8.27.0 |
| <a name="module_apim_v2_io_backend_notifications_api_v1"></a> [apim\_v2\_io\_backend\_notifications\_api\_v1](#module\_apim\_v2\_io\_backend\_notifications\_api\_v1) | github.com/pagopa/terraform-azurerm-v3//api_management_api | v8.27.0 |
| <a name="module_apim_v2_io_backend_pagopa_api_v1"></a> [apim\_v2\_io\_backend\_pagopa\_api\_v1](#module\_apim\_v2\_io\_backend\_pagopa\_api\_v1) | github.com/pagopa/terraform-azurerm-v3//api_management_api | v8.27.0 |
| <a name="module_apim_v2_io_backend_product"></a> [apim\_v2\_io\_backend\_product](#module\_apim\_v2\_io\_backend\_product) | github.com/pagopa/terraform-azurerm-v3//api_management_product | v8.27.0 |
| <a name="module_apim_v2_io_backend_public_api_v1"></a> [apim\_v2\_io\_backend\_public\_api\_v1](#module\_apim\_v2\_io\_backend\_public\_api\_v1) | github.com/pagopa/terraform-azurerm-v3//api_management_api | v8.27.0 |
| <a name="module_apim_v2_io_backend_session_api_v1"></a> [apim\_v2\_io\_backend\_session\_api\_v1](#module\_apim\_v2\_io\_backend\_session\_api\_v1) | github.com/pagopa/terraform-azurerm-v3//api_management_api | v8.27.0 |
| <a name="module_apim_v2_product_services"></a> [apim\_v2\_product\_services](#module\_apim\_v2\_product\_services) | github.com/pagopa/terraform-azurerm-v3//api_management_product | v8.27.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_api_operation_policy.submit_message_for_user_policy_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.submit_message_for_user_with_fiscalcode_in_body_policy_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_version_set.io_backend_app_api_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.io_backend_auth_api_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.io_backend_bpd_api_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.io_backend_cgn_api_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.io_backend_eucovidcert_api_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.io_backend_mitvoucher_api_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.io_backend_myportal_api_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.io_backend_notifications_api_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.io_backend_pagopa_api_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.io_backend_public_api_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.io_backend_session_api_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_named_value.api_gad_client_certificate_verified_header_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.io_fn3_eucovidcert_key_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.io_fn3_eucovidcert_url_alt_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.io_fn3_services_key_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.io_fn3_services_url_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_key_vault_secret.appinsights_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.appinsights_instrumentation_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_monitor_metric_alert.cosmos_api_throttling_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_resource_group.data](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.default_roleassignment_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_external](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_api_management.trial_system](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_cosmosdb_account.cosmos_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/cosmosdb_account) | data source |
| [azurerm_cosmosdb_account.cosmos_remote_content](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/cosmosdb_account) | data source |
| [azurerm_dns_a_record.api_app_io_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_a_record) | data source |
| [azurerm_dns_a_record.api_io_italia_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_a_record) | data source |
| [azurerm_dns_a_record.api_io_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_a_record) | data source |
| [azurerm_dns_a_record.api_io_selfcare_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_a_record) | data source |
| [azurerm_dns_a_record.api_mtls_io_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_a_record) | data source |
| [azurerm_dns_a_record.api_web_io_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_a_record) | data source |
| [azurerm_dns_a_record.app_backend_io_italia_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_a_record) | data source |
| [azurerm_dns_a_record.continua_io_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_a_record) | data source |
| [azurerm_dns_a_record.developerportal_backend_io_italia_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_a_record) | data source |
| [azurerm_dns_a_record.firmaconio_selfcare_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_a_record) | data source |
| [azurerm_dns_a_record.selfcare_cdn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_a_record) | data source |
| [azurerm_dns_zone.firmaconio_selfcare_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_zone) | data source |
| [azurerm_dns_zone.io_italia_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_zone) | data source |
| [azurerm_dns_zone.io_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_zone) | data source |
| [azurerm_dns_zone.io_selfcare_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_zone) | data source |
| [azurerm_eventhub_authorization_rule.io-p-messages-weu-prod01-evh-ns_message-status_io-fn-messages-cqrs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.io-p-messages-weu-prod01-evh-ns_messages_io-fn-messages-cqrs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.io-p-payments-weu-prod01-evh-ns_payment-updates_io-fn-messages-cqrs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.key_vault_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.api_gad_client_certificate_verified_header_secret_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.apim_services_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.app_backend_PRE_SHARED_KEY](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.io_fn3_eucovidcert_key_secret_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.io_fn3_services_key_secret_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_linux_function_app.app_messages_1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.app_messages_2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.citizen_func_01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.citizen_func_02](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.eucovidcert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.function_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.function_cgn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.lollipop_function](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_function_app.services_app_backend_function_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_function_app) | data source |
| [azurerm_linux_web_app.appservice_continua](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_web_app) | data source |
| [azurerm_linux_web_app.appservice_devportal_be](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_web_app) | data source |
| [azurerm_linux_web_app.appservice_selfcare_be](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_web_app) | data source |
| [azurerm_linux_web_app.cms_backoffice_app_itn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_web_app) | data source |
| [azurerm_monitor_action_group.error_action_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_nat_gateway.ng](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/nat_gateway) | data source |
| [azurerm_private_dns_zone.privatelink_azurewebsites](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_servicebus](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_table_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.lollipop_function_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.notifications_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.locked_profiles_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.logs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.lollipop_assertions_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.notifications](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.push_notifications_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.admin_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.appgateway_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.azdoa_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.function_let_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.private_endpoints_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.services_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_alerts_enabled"></a> [apim\_alerts\_enabled](#input\_apim\_alerts\_enabled) | Enable alerts | `bool` | `true` | no |
| <a name="input_apim_autoscale"></a> [apim\_autoscale](#input\_apim\_autoscale) | Configure Apim autoscale on capacity metric | <pre>object(<br/>    {<br/>      enabled                       = bool<br/>      default_instances             = number<br/>      minimum_instances             = number<br/>      maximum_instances             = number<br/>      scale_out_capacity_percentage = number<br/>      scale_out_time_window         = string<br/>      scale_out_value               = string<br/>      scale_out_cooldown            = string<br/>      scale_in_capacity_percentage  = number<br/>      scale_in_time_window          = string<br/>      scale_in_value                = string<br/>      scale_in_cooldown             = string<br/>    }<br/>  )</pre> | n/a | yes |
| <a name="input_apim_publisher_name"></a> [apim\_publisher\_name](#input\_apim\_publisher\_name) | # Apim | `string` | n/a | yes |
| <a name="input_apim_v2_sku"></a> [apim\_v2\_sku](#input\_apim\_v2\_sku) | n/a | `string` | n/a | yes |
| <a name="input_app_backend_autoscale_default"></a> [app\_backend\_autoscale\_default](#input\_app\_backend\_autoscale\_default) | The number of instances that are available for scaling if metrics are not available for evaluation. | `number` | `10` | no |
| <a name="input_app_backend_autoscale_maximum"></a> [app\_backend\_autoscale\_maximum](#input\_app\_backend\_autoscale\_maximum) | The maximum number of instances for this resource. | `number` | `30` | no |
| <a name="input_app_backend_autoscale_minimum"></a> [app\_backend\_autoscale\_minimum](#input\_app\_backend\_autoscale\_minimum) | The minimum number of instances for this resource. | `number` | `2` | no |
| <a name="input_app_backend_names"></a> [app\_backend\_names](#input\_app\_backend\_names) | App backend instance names | `list(string)` | `[]` | no |
| <a name="input_app_backend_plan_sku_size"></a> [app\_backend\_plan\_sku\_size](#input\_app\_backend\_plan\_sku\_size) | App backend app plan sku size | `string` | `"P1v3"` | no |
| <a name="input_app_backend_plan_sku_tier"></a> [app\_backend\_plan\_sku\_tier](#input\_app\_backend\_plan\_sku\_tier) | App backend app plan sku tier | `string` | `"PremiumV3"` | no |
| <a name="input_application_insights_name"></a> [application\_insights\_name](#input\_application\_insights\_name) | The common Application Insights name | `string` | `""` | no |
| <a name="input_azdo_sp_tls_cert_enabled"></a> [azdo\_sp\_tls\_cert\_enabled](#input\_azdo\_sp\_tls\_cert\_enabled) | Enable Azure DevOps connection for TLS cert management | `string` | `false` | no |
| <a name="input_azdoa_image_name"></a> [azdoa\_image\_name](#input\_azdoa\_image\_name) | Azure DevOps Agent image name | `string` | n/a | yes |
| <a name="input_cidr_common_in_vnet"></a> [cidr\_common\_in\_vnet](#input\_cidr\_common\_in\_vnet) | Common Italy North Virtual network cidr. | `list(string)` | n/a | yes |
| <a name="input_cidr_common_vnet"></a> [cidr\_common\_vnet](#input\_cidr\_common\_vnet) | Common Virtual network cidr. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_apim"></a> [cidr\_subnet\_apim](#input\_cidr\_subnet\_apim) | Old Api Management address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_apim_v2"></a> [cidr\_subnet\_apim\_v2](#input\_cidr\_subnet\_apim\_v2) | Api Management V2 address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_appbackendl1"></a> [cidr\_subnet\_appbackendl1](#input\_cidr\_subnet\_appbackendl1) | App backend l1 address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_appbackendl2"></a> [cidr\_subnet\_appbackendl2](#input\_cidr\_subnet\_appbackendl2) | App backend l2 address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_appbackendli"></a> [cidr\_subnet\_appbackendli](#input\_cidr\_subnet\_appbackendli) | App backend li address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_appgateway"></a> [cidr\_subnet\_appgateway](#input\_cidr\_subnet\_appgateway) | Application gateway address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_azdoa"></a> [cidr\_subnet\_azdoa](#input\_cidr\_subnet\_azdoa) | Azure DevOps agent network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_devportalservicedata_db_server"></a> [cidr\_subnet\_devportalservicedata\_db\_server](#input\_cidr\_subnet\_devportalservicedata\_db\_server) | Space address for DevPortal Service Data PostgresSQL | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_dnsforwarder"></a> [cidr\_subnet\_dnsforwarder](#input\_cidr\_subnet\_dnsforwarder) | DNS Forwarder network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_eventhub"></a> [cidr\_subnet\_eventhub](#input\_cidr\_subnet\_eventhub) | Eventhub network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_fnelt"></a> [cidr\_subnet\_fnelt](#input\_cidr\_subnet\_fnelt) | function-elt network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_fnfastlogin"></a> [cidr\_subnet\_fnfastlogin](#input\_cidr\_subnet\_fnfastlogin) | Function Fast Login address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_fnlollipop"></a> [cidr\_subnet\_fnlollipop](#input\_cidr\_subnet\_fnlollipop) | Function Lollipop address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_pendpoints"></a> [cidr\_subnet\_pendpoints](#input\_cidr\_subnet\_pendpoints) | Private Endpoints address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_redis_apim"></a> [cidr\_subnet\_redis\_apim](#input\_cidr\_subnet\_redis\_apim) | Redis network address space. | `list(string)` | `[]` | no |
| <a name="input_cidr_subnet_redis_common"></a> [cidr\_subnet\_redis\_common](#input\_cidr\_subnet\_redis\_common) | Redis common network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_selfcare_be"></a> [cidr\_subnet\_selfcare\_be](#input\_cidr\_subnet\_selfcare\_be) | Selfcare IO frontend storage address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_shared_1"></a> [cidr\_subnet\_shared\_1](#input\_cidr\_subnet\_shared\_1) | n/a | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_vpn"></a> [cidr\_subnet\_vpn](#input\_cidr\_subnet\_vpn) | VPN network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_weu_beta_vnet"></a> [cidr\_weu\_beta\_vnet](#input\_cidr\_weu\_beta\_vnet) | Beta Virtual network cidr. | `list(string)` | n/a | yes |
| <a name="input_cidr_weu_prod01_vnet"></a> [cidr\_weu\_prod01\_vnet](#input\_cidr\_weu\_prod01\_vnet) | Prod01 Virtual network cidr. | `list(string)` | n/a | yes |
| <a name="input_cidr_weu_prod02_vnet"></a> [cidr\_weu\_prod02\_vnet](#input\_cidr\_weu\_prod02\_vnet) | Prod02 Virtual network cidr. | `list(string)` | n/a | yes |
| <a name="input_citizen_auth_assertion_storage_name"></a> [citizen\_auth\_assertion\_storage\_name](#input\_citizen\_auth\_assertion\_storage\_name) | Use storage name from citizen\_auth domain | `string` | `"lollipop-assertions-st"` | no |
| <a name="input_citizen_auth_domain"></a> [citizen\_auth\_domain](#input\_citizen\_auth\_domain) | n/a | `string` | `"citizen-auth"` | no |
| <a name="input_citizen_auth_product"></a> [citizen\_auth\_product](#input\_citizen\_auth\_product) | Use product name from citizen\_auth domain locals | `string` | `"io-p"` | no |
| <a name="input_citizen_auth_revoke_queue_name"></a> [citizen\_auth\_revoke\_queue\_name](#input\_citizen\_auth\_revoke\_queue\_name) | Use queue storage name from citizen\_auth domain storage | `string` | `"pubkeys-revoke-v2"` | no |
| <a name="input_common_rg"></a> [common\_rg](#input\_common\_rg) | Common Virtual network resource group name. | `string` | `""` | no |
| <a name="input_ddos_protection_plan"></a> [ddos\_protection\_plan](#input\_ddos\_protection\_plan) | n/a | <pre>object({<br/>    id     = string<br/>    enable = bool<br/>  })</pre> | `null` | no |
| <a name="input_dns_default_ttl_sec"></a> [dns\_default\_ttl\_sec](#input\_dns\_default\_ttl\_sec) | value | `number` | `3600` | no |
| <a name="input_dns_zone_firmaconio_selfcare"></a> [dns\_zone\_firmaconio\_selfcare](#input\_dns\_zone\_firmaconio\_selfcare) | The dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_io"></a> [dns\_zone\_io](#input\_dns\_zone\_io) | The dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_io_selfcare"></a> [dns\_zone\_io\_selfcare](#input\_dns\_zone\_io\_selfcare) | The dns subdomain. | `string` | `null` | no |
| <a name="input_enable_azdoa"></a> [enable\_azdoa](#input\_enable\_azdoa) | Enable Azure DevOps agent. | `bool` | n/a | yes |
| <a name="input_enable_iac_pipeline"></a> [enable\_iac\_pipeline](#input\_enable\_iac\_pipeline) | If true create the key vault policy to allow used by azure devops iac pipelines. | `bool` | `false` | no |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `"pagopa.it"` | no |
| <a name="input_function_app_count"></a> [function\_app\_count](#input\_function\_app\_count) | n/a | `number` | `2` | no |
| <a name="input_function_services_count"></a> [function\_services\_count](#input\_function\_services\_count) | Functions | `number` | `2` | no |
| <a name="input_io_receipt_remote_config_id"></a> [io\_receipt\_remote\_config\_id](#input\_io\_receipt\_remote\_config\_id) | The Remote Content Config ID of io-receipt service | `string` | `"01HMVM9W74RWH93NT1EYNKKNNR"` | no |
| <a name="input_io_receipt_remote_config_test_id"></a> [io\_receipt\_remote\_config\_test\_id](#input\_io\_receipt\_remote\_config\_test\_id) | The Remote Content Config ID of io-receipt service | `string` | `"01HMVMCDD3JFYTPKT4ZN4WQ73B"` | no |
| <a name="input_io_receipt_service_id"></a> [io\_receipt\_service\_id](#input\_io\_receipt\_service\_id) | The Service ID of io-receipt service | `string` | n/a | yes |
| <a name="input_io_receipt_service_test_id"></a> [io\_receipt\_service\_test\_id](#input\_io\_receipt\_service\_test\_id) | The Service ID of io-receipt service | `string` | n/a | yes |
| <a name="input_io_receipt_service_test_url"></a> [io\_receipt\_service\_test\_url](#input\_io\_receipt\_service\_test\_url) | The endpoint of Receipt Service (test env) | `string` | n/a | yes |
| <a name="input_io_receipt_service_url"></a> [io\_receipt\_service\_url](#input\_io\_receipt\_service\_url) | The endpoint of Receipt Service (prod env) | `string` | n/a | yes |
| <a name="input_io_sign_remote_config_id"></a> [io\_sign\_remote\_config\_id](#input\_io\_sign\_remote\_config\_id) | The Remote Content Config ID of io-sign service | `string` | `"01HMVMDTHXCESMZ72NA701EKGQ"` | no |
| <a name="input_io_sign_service_id"></a> [io\_sign\_service\_id](#input\_io\_sign\_service\_id) | The Service ID of io-sign service | `string` | `"01GQQZ9HF5GAPRVKJM1VDAVFHM"` | no |
| <a name="input_io_wallet_trial_id"></a> [io\_wallet\_trial\_id](#input\_io\_wallet\_trial\_id) | The trial ID of io-wallet trial | `string` | `"01J2GN4TA8FB6DPTAX3T3YD6M1"` | no |
| <a name="input_law_daily_quota_gb"></a> [law\_daily\_quota\_gb](#input\_law\_daily\_quota\_gb) | The workspace daily quota for ingestion in GB. | `number` | `-1` | no |
| <a name="input_law_retention_in_days"></a> [law\_retention\_in\_days](#input\_law\_retention\_in\_days) | The workspace data retention in days | `number` | `90` | no |
| <a name="input_law_sku"></a> [law\_sku](#input\_law\_sku) | Sku of the Log Analytics Workspace | `string` | `"PerGB2018"` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"westeurope"` | no |
| <a name="input_location_in"></a> [location\_in](#input\_location\_in) | n/a | `string` | `"italynorth"` | no |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of weu, neu | `string` | n/a | yes |
| <a name="input_lock_enable"></a> [lock\_enable](#input\_lock\_enable) | Apply locks to block accedentaly deletions. | `bool` | `false` | no |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | The common Log Analytics Workspace name | `string` | `""` | no |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_pn_remote_config_id"></a> [pn\_remote\_config\_id](#input\_pn\_remote\_config\_id) | The Remote Content Config ID of PN service | `string` | `"01HMVMHCZZ8D0VTFWMRHBM5D6F"` | no |
| <a name="input_pn_service_id"></a> [pn\_service\_id](#input\_pn\_service\_id) | The Service ID of PN service | `string` | `"01G40DWQGKY5GRWSNM4303VNRP"` | no |
| <a name="input_pn_test_endpoint"></a> [pn\_test\_endpoint](#input\_pn\_test\_endpoint) | The endpoint of PN (test env) | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"io"` | no |
| <a name="input_redis_apim_capacity"></a> [redis\_apim\_capacity](#input\_redis\_apim\_capacity) | # Redis cache | `number` | `1` | no |
| <a name="input_redis_apim_family"></a> [redis\_apim\_family](#input\_redis\_apim\_family) | n/a | `string` | `"C"` | no |
| <a name="input_redis_apim_sku_name"></a> [redis\_apim\_sku\_name](#input\_redis\_apim\_sku\_name) | n/a | `string` | `"Standard"` | no |
| <a name="input_redis_common"></a> [redis\_common](#input\_redis\_common) | Redis Common configuration | <pre>object({<br/>    capacity                      = number<br/>    shard_count                   = number<br/>    family                        = string<br/>    sku_name                      = string<br/>    public_network_access_enabled = bool<br/>    rdb_backup_enabled            = bool<br/>    rdb_backup_frequency          = number<br/>    rdb_backup_max_snapshot_count = number<br/>    redis_version                 = string<br/>  })</pre> | n/a | yes |
| <a name="input_selfcare_external_hostname"></a> [selfcare\_external\_hostname](#input\_selfcare\_external\_hostname) | Selfcare external hostname | `string` | `"selfcare.pagopa.it"` | no |
| <a name="input_selfcare_plan_sku_capacity"></a> [selfcare\_plan\_sku\_capacity](#input\_selfcare\_plan\_sku\_capacity) | Selfcare app plan capacity | `number` | `1` | no |
| <a name="input_selfcare_plan_sku_size"></a> [selfcare\_plan\_sku\_size](#input\_selfcare\_plan\_sku\_size) | Selfcare app plan sku size | `string` | `"P1v3"` | no |
| <a name="input_selfcare_plan_sku_tier"></a> [selfcare\_plan\_sku\_tier](#input\_selfcare\_plan\_sku\_tier) | Selfcare app plan sku tier | `string` | `"PremiumV3"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br/>  "CreatedBy": "Terraform"<br/>}</pre> | no |
| <a name="input_third_party_mock_remote_config_id"></a> [third\_party\_mock\_remote\_config\_id](#input\_third\_party\_mock\_remote\_config\_id) | The Remote Content Config ID of the Third Party Mock service | `string` | `"01HMVM4N4XFJ8VBR1FXYFZ9QFB"` | no |
| <a name="input_third_party_mock_service_id"></a> [third\_party\_mock\_service\_id](#input\_third\_party\_mock\_service\_id) | The Service ID of the Third Party Mock service | `string` | `"01GQQDPM127KFGG6T3660D5TXD"` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Common Virtual network resource name. | `string` | `""` | no |
| <a name="input_vpn_pip_sku"></a> [vpn\_pip\_sku](#input\_vpn\_pip\_sku) | VPN GW PIP SKU | `string` | `"Basic"` | no |
| <a name="input_vpn_sku"></a> [vpn\_sku](#input\_vpn\_sku) | VPN Gateway SKU | `string` | `"VpnGw1"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
