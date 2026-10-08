locals {
  product        = "${var.prefix}-${var.env_short}"
  common_project = "${var.prefix}-${var.env_short}-${var.location_short}"

  vnet_common_name                = "${local.product}-vnet-common"
  vnet_common_resource_group_name = "${local.product}-rg-common"

  appgw_resource_group_name = "${local.common_project_itn}-common-rg-01"

  storage_account_notifications_queue_push_notifications = "push-notifications"
}

# Region ITN
locals {
  itn_location_short = "itn"
  common_project_itn = "${local.product}-${local.itn_location_short}"

  # auth n identity domain
  short_domain      = "auth"
  short_project_itn = "${local.product}-${local.itn_location_short}-${local.short_domain}"

  vnet_common_name_itn                = "${local.common_project_itn}-common-vnet-01"
  vnet_common_resource_group_name_itn = "${local.common_project_itn}-common-rg-01"

  auth_sessions_topic_name = "${var.prefix}-${local.short_domain}-sessions-topic"

  locked_profiles_table_name = "lockedprofile01"
}
