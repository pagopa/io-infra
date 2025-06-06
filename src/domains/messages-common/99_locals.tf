locals {
  project     = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product     = "${var.prefix}-${var.env_short}"
  project_itn = "${var.prefix}-${var.env_short}-itn"

  vnet_common_name                = "${local.product}-vnet-common"
  vnet_common_resource_group_name = "${local.product}-rg-common"

  vnet_common_name_itn                = "${local.project_itn}-common-vnet-01"
  vnet_common_resource_group_name_itn = "${local.project_itn}-common-rg-01"

  apim_itn_name                = "${local.product}-itn-apim-01"
  apim_itn_resource_group_name = "${local.product}-itn-common-rg-01"
}
