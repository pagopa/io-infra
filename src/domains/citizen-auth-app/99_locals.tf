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

  appgw_resource_group_name = "${local.product}-rg-external"

  storage_account_notifications_queue_userslogin         = "userslogin"
  storage_account_notifications_queue_push_notifications = "push-notifications"

}

# Region ITN
locals {
  itn_location       = "italynorth"
  itn_location_short = "itn"
  project_itn        = "${var.prefix}-${var.env_short}-${local.itn_location_short}-${var.domain}"
  common_project_itn = "${local.product}-${local.itn_location_short}"

  # auth n identity domain
  short_domain      = "auth"
  short_project_itn = "${local.product}-${local.itn_location_short}-${local.short_domain}"

  vnet_common_name_itn                = "${local.common_project_itn}-common-vnet-01"
  vnet_common_resource_group_name_itn = "${local.common_project_itn}-common-rg-01"

  auth_sessions_topic_name = "${var.prefix}-${local.short_domain}-sessions-topic"
}
