data "azurerm_eventhub_authorization_rule" "messages-weu-prod01-evh_messages-payments_io-payment-updater" {
  name                = "${var.prefix}-payment-updater"
  namespace_name      = "${local.product}-messages-weu-prod01-evh-ns"
  eventhub_name       = "messages-payments"
  resource_group_name = "${local.product}-messages-weu-prod01-evt-rg"
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "messages-payments_io-p-messages-weu-prod01-evh_jaas-connection-string" {
  name         = "messages-payments-io-p-messages-weu-prod01-evh-jaas-connection-string"
  value        = "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"$ConnectionString\" password=\"${data.azurerm_eventhub_authorization_rule.messages-weu-prod01-evh_messages-payments_io-payment-updater.primary_connection_string}\";"
  content_type = "full connection string for java"

  key_vault_id = module.key_vault.id
}
