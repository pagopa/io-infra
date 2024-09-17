removed {
  from = azurerm_cosmosdb_account.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_cosmosdb_sql_container.these

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_cosmosdb_sql_database.db

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_private_endpoint.sql

  lifecycle {
    destroy = false
  }
}
