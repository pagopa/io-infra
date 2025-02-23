locals {
  project        = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product        = "${var.prefix}-${var.env_short}" # This value is used in src/core/99_variables.tf#citizen_auth_product
  common_project = "${var.prefix}-${var.env_short}-${var.location_short}"

  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "EmailPagoPA"

  vnet_common_name                = "${local.product}-vnet-common"
  vnet_common_resource_group_name = "${local.product}-rg-common"

  acr_name                = replace("${local.product}commonacr", "-", "")
  acr_resource_group_name = "${local.product}-container-registry-rg"

  apim_v2_name             = "${local.product}-apim-v2-api"
  apim_resource_group_name = "${local.product}-rg-internal"

  lollipop_jwt_host = "api.io.pagopa.it"

  fast_login_backend_url = "https://%s/api/v1"

  # Fast Login references refers to io-auth-n-identity-domain/infra/resources/prod/function_lv.tf
  fn_fast_login_name                = "${local.common_project_itn}-auth-lv-func-02"
  fn_fast_login_resource_group_name = "${local.common_project_itn}-auth-lv-rg-01"
}

# Region ITN
locals {
  project_itn        = "${var.prefix}-${var.env_short}-${local.itn_location_short}-${var.domain}"
  itn_location       = "italynorth"
  itn_location_short = "itn"
  common_project_itn = "${local.product}-${local.itn_location_short}"

  vnet_common_name_itn                = "${local.common_project_itn}-common-vnet-01"
  vnet_common_resource_group_name_itn = "${local.common_project_itn}-common-rg-01"

  apim_itn_name                = "${local.product}-${local.itn_location_short}-apim-01"
  apim_itn_resource_group_name = "${local.product}-${local.itn_location_short}-common-rg-01"
}
