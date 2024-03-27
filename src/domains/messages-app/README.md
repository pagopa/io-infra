<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 2.33.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.96.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | = 2.8.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | = 2.17.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_app_messages_function"></a> [app\_messages\_function](#module\_app\_messages\_function) | github.com/pagopa/terraform-azurerm-v3//function_app | v7.69.1 |
| <a name="module_app_messages_function_staging_slot"></a> [app\_messages\_function\_staging\_slot](#module\_app\_messages\_function\_staging\_slot) | github.com/pagopa/terraform-azurerm-v3//function_app_slot | v7.69.1 |
| <a name="module_app_messages_snet"></a> [app\_messages\_snet](#module\_app\_messages\_snet) | github.com/pagopa/terraform-azurerm-v3//subnet | v7.69.1 |
| <a name="module_event_hub"></a> [event\_hub](#module\_event\_hub) | github.com/pagopa/terraform-azurerm-v3//eventhub | v7.69.1 |
| <a name="module_function_messages_cqrs"></a> [function\_messages\_cqrs](#module\_function\_messages\_cqrs) | github.com/pagopa/terraform-azurerm-v3//function_app | v7.70.1 |
| <a name="module_function_messages_cqrs_snet"></a> [function\_messages\_cqrs\_snet](#module\_function\_messages\_cqrs\_snet) | github.com/pagopa/terraform-azurerm-v3//subnet | v7.70.1 |
| <a name="module_function_messages_cqrs_staging_slot"></a> [function\_messages\_cqrs\_staging\_slot](#module\_function\_messages\_cqrs\_staging\_slot) | github.com/pagopa/terraform-azurerm-v3//function_app_slot | v7.70.1 |
| <a name="module_pod_identity"></a> [pod\_identity](#module\_pod\_identity) | github.com/pagopa/terraform-azurerm-v3//kubernetes_pod_identity | v7.69.1 |
| <a name="module_push_notif_function"></a> [push\_notif\_function](#module\_push\_notif\_function) | github.com/pagopa/terraform-azurerm-v3//function_app | v7.71.1 |
| <a name="module_push_notif_function_staging_slot"></a> [push\_notif\_function\_staging\_slot](#module\_push\_notif\_function\_staging\_slot) | github.com/pagopa/terraform-azurerm-v3//function_app_slot | v7.71.1 |
| <a name="module_push_notif_snet"></a> [push\_notif\_snet](#module\_push\_notif\_snet) | github.com/pagopa/terraform-azurerm-v3//subnet | v7.69.1 |
| <a name="module_services_storage"></a> [services\_storage](#module\_services\_storage) | github.com/pagopa/terraform-azurerm-v3//storage_account | v7.69.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_access_policy.common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.aks_apiserver_url](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_cacrt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.event_hub_keys](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.services_storage_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_monitor_autoscale_setting.app_messages_function](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.function_messages_cqrs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.push_notif_function](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_metric_alert.tls_cert_check](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_private_dns_a_record.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_endpoint.services_storage_blob](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.app_messages_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.backend_messages_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.data_process_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.event_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.push_notif_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_container.services_storage_messages](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_management_policy.services_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) | resource |
| [helm_release.cert-mounter](https://registry.terraform.io/providers/hashicorp/helm/2.8.0/docs/resources/release) | resource |
| [helm_release.reloader](https://registry.terraform.io/providers/hashicorp/helm/2.8.0/docs/resources/release) | resource |
| [helm_release.tls_cert_check](https://registry.terraform.io/providers/hashicorp/helm/2.8.0/docs/resources/release) | resource |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/2.17.0/docs/resources/namespace) | resource |
| [kubernetes_namespace.namespace_system](https://registry.terraform.io/providers/hashicorp/kubernetes/2.17.0/docs/resources/namespace) | resource |
| [kubernetes_role_binding.deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/2.17.0/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.system_deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/2.17.0/docs/resources/role_binding) | resource |
| [kubernetes_secret.azure_devops_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/2.17.0/docs/resources/secret) | resource |
| [kubernetes_service_account.azure_devops](https://registry.terraform.io/providers/hashicorp/kubernetes/2.17.0/docs/resources/service_account) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_cosmosdb_account.cosmos_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/cosmosdb_account) | data source |
| [azurerm_cosmosdb_account.cosmos_remote_content](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/cosmosdb_account) | data source |
| [azurerm_eventhub_authorization_rule.evh_ns_io_auth_cdc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.evh_ns_io_auth_messages](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.io-p-messages-weu-prod01-evh-ns_message-status_io-fn-messages-cqrs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.io-p-messages-weu-prod01-evh-ns_messages_io-fn-messages-cqrs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_authorization_rule.io-p-payments-weu-prod01-evh-ns_payment-updates_io-fn-messages-cqrs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_authorization_rule) | data source |
| [azurerm_eventhub_namespace.messages-weu-prod01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventhub_namespace) | data source |
| [azurerm_key_vault.common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.kv_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.apim_services_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.azure_nh_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.azure_nh_partition1_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.azure_nh_partition2_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.azure_nh_partition3_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.azure_nh_partition4_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fn_messages_APP_MESSAGES_BETA_FISCAL_CODES](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.error_action_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_notification_hub.common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/notification_hub) | data source |
| [azurerm_notification_hub.common_partition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/notification_hub) | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_blob_core_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_documents_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_file_core_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_queue_core_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_servicebus_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_table_core_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_redis_cache.redis_messages](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/redis_cache) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.notifications_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.push_notif_beta_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.push_notifications_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.storage_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.apim_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.app_backendl1_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.app_backendl2_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.azdoa_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.private_endpoints_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [kubernetes_secret.azure_devops_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/2.17.0/docs/data-sources/secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_messages_count"></a> [app\_messages\_count](#input\_app\_messages\_count) | ############################## Messages functions ############################## | `number` | `0` | no |
| <a name="input_application_insights_name"></a> [application\_insights\_name](#input\_application\_insights\_name) | Specifies the name of the Application Insights. | `string` | n/a | yes |
| <a name="input_cidr_subnet_appmessages"></a> [cidr\_subnet\_appmessages](#input\_cidr\_subnet\_appmessages) | App messages address space. | `list(string)` | `[]` | no |
| <a name="input_cidr_subnet_fnmessagescqrs"></a> [cidr\_subnet\_fnmessagescqrs](#input\_cidr\_subnet\_fnmessagescqrs) | Fn cqrs address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_push_notif"></a> [cidr\_subnet\_push\_notif](#input\_cidr\_subnet\_push\_notif) | Function push-notif address space. | `list(string)` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_ehns_alerts_enabled"></a> [ehns\_alerts\_enabled](#input\_ehns\_alerts\_enabled) | Event hub alerts enabled? | `bool` | `true` | no |
| <a name="input_ehns_auto_inflate_enabled"></a> [ehns\_auto\_inflate\_enabled](#input\_ehns\_auto\_inflate\_enabled) | Is Auto Inflate enabled for the EventHub Namespace? | `bool` | `false` | no |
| <a name="input_ehns_capacity"></a> [ehns\_capacity](#input\_ehns\_capacity) | Specifies the Capacity / Throughput Units for a Standard SKU namespace. | `number` | `null` | no |
| <a name="input_ehns_enabled"></a> [ehns\_enabled](#input\_ehns\_enabled) | Enable event hub namespace | `bool` | `false` | no |
| <a name="input_ehns_ip_rules"></a> [ehns\_ip\_rules](#input\_ehns\_ip\_rules) | eventhub network rules | <pre>list(object({<br>    ip_mask = string<br>    action  = string<br>  }))</pre> | `[]` | no |
| <a name="input_ehns_maximum_throughput_units"></a> [ehns\_maximum\_throughput\_units](#input\_ehns\_maximum\_throughput\_units) | Specifies the maximum number of throughput units when Auto Inflate is Enabled | `number` | `null` | no |
| <a name="input_ehns_metric_alerts"></a> [ehns\_metric\_alerts](#input\_ehns\_metric\_alerts) | Map of name = criteria objects | <pre>map(object({<br>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br>    aggregation = string<br>    metric_name = string<br>    description = string<br>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br>    operator  = string<br>    threshold = number<br>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br>    frequency = string<br>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br>    window_size = string<br><br>    dimension = list(object(<br>      {<br>        name     = string<br>        operator = string<br>        values   = list(string)<br>      }<br>    ))<br>  }))</pre> | `{}` | no |
| <a name="input_ehns_sku_name"></a> [ehns\_sku\_name](#input\_ehns\_sku\_name) | Defines which tier to use. | `string` | `"Basic"` | no |
| <a name="input_ehns_virtual_network_rules"></a> [ehns\_virtual\_network\_rules](#input\_ehns\_virtual\_network\_rules) | eventhub virtual network rules | <pre>list(object({<br>    ip_mask = string<br>    action  = string<br>  }))</pre> | `[]` | no |
| <a name="input_ehns_zone_redundant"></a> [ehns\_zone\_redundant](#input\_ehns\_zone\_redundant) | Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones). | `bool` | `false` | no |
| <a name="input_enable_azdoa"></a> [enable\_azdoa](#input\_enable\_azdoa) | Specifies Azure Devops Agent enabling | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_eventhubs"></a> [eventhubs](#input\_eventhubs) | A list of event hubs to add to namespace. | <pre>list(object({<br>    name              = string<br>    partitions        = number<br>    message_retention = number<br>    consumers         = list(string)<br>    keys = list(object({<br>      name   = string<br>      listen = bool<br>      send   = bool<br>      manage = bool<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | n/a | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_io_receipt_remote_config_id"></a> [io\_receipt\_remote\_config\_id](#input\_io\_receipt\_remote\_config\_id) | The Remote Content Config ID of io-receipt service | `string` | `"01HMVM9W74RWH93NT1EYNKKNNR"` | no |
| <a name="input_io_receipt_remote_config_test_id"></a> [io\_receipt\_remote\_config\_test\_id](#input\_io\_receipt\_remote\_config\_test\_id) | The Remote Content Config ID of io-receipt service | `string` | `"01HMVMCDD3JFYTPKT4ZN4WQ73B"` | no |
| <a name="input_io_receipt_service_id"></a> [io\_receipt\_service\_id](#input\_io\_receipt\_service\_id) | The Service ID of io-receipt service | `string` | `"01HD63674XJ1R6XCNHH24PCRR2"` | no |
| <a name="input_io_receipt_service_test_id"></a> [io\_receipt\_service\_test\_id](#input\_io\_receipt\_service\_test\_id) | The Service ID of io-receipt service | `string` | `"01H4ZJ62C1CPGJ0PX8Q1BP7FAB"` | no |
| <a name="input_io_sign_remote_config_id"></a> [io\_sign\_remote\_config\_id](#input\_io\_sign\_remote\_config\_id) | The Remote Content Config ID of io-sign service | `string` | `"01HMVMDTHXCESMZ72NA701EKGQ"` | no |
| <a name="input_io_sign_service_id"></a> [io\_sign\_service\_id](#input\_io\_sign\_service\_id) | The Service ID of io-sign service | `string` | `"01GQQZ9HF5GAPRVKJM1VDAVFHM"` | no |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_location_string"></a> [location\_string](#input\_location\_string) | One of West Europe, North Europe | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_nh_name_prefix"></a> [nh\_name\_prefix](#input\_nh\_name\_prefix) | Notification Hub name prefix | `string` | n/a | yes |
| <a name="input_nh_namespace_prefix"></a> [nh\_namespace\_prefix](#input\_nh\_namespace\_prefix) | Notification Hub namespace prefix | `string` | n/a | yes |
| <a name="input_nh_partition_count"></a> [nh\_partition\_count](#input\_nh\_partition\_count) | Notification Hub partition count | `number` | `4` | no |
| <a name="input_nh_resource_group_name"></a> [nh\_resource\_group\_name](#input\_nh\_resource\_group\_name) | Notification Hub resource group name | `string` | n/a | yes |
| <a name="input_pn_remote_config_id"></a> [pn\_remote\_config\_id](#input\_pn\_remote\_config\_id) | The Remote Content Config ID of PN service | `string` | `"01HMVMHCZZ8D0VTFWMRHBM5D6F"` | no |
| <a name="input_pn_service_id"></a> [pn\_service\_id](#input\_pn\_service\_id) | The Service ID of PN service | `string` | `"01G40DWQGKY5GRWSNM4303VNRP"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_push_notif_count"></a> [push\_notif\_count](#input\_push\_notif\_count) | n/a | `number` | `2` | no |
| <a name="input_push_notif_enabled"></a> [push\_notif\_enabled](#input\_push\_notif\_enabled) | Push Notif function enabled? | `bool` | `false` | no |
| <a name="input_push_notif_function_always_on"></a> [push\_notif\_function\_always\_on](#input\_push\_notif\_function\_always\_on) | n/a | `bool` | `false` | no |
| <a name="input_push_notif_function_autoscale_default"></a> [push\_notif\_function\_autoscale\_default](#input\_push\_notif\_function\_autoscale\_default) | The number of instances that are available for scaling if metrics are not available for evaluation. | `number` | `1` | no |
| <a name="input_push_notif_function_autoscale_maximum"></a> [push\_notif\_function\_autoscale\_maximum](#input\_push\_notif\_function\_autoscale\_maximum) | The maximum number of instances for this resource. | `number` | `3` | no |
| <a name="input_push_notif_function_autoscale_minimum"></a> [push\_notif\_function\_autoscale\_minimum](#input\_push\_notif\_function\_autoscale\_minimum) | The minimum number of instances for this resource. | `number` | `1` | no |
| <a name="input_push_notif_function_kind"></a> [push\_notif\_function\_kind](#input\_push\_notif\_function\_kind) | App service plan kind | `string` | `null` | no |
| <a name="input_push_notif_function_sku_size"></a> [push\_notif\_function\_sku\_size](#input\_push\_notif\_function\_sku\_size) | App service plan sku size | `string` | `null` | no |
| <a name="input_push_notif_function_sku_tier"></a> [push\_notif\_function\_sku\_tier](#input\_push\_notif\_function\_sku\_tier) | App service plan sku tier | `string` | `null` | no |
| <a name="input_reloader_helm"></a> [reloader\_helm](#input\_reloader\_helm) | reloader helm chart configuration | <pre>object({<br>    chart_version = string,<br>    image_name    = string,<br>    image_tag     = string<br>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |
| <a name="input_third_party_mock_remote_config_id"></a> [third\_party\_mock\_remote\_config\_id](#input\_third\_party\_mock\_remote\_config\_id) | The Remote Content Config ID of the Third Party Mock service | `string` | `"01HMVM4N4XFJ8VBR1FXYFZ9QFB"` | no |
| <a name="input_third_party_mock_service_id"></a> [third\_party\_mock\_service\_id](#input\_third\_party\_mock\_service\_id) | The Service ID of the Third Party Mock service | `string` | `"01GQQDPM127KFGG6T3660D5TXD"` | no |
| <a name="input_tls_cert_check_enabled"></a> [tls\_cert\_check\_enabled](#input\_tls\_cert\_check\_enabled) | Enable tls cert check | `bool` | n/a | yes |
| <a name="input_tls_cert_check_helm"></a> [tls\_cert\_check\_helm](#input\_tls\_cert\_check\_helm) | tls cert helm chart configuration | <pre>object({<br>    chart_version = string,<br>    image_name    = string,<br>    image_tag     = string<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
