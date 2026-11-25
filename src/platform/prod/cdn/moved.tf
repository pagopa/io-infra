moved {
  from = module.legacy_assets_cdn_storage_account.azurerm_storage_account.this
  to   = azurerm_storage_account.legacy_assets_cdn_storage_account
}
