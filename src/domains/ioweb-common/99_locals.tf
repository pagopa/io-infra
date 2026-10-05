locals {
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product = "${var.prefix}-${var.env_short}"

  vnet_common_name                = "${local.product}-vnet-common"
  vnet_common_resource_group_name = "${local.product}-rg-common"

  # ITN
  apim_itn_name                = "${local.product}-itn-apim-01"
  apim_itn_resource_group_name = "${local.product}-itn-common-rg-01"

  spid_login_base_path = "ioweb/auth/v1"
}

# Region ITN
locals {
  itn_location       = "italynorth"
  itn_location_short = "itn"
  project_itn        = "${var.prefix}-${var.env_short}-${local.itn_location_short}-${var.domain}"
  common_project_itn = "${local.product}-${local.itn_location_short}"

  # auth n identity domain
  short_domain      = "auth"

  vnet_common_name_itn                = "${local.common_project_itn}-common-vnet-01"
  vnet_common_resource_group_name_itn = "${local.common_project_itn}-common-rg-01"
}
