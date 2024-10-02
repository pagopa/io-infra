<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | <= 1.9.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.116.0 |

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
| <a name="module_test_users"></a> [test\_users](#module\_test\_users) | ../../_modules/test_users | n/a |

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
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_key_vault.key_vault_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.api_gad_client_certificate_verified_header_secret_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.io_fn3_eucovidcert_key_secret_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.io_fn3_services_key_secret_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_resource_group.rg_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
