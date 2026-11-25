moved {
  from = module.legacy_assets_cdn_storage_account.azurerm_storage_account.this
  to   = azurerm_storage_account.legacy_assets_cdn_storage_account
}

moved {
  from = module.legacy_assets_cdn_storage_account.azurerm_monitor_metric_alert.storage_account_low_availability[0]
  to   = azurerm_monitor_metric_alert.legacy_assets_cdn_storage_account_low_availability
}
