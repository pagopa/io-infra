locals {
  project     = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product     = "${var.prefix}-${var.env_short}"
  project_itn = "${var.prefix}-${var.env_short}-itn"

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

  prefix    = "io"
  env_short = "p"

  location           = "westeurope"
  secondary_location = "italynorth"
  app_name           = "ex"


  itn_environment = {
    prefix          = local.prefix
    env_short       = local.env_short
    location        = local.secondary_location
    app_name        = local.app_name
    domain          = "message-common"
    instance_number = "01"
  }

  tags = {
    CostCenter     = "TS310 - PAGAMENTI & SERVIZI"
    CreatedBy      = "Terraform"
    Environment    = "Prod"
    Owner          = "IO"
    ManagementTeam = "Comunicazione"
    Source         = "https://github.com/pagopa/io-infra/blob/4b82c3e0296174eb27ddbebdb15b4cad17e19430/src/domains/messages-common/04_storage.tf#L35"
  }
}



