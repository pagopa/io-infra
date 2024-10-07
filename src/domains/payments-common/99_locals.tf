locals {
  project     = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product     = "${var.prefix}-${var.env_short}"
  project_itn = "${var.prefix}-${var.env_short}-itn"

  app_insights_ips_west_europe = [
    "51.144.56.96/28",
    "51.144.56.112/28",
    "51.144.56.128/28",
    "51.144.56.144/28",
    "51.144.56.160/28",
    "51.144.56.176/28",
  ]

  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "EmailPagoPA"

  vnet_common_name                = "${local.product}-vnet-common"
  vnet_common_resource_group_name = "${local.product}-rg-common"

  vnet_common_name_itn                = "${local.project_itn}-common-vnet-01"
  vnet_common_resource_group_name_itn = "${local.project_itn}-common-rg-01"

  acr_name                = replace("${local.product}commonacr", "-", "")
  acr_resource_group_name = "${local.product}-container-registry-rg"

  apim_v2_name             = "${local.product}-apim-v2-api"
  apim_resource_group_name = "${local.product}-rg-internal"
}
