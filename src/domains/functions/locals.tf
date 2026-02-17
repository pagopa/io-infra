locals {
  project            = "${var.prefix}-${var.env_short}"
  vnet_common_name   = format("%s-vnet-common", local.project)
  rg_common_name     = format("%s-rg-common", local.project)
  rg_internal_name   = format("%s-rg-internal", local.project)
  rg_assets_cdn_name = format("%s-assets-cdn-rg", local.project)

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
}

# Region ITN
locals {
  itn_location       = "italynorth"
  itn_location_short = "itn"
  common_project_itn = "${local.project}-${local.itn_location_short}"

  vnet_common_name_itn                = "${local.common_project_itn}-common-vnet-01"
  vnet_common_resource_group_name_itn = "${local.common_project_itn}-common-rg-01"

  apim_itn_name                = "${local.project}-${local.itn_location_short}-apim-01"
  apim_itn_resource_group_name = "${local.project}-${local.itn_location_short}-common-rg-01"
}
