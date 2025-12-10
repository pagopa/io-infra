resource "azurerm_cdn_frontdoor_endpoint" "cdn_endpoint" {
  name                     = try(local.nonstandard[var.location_short].cdne, "${var.project}-assets-cdne-01")
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.cdn_profile.id

  tags = var.tags
}

resource "azurerm_cdn_frontdoor_origin_group" "primary_origin_group" {
  name                     = "primary-origin-group"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.cdn_profile.id

  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 10 # set to default

  load_balancing {
    additional_latency_in_milliseconds = 0
    sample_size                        = 16
    successful_samples_required        = 3
  }

  session_affinity_enabled = false
}

resource "azurerm_cdn_frontdoor_origin" "primary_origin" {
  name                          = "primary-origin"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.primary_origin_group.id
  enabled                       = true

  certificate_name_check_enabled = false

  http_port          = 80
  https_port         = 443
  host_name          = module.cdn_storage.primary_web_host
  origin_host_header = module.cdn_storage.primary_web_host
  priority           = 1
  weight             = 1
}
