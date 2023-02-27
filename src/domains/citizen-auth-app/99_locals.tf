locals {
  project        = "${var.prefix}-${var.env_short}-${var.domain}-${var.location_short}-${var.instance}"
  product        = "${var.prefix}-${var.env_short}"
  common_project = "${var.prefix}-${var.env_short}-${var.location_short}"

  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "EmailPagoPA"

  vnet_name                = "${local.product}-${var.location_short}-${var.instance}-vnet"
  vnet_resource_group_name = "${local.product}-${var.location_short}-${var.instance}-vnet-rg"

  vnet_common_name                = "${local.product}-vnet-common"
  vnet_common_resource_group_name = "${local.product}-rg-common"

  ingress_hostname                      = "${var.location_short}${var.instance}.${var.domain}"
  internal_dns_zone_name                = "internal.${var.prefix}.pagopa.it"
  internal_dns_zone_resource_group_name = "${local.product}-rg-internal"

  acr_name                = replace("${local.product}commonacr", "-", "")
  acr_resource_group_name = "${local.product}-container-registry-rg"

  aks_name                = "${local.product}-${var.location_short}-${var.instance}-aks"
  aks_resource_group_name = "${local.product}-${var.location_short}-${var.instance}-aks-rg"

  lollipop_jwt_host = "api.io.pagopa.it"
}
