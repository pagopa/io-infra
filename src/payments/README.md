<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

| Name                                                                        | Version  |
| --------------------------------------------------------------------------- | -------- |
| <a name="requirement_azuread"></a> [azuread](#requirement_azuread)          | = 2.21.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm)          | = 2.98.0 |
| <a name="requirement_helm"></a> [helm](#requirement_helm)                   | = 2.5.1  |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement_kubernetes) | = 2.11.0 |
| <a name="requirement_null"></a> [null](#requirement_null)                   | = 3.1.1  |

## Providers

| Name                                                                  | Version |
| --------------------------------------------------------------------- | ------- |
| <a name="provider_azuread"></a> [azuread](#provider_azuread)          | 2.21.0  |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm)          | 2.98.0  |
| <a name="provider_helm"></a> [helm](#provider_helm)                   | 2.5.1   |
| <a name="provider_kubernetes"></a> [kubernetes](#provider_kubernetes) | 2.11.0  |
| <a name="provider_terraform"></a> [terraform](#provider_terraform)    | n/a     |

## Modules

| Name                                                                                | Source                                                              | Version |
| ----------------------------------------------------------------------------------- | ------------------------------------------------------------------- | ------- |
| <a name="module_pod_identity"></a> [pod_identity](#module_pod_identity)             | git::https://github.com/pagopa/azurerm.git//kubernetes_pod_identity | v2.13.1 |
| <a name="module_services_storage"></a> [services_storage](#module_services_storage) | git::https://github.com/pagopa/azurerm.git//storage_account         | v2.7.0  |

## Resources

| Name                                                                                                                                                               | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------- |
| [azurerm_key_vault_secret.aks_apiserver_url](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/resources/key_vault_secret)                     | resource    |
| [azurerm_key_vault_secret.azure_devops_sa_cacrt](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/resources/key_vault_secret)                 | resource    |
| [azurerm_key_vault_secret.azure_devops_sa_token](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/resources/key_vault_secret)                 | resource    |
| [azurerm_key_vault_secret.services_storage_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/resources/key_vault_secret)    | resource    |
| [azurerm_private_dns_a_record.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/resources/private_dns_a_record)                       | resource    |
| [azurerm_private_endpoint.services_storage_blob](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/resources/private_endpoint)                 | resource    |
| [azurerm_resource_group.data_process_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/resources/resource_group)                           | resource    |
| [azurerm_storage_container.services_storage_payments](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/resources/storage_container)           | resource    |
| [azurerm_storage_management_policy.services_storage](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/resources/storage_management_policy)    | resource    |
| [helm_release.reloader](https://registry.terraform.io/providers/hashicorp/helm/2.5.1/docs/resources/release)                                                       | resource    |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/namespace)                                     | resource    |
| [kubernetes_namespace.namespace_system](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/namespace)                              | resource    |
| [kubernetes_role_binding.deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/role_binding)                        | resource    |
| [kubernetes_service_account.azure_devops](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/service_account)                      | resource    |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group)                                            | data source |
| [azuread_group.adgroup_contributors](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group)                                     | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group)                                       | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group)                                        | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group)                                         | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/data-sources/client_config)                                  | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/data-sources/key_vault)                                               | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/data-sources/kubernetes_cluster)                            | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/data-sources/log_analytics_workspace)        | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/data-sources/monitor_action_group)                      | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/data-sources/monitor_action_group)                      | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/data-sources/private_dns_zone)                           | data source |
| [azurerm_private_dns_zone.privatelink_blob_core_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/data-sources/private_dns_zone)  | data source |
| [azurerm_private_dns_zone.privatelink_documents_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/data-sources/private_dns_zone)    | data source |
| [azurerm_private_dns_zone.privatelink_file_core_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/data-sources/private_dns_zone)  | data source |
| [azurerm_private_dns_zone.privatelink_queue_core_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_table_core_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/data-sources/resource_group)                             | data source |
| [azurerm_subnet.private_endpoints_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/data-sources/subnet)                               | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/data-sources/subscription)                                    | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/data-sources/virtual_network)                                 | data source |
| [azurerm_virtual_network.vnet_common](https://registry.terraform.io/providers/hashicorp/azurerm/2.98.0/docs/data-sources/virtual_network)                          | data source |
| [kubernetes_secret.azure_devops_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/data-sources/secret)                              | data source |
| [terraform_remote_state.core](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state)                                   | data source |

## Inputs

| Name                                                                                                                                                               | Description                                                                        | Type                                                                                                                                          | Default                                        | Required |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- | :------: |
| <a name="input_domain"></a> [domain](#input_domain)                                                                                                                | n/a                                                                                | `string`                                                                                                                                      | n/a                                            |   yes    |
| <a name="input_env"></a> [env](#input_env)                                                                                                                         | n/a                                                                                | `string`                                                                                                                                      | n/a                                            |   yes    |
| <a name="input_env_short"></a> [env_short](#input_env_short)                                                                                                       | n/a                                                                                | `string`                                                                                                                                      | n/a                                            |   yes    |
| <a name="input_ingress_load_balancer_ip"></a> [ingress_load_balancer_ip](#input_ingress_load_balancer_ip)                                                          | n/a                                                                                | `string`                                                                                                                                      | n/a                                            |   yes    |
| <a name="input_instance"></a> [instance](#input_instance)                                                                                                          | One of beta, prod01, prod02                                                        | `string`                                                                                                                                      | n/a                                            |   yes    |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s_kube_config_path_prefix](#input_k8s_kube_config_path_prefix)                                                 | n/a                                                                                | `string`                                                                                                                                      | `"~/.kube"`                                    |    no    |
| <a name="input_location"></a> [location](#input_location)                                                                                                          | One of westeurope, northeurope                                                     | `string`                                                                                                                                      | n/a                                            |   yes    |
| <a name="input_location_short"></a> [location_short](#input_location_short)                                                                                        | One of wue, neu                                                                    | `string`                                                                                                                                      | n/a                                            |   yes    |
| <a name="input_lock_enable"></a> [lock_enable](#input_lock_enable)                                                                                                 | Apply locks to block accedentaly deletions.                                        | `bool`                                                                                                                                        | `false`                                        |    no    |
| <a name="input_log_analytics_workspace_name"></a> [log_analytics_workspace_name](#input_log_analytics_workspace_name)                                              | Specifies the name of the Log Analytics Workspace.                                 | `string`                                                                                                                                      | n/a                                            |   yes    |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log_analytics_workspace_resource_group_name](#input_log_analytics_workspace_resource_group_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string`                                                                                                                                      | n/a                                            |   yes    |
| <a name="input_monitor_resource_group_name"></a> [monitor_resource_group_name](#input_monitor_resource_group_name)                                                 | Monitor resource group name                                                        | `string`                                                                                                                                      | n/a                                            |   yes    |
| <a name="input_prefix"></a> [prefix](#input_prefix)                                                                                                                | n/a                                                                                | `string`                                                                                                                                      | n/a                                            |   yes    |
| <a name="input_reloader_helm_version"></a> [reloader_helm_version](#input_reloader_helm_version)                                                                   | n/a                                                                                | `string`                                                                                                                                      | `"v0.0.110"`                                   |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                                                                                      | n/a                                                                                | `map(any)`                                                                                                                                    | <pre>{<br> "CreatedBy": "Terraform"<br>}</pre> |    no    |
| <a name="input_terraform_remote_state_core"></a> [terraform_remote_state_core](#input_terraform_remote_state_core)                                                 | n/a                                                                                | <pre>object({<br> resource_group_name = string,<br> storage_account_name = string,<br> container_name = string,<br> key = string<br> })</pre> | n/a                                            |   yes    |

## Outputs

No outputs.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
