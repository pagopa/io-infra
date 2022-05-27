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
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.87.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cosmosdb_account"></a> [cosmosdb\_account](#module\_cosmosdb\_account) | git::https://github.com/pagopa/azurerm.git//cosmosdb_account | v2.13.1 |
| <a name="module_cosmosdb_sql_container_signature-requests"></a> [cosmosdb\_sql\_container\_signature-requests](#module\_cosmosdb\_sql\_container\_signature-requests) | git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_container | v2.13.1 |
| <a name="module_cosmosdb_sql_database_db"></a> [cosmosdb\_sql\_database\_db](#module\_cosmosdb\_sql\_database\_db) | git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_database | v2.13.1 |
| <a name="module_io_sign_func"></a> [io\_sign\_func](#module\_io\_sign\_func) | git::https://github.com/pagopa/azurerm.git//function_app | v2.13.1 |
| <a name="module_io_sign_snet"></a> [io\_sign\_snet](#module\_io\_sign\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v2.13.1 |
| <a name="module_io_sign_storage"></a> [io\_sign\_storage](#module\_io\_sign\_storage) | git::https://github.com/pagopa/azurerm.git//storage_account | v2.13.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.backend_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.data_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/resources/resource_group) | resource |
| [azurerm_api_management.apim_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/data-sources/api_management) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/data-sources/client_config) | data source |
| [azurerm_private_dns_zone.privatelink_documents_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_subnet.private_endpoints_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet_common](https://registry.terraform.io/providers/hashicorp/azurerm/2.87.0/docs/data-sources/virtual_network) | data source |

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

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
