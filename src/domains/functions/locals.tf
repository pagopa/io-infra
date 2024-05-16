locals {
  project = "${var.prefix}-${var.env_short}"
  vnet_common_name = format("%s-vnet-common", local.project)
  rg_common_name = format("%s-rg-common", local.project)
  rg_internal_name = format("%s-rg-internal", local.project)
}