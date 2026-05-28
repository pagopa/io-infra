# prod

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | < 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.72.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_custom_roles"></a> [custom\_roles](#module\_custom\_roles) | pagopa-dx/azure-core-infra/azurerm//modules/custom_roles | ~> 4.2 |
| <a name="module_dns"></a> [dns](#module\_dns) | ./_modules/dns | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_private_endpoint_connection.psn_appgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_endpoint_connection) | data source |
| [terraform_remote_state.core](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns"></a> [dns](#output\_dns) | n/a |
<!-- END_TF_DOCS -->
