<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 2.76.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.3.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.76.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.1.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apim"></a> [apim](#module\_apim) | git::https://github.com/pagopa/azurerm.git//api_management | v1.0.74 |
| <a name="module_apim_io_backend_app_api_v1"></a> [apim\_io\_backend\_app\_api\_v1](#module\_apim\_io\_backend\_app\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_io_backend_auth_api_v1"></a> [apim\_io\_backend\_auth\_api\_v1](#module\_apim\_io\_backend\_auth\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_io_backend_bonus_api_v1"></a> [apim\_io\_backend\_bonus\_api\_v1](#module\_apim\_io\_backend\_bonus\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_io_backend_bpd_api_v1"></a> [apim\_io\_backend\_bpd\_api\_v1](#module\_apim\_io\_backend\_bpd\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_io_backend_cgn_api_v1"></a> [apim\_io\_backend\_cgn\_api\_v1](#module\_apim\_io\_backend\_cgn\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_io_backend_eucovidcert_api_v1"></a> [apim\_io\_backend\_eucovidcert\_api\_v1](#module\_apim\_io\_backend\_eucovidcert\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_io_backend_mitvoucher_api_v1"></a> [apim\_io\_backend\_mitvoucher\_api\_v1](#module\_apim\_io\_backend\_mitvoucher\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_io_backend_myportal_api_v1"></a> [apim\_io\_backend\_myportal\_api\_v1](#module\_apim\_io\_backend\_myportal\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_io_backend_notifications_api_v1"></a> [apim\_io\_backend\_notifications\_api\_v1](#module\_apim\_io\_backend\_notifications\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_io_backend_pagopa_api_v1"></a> [apim\_io\_backend\_pagopa\_api\_v1](#module\_apim\_io\_backend\_pagopa\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_io_backend_product"></a> [apim\_io\_backend\_product](#module\_apim\_io\_backend\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_apim_io_backend_public_api_v1"></a> [apim\_io\_backend\_public\_api\_v1](#module\_apim\_io\_backend\_public\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_io_backend_session_api_v1"></a> [apim\_io\_backend\_session\_api\_v1](#module\_apim\_io\_backend\_session\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_snet"></a> [apim\_snet](#module\_apim\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.51 |
| <a name="module_app_gw"></a> [app\_gw](#module\_app\_gw) | git::https://github.com/pagopa/azurerm.git//app_gateway | v1.0.87 |
| <a name="module_appgateway_snet"></a> [appgateway\_snet](#module\_appgateway\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.51 |
| <a name="module_azdoa_li"></a> [azdoa\_li](#module\_azdoa\_li) | git::https://github.com/pagopa/azurerm.git//azure_devops_agent | v1.0.57 |
| <a name="module_dns_forwarder_snet"></a> [dns\_forwarder\_snet](#module\_dns\_forwarder\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.7 |
| <a name="module_event_hub"></a> [event\_hub](#module\_event\_hub) | git::https://github.com/pagopa/azurerm.git//eventhub | v1.0.66 |
| <a name="module_eventhub_snet"></a> [eventhub\_snet](#module\_eventhub\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.7 |
| <a name="module_function_elt"></a> [function\_elt](#module\_function\_elt) | git::https://github.com/pagopa/azurerm.git//function_app | v1.0.65 |
| <a name="module_function_elt_snetout"></a> [function\_elt\_snetout](#module\_function\_elt\_snetout) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.60 |
| <a name="module_function_pblevtdispatcher"></a> [function\_pblevtdispatcher](#module\_function\_pblevtdispatcher) | git::https://github.com/pagopa/azurerm.git//function_app | v1.0.65 |
| <a name="module_function_pblevtdispatcher_snetout"></a> [function\_pblevtdispatcher\_snetout](#module\_function\_pblevtdispatcher\_snetout) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.60 |
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | git::https://github.com/pagopa/azurerm.git//key_vault | v1.0.48 |
| <a name="module_storage_account_elt"></a> [storage\_account\_elt](#module\_storage\_account\_elt) | git::https://github.com/pagopa/azurerm.git//storage_account | v1.0.60 |
| <a name="module_storage_account_pblevtdispatcher"></a> [storage\_account\_pblevtdispatcher](#module\_storage\_account\_pblevtdispatcher) | git::https://github.com/pagopa/azurerm.git//storage_account | v1.0.60 |
| <a name="module_vpn"></a> [vpn](#module\_vpn) | git::https://github.com/pagopa/azurerm.git//vpn_gateway | v1.0.36 |
| <a name="module_vpn_snet"></a> [vpn\_snet](#module\_vpn\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v1.0.58 |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_api_version_set.io_backend_app_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.io_backend_auth_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.io_backend_bonus_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.io_backend_bpd_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.io_backend_cgn_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.io_backend_eucovidcert_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.io_backend_mitvoucher_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.io_backend_myportal_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.io_backend_notifications_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.io_backend_pagopa_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.io_backend_public_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.io_backend_session_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/api_management_api_version_set) | resource |
| [azurerm_container_group.coredns_forwarder](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/container_group) | resource |
| [azurerm_dns_a_record.api_app_io_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.api_io_italia_it](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.api_io_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.api_mtls_io_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.developerportal_backend_io_italia_it](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_caa_record.io_italia_it](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/dns_caa_record) | resource |
| [azurerm_dns_caa_record.io_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/dns_caa_record) | resource |
| [azurerm_dns_zone.io_italia_it](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/dns_zone) | resource |
| [azurerm_dns_zone.io_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/dns_zone) | resource |
| [azurerm_key_vault_access_policy.ad_group_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_developers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_externals_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_security_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.apim_kv_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.app_gateway_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.app_gateway_policy_common](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.app_gw_uai_kvreader_common](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.app_service](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_policy_common](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.cdn](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.common](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.policy_common_admin](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.event_hub_keys](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/key_vault_secret) | resource |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/monitor_action_group) | resource |
| [azurerm_network_profile.dns_forwarder](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/network_profile) | resource |
| [azurerm_private_dns_a_record.api_app_internal_io](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_zone.internal_io_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.internal_io_pagopa_it_private_vnet_common](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_public_ip.appgateway_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/public_ip) | resource |
| [azurerm_resource_group.azdo_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.data](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.default_roleassignment_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.dns_forwarder](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.elt_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.event_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.pblevtdispatcher_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_external](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_internal](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/resource_group) | resource |
| [azurerm_storage_account.dns_forwarder](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/storage_account) | resource |
| [azurerm_storage_queue.storage_account_apievents_events_queue](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.storage_account_pblevtdispatcher_http_call_jobs_queue](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/storage_queue) | resource |
| [azurerm_storage_share.dns_forwarder](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/storage_share) | resource |
| [azurerm_storage_table.fneltcommands](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/storage_table) | resource |
| [azurerm_storage_table.fnelterrors](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/storage_table) | resource |
| [azurerm_user_assigned_identity.appgateway](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/user_assigned_identity) | resource |
| [azurerm_web_application_firewall_policy.api_app](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/web_application_firewall_policy) | resource |
| [null_resource.upload_corefile](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azuread_application.vpn_app](https://registry.terraform.io/providers/hashicorp/azuread/2.3.0/docs/data-sources/application) | data source |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.3.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.3.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.3.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.3.0/docs/data-sources/group) | data source |
| [azuread_service_principal.app_gw_uai_kvreader](https://registry.terraform.io/providers/hashicorp/azuread/2.3.0/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.iac_principal](https://registry.terraform.io/providers/hashicorp/azuread/2.3.0/docs/data-sources/service_principal) | data source |
| [azurerm_app_service.appbackendl1](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/app_service) | data source |
| [azurerm_app_service.appbackendl2](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/app_service) | data source |
| [azurerm_app_service.appbackendli](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/app_service) | data source |
| [azurerm_app_service.developerportalbackend](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/app_service) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/client_config) | data source |
| [azurerm_cosmosdb_account.cosmos_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/cosmosdb_account) | data source |
| [azurerm_function_app.fnapp_eucovidcert](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/function_app) | data source |
| [azurerm_key_vault.common](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_certificate.api_app_internal_io_pagopa_it](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.api_internal_io_italia_it](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.app_gw_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.app_gw_api_app](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.app_gw_api_io_italia_it](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.app_gw_api_mtls](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.app_gw_app_backend_io_italia_it](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_certificate.app_gw_developerportal_backend_io_italia_it](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_secret.apim_publisher_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.app_gw_mtls_header_name](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.fnapp_eucovidcert_authtoken](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_notification_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.monitor_notification_slack_email](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.sec_storage_id](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.sec_workspace_id](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_log_analytics_workspace.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.vnet_common_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.storage_apievents](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.azdoa_snet](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet_common](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/data-sources/virtual_network) | data source |
| [local_file.corefile](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_publisher_name"></a> [apim\_publisher\_name](#input\_apim\_publisher\_name) | # Apim | `string` | n/a | yes |
| <a name="input_apim_sku"></a> [apim\_sku](#input\_apim\_sku) | n/a | `string` | n/a | yes |
| <a name="input_app_gateway_alerts_enabled"></a> [app\_gateway\_alerts\_enabled](#input\_app\_gateway\_alerts\_enabled) | Enable alerts | `bool` | `true` | no |
| <a name="input_app_gateway_api_app_certificate_name"></a> [app\_gateway\_api\_app\_certificate\_name](#input\_app\_gateway\_api\_app\_certificate\_name) | Application gateway api certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_api_certificate_name"></a> [app\_gateway\_api\_certificate\_name](#input\_app\_gateway\_api\_certificate\_name) | Application gateway api certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_api_io_italia_it_certificate_name"></a> [app\_gateway\_api\_io\_italia\_it\_certificate\_name](#input\_app\_gateway\_api\_io\_italia\_it\_certificate\_name) | Application gateway api certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_api_mtls_certificate_name"></a> [app\_gateway\_api\_mtls\_certificate\_name](#input\_app\_gateway\_api\_mtls\_certificate\_name) | Application gateway api certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_app_backend_io_italia_it_certificate_name"></a> [app\_gateway\_app\_backend\_io\_italia\_it\_certificate\_name](#input\_app\_gateway\_app\_backend\_io\_italia\_it\_certificate\_name) | Application gateway api certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_developerportal_backend_io_italia_it_certificate_name"></a> [app\_gateway\_developerportal\_backend\_io\_italia\_it\_certificate\_name](#input\_app\_gateway\_developerportal\_backend\_io\_italia\_it\_certificate\_name) | Application gateway api certificate name on Key Vault | `string` | n/a | yes |
| <a name="input_app_gateway_max_capacity"></a> [app\_gateway\_max\_capacity](#input\_app\_gateway\_max\_capacity) | n/a | `number` | `2` | no |
| <a name="input_app_gateway_min_capacity"></a> [app\_gateway\_min\_capacity](#input\_app\_gateway\_min\_capacity) | n/a | `number` | `0` | no |
| <a name="input_application_insights_name"></a> [application\_insights\_name](#input\_application\_insights\_name) | The common Application Insights name | `string` | `""` | no |
| <a name="input_azdo_sp_tls_cert_enabled"></a> [azdo\_sp\_tls\_cert\_enabled](#input\_azdo\_sp\_tls\_cert\_enabled) | Enable Azure DevOps connection for TLS cert management | `string` | `false` | no |
| <a name="input_cidr_subnet_apim"></a> [cidr\_subnet\_apim](#input\_cidr\_subnet\_apim) | Api Management address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_appgateway"></a> [cidr\_subnet\_appgateway](#input\_cidr\_subnet\_appgateway) | Application gateway address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_azdoa"></a> [cidr\_subnet\_azdoa](#input\_cidr\_subnet\_azdoa) | Azure DevOps agent network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_dnsforwarder"></a> [cidr\_subnet\_dnsforwarder](#input\_cidr\_subnet\_dnsforwarder) | DNS Forwarder network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_eventhub"></a> [cidr\_subnet\_eventhub](#input\_cidr\_subnet\_eventhub) | Eventhub network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_fnelt"></a> [cidr\_subnet\_fnelt](#input\_cidr\_subnet\_fnelt) | function-elt network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_fnpblevtdispatcher"></a> [cidr\_subnet\_fnpblevtdispatcher](#input\_cidr\_subnet\_fnpblevtdispatcher) | function-publiceventdispatcher network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_redis_apim"></a> [cidr\_subnet\_redis\_apim](#input\_cidr\_subnet\_redis\_apim) | Redis network address space. | `list(string)` | `[]` | no |
| <a name="input_cidr_subnet_vpn"></a> [cidr\_subnet\_vpn](#input\_cidr\_subnet\_vpn) | VPN network address space. | `list(string)` | n/a | yes |
| <a name="input_common_rg"></a> [common\_rg](#input\_common\_rg) | Common Virtual network resource group name. | `string` | `""` | no |
| <a name="input_dns_default_ttl_sec"></a> [dns\_default\_ttl\_sec](#input\_dns\_default\_ttl\_sec) | value | `number` | `3600` | no |
| <a name="input_dns_zone_io"></a> [dns\_zone\_io](#input\_dns\_zone\_io) | The dns subdomain. | `string` | `null` | no |
| <a name="input_ehns_alerts_enabled"></a> [ehns\_alerts\_enabled](#input\_ehns\_alerts\_enabled) | Event hub alerts enabled? | `bool` | `true` | no |
| <a name="input_ehns_auto_inflate_enabled"></a> [ehns\_auto\_inflate\_enabled](#input\_ehns\_auto\_inflate\_enabled) | Is Auto Inflate enabled for the EventHub Namespace? | `bool` | `false` | no |
| <a name="input_ehns_capacity"></a> [ehns\_capacity](#input\_ehns\_capacity) | Specifies the Capacity / Throughput Units for a Standard SKU namespace. | `number` | `null` | no |
| <a name="input_ehns_ip_rules"></a> [ehns\_ip\_rules](#input\_ehns\_ip\_rules) | eventhub network rules | <pre>list(object({<br>    ip_mask = string<br>    action  = string<br>  }))</pre> | `[]` | no |
| <a name="input_ehns_maximum_throughput_units"></a> [ehns\_maximum\_throughput\_units](#input\_ehns\_maximum\_throughput\_units) | Specifies the maximum number of throughput units when Auto Inflate is Enabled | `number` | `null` | no |
| <a name="input_ehns_metric_alerts"></a> [ehns\_metric\_alerts](#input\_ehns\_metric\_alerts) | Map of name = criteria objects | <pre>map(object({<br>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br>    aggregation = string<br>    metric_name = string<br>    description = string<br>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br>    operator  = string<br>    threshold = number<br>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br>    frequency = string<br>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br>    window_size = string<br><br>    dimension = list(object(<br>      {<br>        name     = string<br>        operator = string<br>        values   = list(string)<br>      }<br>    ))<br>  }))</pre> | `{}` | no |
| <a name="input_ehns_sku_name"></a> [ehns\_sku\_name](#input\_ehns\_sku\_name) | Defines which tier to use. | `string` | `"Basic"` | no |
| <a name="input_ehns_zone_redundant"></a> [ehns\_zone\_redundant](#input\_ehns\_zone\_redundant) | Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones). | `bool` | `false` | no |
| <a name="input_enable_azdoa"></a> [enable\_azdoa](#input\_enable\_azdoa) | Enable Azure DevOps agent. | `bool` | n/a | yes |
| <a name="input_enable_iac_pipeline"></a> [enable\_iac\_pipeline](#input\_enable\_iac\_pipeline) | If true create the key vault policy to allow used by azure devops iac pipelines. | `bool` | `false` | no |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_eventhubs"></a> [eventhubs](#input\_eventhubs) | A list of event hubs to add to namespace. | <pre>list(object({<br>    name              = string<br>    partitions        = number<br>    message_retention = number<br>    consumers         = list(string)<br>    keys = list(object({<br>      name   = string<br>      listen = bool<br>      send   = bool<br>      manage = bool<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `"pagopa.it"` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"westeurope"` | no |
| <a name="input_lock_enable"></a> [lock\_enable](#input\_lock\_enable) | Apply locks to block accedentaly deletions. | `bool` | `false` | no |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | The common Log Analytics Workspace name | `string` | `""` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"io"` | no |
| <a name="input_redis_apim_capacity"></a> [redis\_apim\_capacity](#input\_redis\_apim\_capacity) | # Redis cache | `number` | `1` | no |
| <a name="input_redis_apim_family"></a> [redis\_apim\_family](#input\_redis\_apim\_family) | n/a | `string` | `"C"` | no |
| <a name="input_redis_apim_sku_name"></a> [redis\_apim\_sku\_name](#input\_redis\_apim\_sku\_name) | n/a | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Common Virtual network resource name. | `string` | `""` | no |
| <a name="input_vpn_pip_sku"></a> [vpn\_pip\_sku](#input\_vpn\_pip\_sku) | VPN GW PIP SKU | `string` | `"Basic"` | no |
| <a name="input_vpn_sku"></a> [vpn\_sku](#input\_vpn\_sku) | VPN Gateway SKU | `string` | `"VpnGw1"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
