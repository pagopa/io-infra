resource "azurerm_role_assignment" "io_sign_infra_cd_dns_zone_contributor_io_italia_it" {
  scope                = module.dns.zones.public_dns_zones.io_italia_it.id
  role_definition_name = "DNS Zone Contributor"
  principal_id         = "390af861-e0ef-40c1-84e6-4afc88bc15fd" # io-sign infra CD managed identity
  description          = "Allow io-sign infra CD identity to manage DNS records in io.italia.it"
}
