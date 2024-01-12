<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.84.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_container_app_environment_runner"></a> [container\_app\_environment\_runner](#module\_container\_app\_environment\_runner) | github.com/pagopa/terraform-azurerm-v3.git//container_app_environment_v2 | EC-79-refactoring-modulo-tf-container-app-environment |
| <a name="module_container_app_jobs"></a> [container\_app\_jobs](#module\_container\_app\_jobs) | github.com/pagopa/terraform-azurerm-v3.git//container_app_job_gh_runner | EC-81-refactoring-modulo-tf-container-app-job |
| <a name="module_subnet_runner"></a> [subnet\_runner](#module\_subnet\_runner) | github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.39.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.github_runner](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_key_vault.key_vault_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_log_analytics_workspace.law_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_resource_group.rg_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_virtual_network.vnet_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_key_vault_common"></a> [key\_vault\_common](#input\_key\_vault\_common) | n/a | <pre>object({<br>    name            = string<br>    pat_secret_name = string<br>  })</pre> | n/a | yes |
| <a name="input_law_common_name"></a> [law\_common\_name](#input\_law\_common\_name) | n/a | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"westeurope"` | no |
| <a name="input_networking"></a> [networking](#input\_networking) | n/a | <pre>object({<br>    vnet_common_name  = string<br>    subnet_cidr_block = string<br>  })</pre> | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"io"` | no |
| <a name="input_resource_group_common_name"></a> [resource\_group\_common\_name](#input\_resource\_group\_common\_name) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | Subnet id |
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | Subnet name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
