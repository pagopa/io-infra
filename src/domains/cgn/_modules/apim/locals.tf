locals {
  resource_group_name_common = "${var.project}-rg-common"

  # WEU
  apim_v2_name             = "${var.project}-apim-v2-api"
  apim_resource_group_name = "${var.project}-rg-internal"
  # ITN
  apim_itn_name                = "${var.project}-itn-apim-01"
  apim_itn_resource_group_name = "${var.project}-itn-common-rg-01"
}
