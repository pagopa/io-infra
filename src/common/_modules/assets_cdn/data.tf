data "azurerm_key_vault_secret" "assets_cdn_fn_key_cdn" {
  name         = "${var.assets_cdn_fn.name}-KEY-CDN"
  key_vault_id = var.key_vault_common.id
}
