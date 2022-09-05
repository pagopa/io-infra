<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.16.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 2.87.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.16.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.87.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apim_io_sign_issuer_api_v1"></a> [apim\_io\_sign\_issuer\_api\_v1](#module\_apim\_io\_sign\_issuer\_api\_v1) | git::https://github.com/pagopa/azurerm.git//api_management_api | v1.0.16 |
| <a name="module_apim_io_sign_product"></a> [apim\_io\_sign\_product](#module\_apim\_io\_sign\_product) | git::https://github.com/pagopa/azurerm.git//api_management_product | v1.0.16 |
| <a name="module_cosmosdb_account"></a> [cosmosdb\_account](#module\_cosmosdb\_account) | git::https://github.com/pagopa/azurerm.git//cosmosdb_account | v2.13.1 |
| <a name="module_cosmosdb_sql_container_products"></a> [cosmosdb\_sql\_container\_products](#module\_cosmosdb\_sql\_container\_products) | git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_container | v2.13.1 |
| <a name="module_cosmosdb_sql_container_signature-requests"></a> [cosmosdb\_sql\_container\_signature-requests](#module\_cosmosdb\_sql\_container\_signature-requests) | git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_container | v2.13.1 |
| <a name="module_cosmosdb_sql_database_db"></a> [cosmosdb\_sql\_database\_db](#module\_cosmosdb\_sql\_database\_db) | git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_database | v2.13.1 |
| <a name="module_io_sign_func"></a> [io\_sign\_func](#module\_io\_sign\_func) | git::https://github.com/pagopa/azurerm.git//function_app | v2.18.2 |
| <a name="module_io_sign_snet"></a> [io\_sign\_snet](#module\_io\_sign\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v2.13.1 |
| <a name="module_io_sign_storage"></a> [io\_sign\_storage](#module\_io\_sign\_storage) | git::https://github.com/pagopa/azurerm.git//storage_account | v2.13.1 |
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | git::https://github.com/pagopa/azurerm.git//key_vault | v2.13.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_named_value.io_fn_sign_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.io_fn_sign_url](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/resources/api_management_named_value) | resource |
| [azurerm_key_vault_access_policy.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_contributors](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_sign](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_platform_iac_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_resource_group.backend_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.data_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/resources/resource_group) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.16.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_contributors](https://registry.terraform.io/providers/hashicorp/azuread/2.16.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.16.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.16.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.16.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_sign](https://registry.terraform.io/providers/hashicorp/azuread/2.16.0/docs/data-sources/group) | data source |
| [azuread_service_principal.platform_iac_sp](https://registry.terraform.io/providers/hashicorp/azuread/2.16.0/docs/data-sources/service_principal) | data source |
| [azurerm_api_management.apim_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/data-sources/api_management) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/data-sources/client_config) | data source |
| [azurerm_key_vault_secret.cosmosdb_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.io_fn_sign_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_private_dns_zone.privatelink_documents_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_subnet.apim](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/data-sources/subnet) | data source |
| [azurerm_subnet.private_endpoints_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet_common](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/data-sources/virtual_network) | data source |
| [terraform_remote_state.core](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_io_sign_database"></a> [io\_sign\_database](#input\_io\_sign\_database) | n/a | <pre>object({<br>    throughput = number<br>    signature_requests = object({<br>      throughput = number<br>    })<br>  })</pre> | <pre>{<br>  "signature_requests": {<br>    "throughput": 400<br>  },<br>  "throughput": 800<br>}</pre> | no |
| <a name="input_io_sign_func"></a> [io\_sign\_func](#input\_io\_sign\_func) | n/a | <pre>object({<br>    sku_tier = string<br>    sku_size = string<br>  })</pre> | <pre>{<br>  "sku_size": "B1",<br>  "sku_tier": "Basic"<br>}</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_lock_enable"></a> [lock\_enable](#input\_lock\_enable) | Apply locks to block accedentaly deletions. | `bool` | `false` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_storage"></a> [storage](#input\_storage) | n/a | <pre>object({<br>    enable_versioning            = bool<br>    delete_retention_policy_days = number<br>    replication_type             = string<br>  })</pre> | <pre>{<br>  "delete_retention_policy_days": 15,<br>  "enable_versioning": false,<br>  "replication_type": "ZRS"<br>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |
| <a name="input_terraform_remote_state_core"></a> [terraform\_remote\_state\_core](#input\_terraform\_remote\_state\_core) | n/a | <pre>object({<br>    resource_group_name  = string,<br>    storage_account_name = string,<br>    container_name       = string,<br>    key                  = string<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
