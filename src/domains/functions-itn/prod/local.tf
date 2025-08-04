locals {
  prefix             = "io"
  env_short          = "p"
  project            = "${local.prefix}-${local.env_short}"
  itn_location       = "italynorth"
  itn_location_short = "itn"
  project_itn        = "${local.project}-${local.itn_location_short}"

  vnet_common_name   = format("%s-vnet-common", local.project)
  rg_common_name     = format("%s-rg-common", local.project)
  rg_internal_name   = format("%s-rg-internal", local.project)
  rg_assets_cdn_name = format("%s-assets-cdn-rg", local.project)

  tags = {
    BusinessUnit = "App IO"
    CreatedBy    = "Terraform"
    Environment  = "Prod"
    Source       = "https://github.com/pagopa/io-infra/blob/main/src/domains/functions"
    CostCenter   = "TS000 - Tecnologia e Servizi"
  }

  # Switch limit date for email opt out mode. This value should be used by functions that need to discriminate
  # how to check isInboxEnabled property on IO profiles, since we have to disable email notifications for default
  # for all profiles that have been updated before this date. This date should coincide with new IO App's release date
  # 1625781600 value refers to 2021-07-09T00:00:00 GMT+02:00
  opt_out_email_switch_date = 1625781600

  # Feature flag used to enable email opt-in with logic exposed by the previous variable usage
  ff_opt_in_email_enabled = "true"

  apim_hostname_api_internal = "api-internal.io.italia.it"

  # MESSAGES
  message_content_container_name = "message-content"

  service_api_url = "https://api-app.internal.io.pagopa.it/"

  cidr_subnet_services                = ["10.20.33.0/26", "10.20.33.64/26"]
  function_services_kind              = "Linux"
  function_services_sku_tier          = "PremiumV3"
  function_services_sku_size          = "P1v3"
  function_services_autoscale_minimum = 3
  function_services_autoscale_maximum = 30
  function_services_autoscale_default = 10

  vnet_common_name_itn           = "${local.project_itn}-common-vnet-01"
  common_resource_group_name_itn = "${local.project_itn}-common-rg-01"

  apim_itn_name = "${local.project_itn}-apim-01"
}

