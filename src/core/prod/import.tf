import {
  to = azurerm_resource_group.internal_weu
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal"
}

import {
  to = azurerm_resource_group.external_weu
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external"
}

import {
  to = azurerm_resource_group.common_weu
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common"
}


import {
  to = azurerm_resource_group.sec_weu
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-sec-rg"
}

removed {
  from = module.key_vault_weu.azurerm_resource_group.sec
  lifecycle {
    destroy = false
  }
}
