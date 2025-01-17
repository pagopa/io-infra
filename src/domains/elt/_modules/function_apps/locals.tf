locals {

  resource_group_name_common   = "${var.project}-rg-common"
  resource_group_name_internal = "${var.project}-rg-internal"

  app_insights_ips_west_europe = [
    "51.144.56.96/28",
    "51.144.56.112/28",
    "51.144.56.128/28",
    "51.144.56.144/28",
    "51.144.56.160/28",
    "51.144.56.176/28",
  ]

  event_hub_connection      = "${format("%s-evh-ns", var.project)}.servicebus.windows.net:9093"
  auth_event_hub_connection = "${format("%s-itn-auth-elt-evhns-01", var.project)}.servicebus.windows.net:9093"

  pn_service_id = "01G40DWQGKY5GRWSNM4303VNRP"

  service_preferences_failure_queue_name = "pdnd-io-cosmosdb-service-preferences-failure"
  profiles_failure_queue_name            = "pdnd-io-cosmosdb-profiles-failure"
  profile_deletion_failure_queue_name    = "pdnd-io-cosmosdb-profile-deletion-failure"
}
