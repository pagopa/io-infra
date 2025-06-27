locals {

  resource_group_name_common = "${var.project}-rg-common"
  vnet_name_common           = "${var.project}-vnet-common"

  vnet_common_itn           = "${var.project}-itn-common-vnet-01"
  resource_group_common_itn = "${var.project}-itn-common-rg-01"
}
