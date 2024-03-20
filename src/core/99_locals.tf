locals {
  project = "${var.prefix}-${var.env_short}"

  app_insights_ips_west_europe = [
    "51.144.56.96/28",
    "51.144.56.112/28",
    "51.144.56.128/28",
    "51.144.56.144/28",
    "51.144.56.160/28",
    "51.144.56.176/28",
  ]

  aks_ips = [
    // aks beta
    "51.124.16.195/32",
    // aks prod01
    "51.105.109.140/32"
  ]

  # windows standatd. It can be different in linux service plan.
  cet_time_zone_win = "Central Europe Standard Time"

  service_api_url = "https://api-app.internal.io.pagopa.it/"

  # Switch limit date for email opt out mode. This value should be used by functions that need to discriminate
  # how to check isInboxEnabled property on IO profiles, since we have to disable email notifications for default
  # for all profiles that have been updated before this date. This date should coincide with new IO App's release date
  # 1625781600 value refers to 2021-07-09T00:00:00 GMT+02:00
  opt_out_email_switch_date = 1625781600

  # Feature flag used to enable email opt-in with logic exposed by the previous variable usage
  ff_opt_in_email_enabled = "true"

  # Azure production subscription name
  subscription = "PROD-IO"

  # APIM
  apim_hostname_api_app_internal = format("api-app.internal.%s.%s", var.dns_zone_io, var.external_domain)
  apim_hostname_api_internal     = "api-internal.io.italia.it" # !warning, change only when you are sure that all endpoint call with the new endpoint: "api.internal.io.pagopa.it" todo change in format("api.internal.%s.%s", var.dns_zone_io, var.external_domain)


  io-p-messages-weu-prod01-evh-ns = {
    hostname = "io-p-messages-weu-prod01-evh-ns.servicebus.windows.net"
    port     = "9093"
  }

  io-p-evh-ns = {
    hostname = "io-p-evh-ns.servicebus.windows.net"
    port     = "9093"
  }

  # MESSAGES
  message_content_container_name = "message-content"

  selfcare_io = {
    backend_hostname  = "api.${var.dns_zone_io_selfcare}.${var.external_domain}"
    frontend_hostname = "${var.dns_zone_io_selfcare}.${var.external_domain}"
  }

  selfcare = {
    hostname = "${var.selfcare_external_hostname}"
  }
}
