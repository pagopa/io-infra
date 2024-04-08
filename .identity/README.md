# IO Infra - Identity

<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.5.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 2.30.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.98.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | 5.45.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_identity_cd"></a> [identity\_cd](#module\_identity\_cd) | github.com/pagopa/terraform-azurerm-v3//github_federated_identity | v7.76.0 |
| <a name="module_identity_ci"></a> [identity\_ci](#module\_identity\_ci) | github.com/pagopa/terraform-azurerm-v3//github_federated_identity | v7.76.0 |

## Resources

| Name | Type |
|------|------|
| [azuread_directory_role.directory_readers](https://registry.terraform.io/providers/hashicorp/azuread/2.30.0/docs/resources/directory_role) | resource |
| [azurerm_resource_group.identity_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [github_actions_environment_secret.azure_cd_subscription_id](https://registry.terraform.io/providers/integrations/github/5.45.0/docs/resources/actions_environment_secret) | resource |
| [github_actions_environment_secret.azure_cd_tenant_id](https://registry.terraform.io/providers/integrations/github/5.45.0/docs/resources/actions_environment_secret) | resource |
| [github_actions_environment_secret.azure_ci_subscription_id](https://registry.terraform.io/providers/integrations/github/5.45.0/docs/resources/actions_environment_secret) | resource |
| [github_actions_environment_secret.azure_ci_tenant_id](https://registry.terraform.io/providers/integrations/github/5.45.0/docs/resources/actions_environment_secret) | resource |
| [github_actions_environment_secret.azure_client_id_cd](https://registry.terraform.io/providers/integrations/github/5.45.0/docs/resources/actions_environment_secret) | resource |
| [github_actions_environment_secret.azure_client_id_ci](https://registry.terraform.io/providers/integrations/github/5.45.0/docs/resources/actions_environment_secret) | resource |
| [github_repository_environment.github_repository_environment_cd](https://registry.terraform.io/providers/integrations/github/5.45.0/docs/resources/repository_environment) | resource |
| [github_repository_environment.github_repository_environment_ci](https://registry.terraform.io/providers/integrations/github/5.45.0/docs/resources/repository_environment) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [github_organization_teams.all](https://registry.terraform.io/providers/integrations/github/5.45.0/docs/data-sources/organization_teams) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cd_github_federations"></a> [cd\_github\_federations](#input\_cd\_github\_federations) | GitHub Organization, repository name and scope permissions | <pre>list(object({<br>    repository        = string<br>    credentials_scope = optional(string, "environment")<br>    subject           = string<br>  }))</pre> | n/a | yes |
| <a name="input_ci_github_federations"></a> [ci\_github\_federations](#input\_ci\_github\_federations) | GitHub Organization, repository name and scope permissions | <pre>list(object({<br>    repository        = string<br>    credentials_scope = optional(string, "environment")<br>    subject           = string<br>  }))</pre> | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | Managed identities scope names | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_environment_cd_roles"></a> [environment\_cd\_roles](#input\_environment\_cd\_roles) | GitHub Continous Delivery roles | <pre>object({<br>    subscription    = list(string)<br>    resource_groups = map(list(string))<br>  })</pre> | n/a | yes |
| <a name="input_environment_ci_roles"></a> [environment\_ci\_roles](#input\_environment\_ci\_roles) | GitHub Continous Integration roles | <pre>object({<br>    subscription    = list(string)<br>    resource_groups = map(list(string))<br>  })</pre> | n/a | yes |
| <a name="input_github_repository_environment_cd"></a> [github\_repository\_environment\_cd](#input\_github\_repository\_environment\_cd) | GitHub Continous Integration roles | <pre>object({<br>    protected_branches     = bool<br>    custom_branch_policies = bool<br>    reviewers_teams        = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_github_repository_environment_ci"></a> [github\_repository\_environment\_ci](#input\_github\_repository\_environment\_ci) | GitHub Continous Integration roles | <pre>object({<br>    protected_branches     = bool<br>    custom_branch_policies = bool<br>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CostCenter": "TS310 - PAGAMENTI & SERVIZI",<br>  "CreatedBy": "Terraform",<br>  "Environment": "Prod",<br>  "Owner": "IO",<br>  "Source": "https://github.com/pagopa/io-infra"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_managed_identity_github_cd"></a> [managed\_identity\_github\_cd](#output\_managed\_identity\_github\_cd) | n/a |
| <a name="output_managed_identity_github_ci"></a> [managed\_identity\_github\_ci](#output\_managed\_identity\_github\_ci) | n/a |
| <a name="output_subscription_id"></a> [subscription\_id](#output\_subscription\_id) | n/a |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
