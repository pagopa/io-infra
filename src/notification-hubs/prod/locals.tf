locals {
  prefix         = "io"
  env_short      = "p"
  legacy_project = "${local.prefix}-${local.env_short}"
  project        = "${local.legacy_project}-${local.legacy_location_short}"

  legacy_location_short = "weu"
  legacy_location       = "westeurope"

  apns_credential = {
    application_mode = "Production"
    bundle_id        = "it.pagopa.app.io"
    team_id          = "M2X5YQ4BJ7"
    key_id           = "PL6AXY2HSQ"
  }

  tags = {
    CostCenter     = "TS310 - PAGAMENTI & SERVIZI"
    CreatedBy      = "Terraform"
    Environment    = "Prod"
    Owner          = "IO"
    ManagementTeam = "IO Platform"
    Source         = "https://github.com/pagopa/io-infra/blob/main/src/notification-hubs/prod"
  }
}
