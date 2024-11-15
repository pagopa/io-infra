locals {
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product = "${var.prefix}-${var.env_short}"

  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "EmailPagoPA"

  vnet_common_name                = "${local.product}-vnet-common"
  vnet_common_resource_group_name = "${local.product}-rg-common"

  acr_name                = replace("${local.product}commonacr", "-", "")
  acr_resource_group_name = "${local.product}-container-registry-rg"

  # WEU 
  apim_v2_name             = "${local.product}-apim-v2-api"
  apim_resource_group_name = "${local.product}-rg-internal"
  # ITN
  apim_itn_name                = "${local.product}-itn-apim-01"
  apim_itn_resource_group_name = "${local.product}-itn-common-rg-01"

  spid_login_base_path = "ioweb/auth/v1"
}

# Region ITN
locals {
  itn_location       = "italynorth"
  itn_location_short = "itn"
  project_itn        = "${local.product}-${local.itn_location_short}-${var.domain}"
  common_project_itn = "${local.product}-${local.itn_location_short}"
}
