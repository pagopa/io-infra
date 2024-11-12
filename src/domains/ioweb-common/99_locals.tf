locals {
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product = "${var.prefix}-${var.env_short}"

  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "EmailPagoPA"

  vnet_common_name                = "${local.product}-vnet-common"
  vnet_common_resource_group_name = "${local.product}-rg-common"

  acr_name                = replace("${local.product}commonacr", "-", "")
  acr_resource_group_name = "${local.product}-container-registry-rg"

  apim_v2_name             = "${local.product}-apim-v2-api"
  apim_resource_group_name = "${local.product}-rg-internal"

  spid_login_base_path = "ioweb/auth/v1"
}

###Italy North
locals {
  app_name = "iowebportal"
  itn_environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location
    app_name        = local.app_name
    domain          = var.domain
    instance_number = var.instance
  }
}