data "azurerm_key_vault" "kv" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}

#######
# KEYS
#######
resource "tls_private_key" "ioweb_profile_jwe_key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "tls_private_key" "ioweb_profile_jwt_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
#######

resource "azurerm_key_vault_secret" "magic_link_jwe_pub_key" {
  name         = "ioweb-profile-magic-link-jwe-pub-key"
  value        = tls_private_key.ioweb_profile_jwe_key.public_key_pem
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "magic_link_jwe_private_key" {
  name         = "ioweb-profile-magic-link-jwe-private-key"
  value        = tls_private_key.ioweb_profile_jwe_key.private_key_pem
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "exchange_jwt_pub_key" {
  name         = "ioweb-profile-exchange-jwt-pub-key"
  value        = tls_private_key.ioweb_profile_jwt_key.public_key_pem
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "exchange_jwt_private_key" {
  name         = "ioweb-profile-exchange-jwt-private-key"
  value        = tls_private_key.ioweb_profile_jwt_key.private_key_pem
  key_vault_id = data.azurerm_key_vault.kv.id
}
