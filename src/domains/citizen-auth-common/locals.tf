locals {
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product = "${var.prefix}-${var.env_short}" # This value is used in src/core/99_variables.tf#citizen_auth_product

  vnet_common_name                = "${local.product}-vnet-common"
  vnet_common_resource_group_name = "${local.product}-rg-common"

  lollipop_jwt_host = "api.io.pagopa.it"

  fast_login_backend_url = "https://%s/api/v1"

  # Fast Login references refers to io-auth-n-identity-domain/infra/resources/prod/function_lv.tf
  fn_fast_login_name                = "${local.common_project_itn}-auth-lv-func-02"
  fn_fast_login_resource_group_name = "${local.common_project_itn}-auth-lv-rg-01"
}

# Region ITN
locals {
  project_itn        = "${var.prefix}-${var.env_short}-${local.itn_location_short}-${var.domain}"
  itn_location_short = "itn"
  common_project_itn = "${local.product}-${local.itn_location_short}"

  apim_itn_name                = "${local.product}-${local.itn_location_short}-apim-01"
  apim_itn_resource_group_name = "${local.product}-${local.itn_location_short}-common-rg-01"
}
