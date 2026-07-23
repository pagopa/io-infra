# Use this file to import the wanted resources inside the state file, 
# remember to cleanup the import code blocks with a separate PR once the import has been completed successfully.
# Here is the documentation which explains how to use the import code block: https://developer.hashicorp.com/terraform/language/block/import

# SERVICE BUS

import {
  to = module.platform_service_bus_namespace_itn.module.platform_service_bus_namespace.azurerm_monitor_autoscale_setting.this[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/autoScaleSettings/io-p-itn-platform-sbns-as-01"
}

import {
  to = module.platform_service_bus_namespace_itn.module.platform_service_bus_namespace.azurerm_private_endpoint.service_bus_pep[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Network/privateEndpoints/io-p-itn-platform-sbns-pep-01"
}

import {
  to = module.platform_service_bus_namespace_itn.module.platform_service_bus_namespace.azurerm_servicebus_namespace.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.ServiceBus/namespaces/io-p-itn-platform-sbns-01"
}

# EVENT HUB

import {
  to = module.event_hubs_weu.azurerm_key_vault_secret.event_hub_keys["import-command.io-fn-elt"]
  id = "https://io-p-kv.vault.azure.net/secrets/evh-import-command-io-fn-elt-key/08b9efc3140c4bbba3002fb15c2946ac"
}

import {
  to = module.event_hubs_weu.azurerm_key_vault_secret.event_hub_keys["import-command.ops"]
  id = "https://io-p-kv.vault.azure.net/secrets/evh-import-command-ops-key/b60ef5738d4c426693e5d770eca733be"
}

import {
  to = module.event_hubs_weu.azurerm_key_vault_secret.event_hub_keys["io-cosmosdb-message-status-for-view.io-cdc"]
  id = "https://io-p-kv.vault.azure.net/secrets/evh-io-cosmosdb-message-status-for-view-io-cdc-key/44830537963d4b64ba98e2f3bfe842c0"
}

import {
  to = module.event_hubs_weu.azurerm_key_vault_secret.event_hub_keys["io-cosmosdb-message-status-for-view.io-messages"]
  id = "https://io-p-kv.vault.azure.net/secrets/evh-io-cosmosdb-message-status-for-view-io-messages-key/941b9f708f8040638c7960e1970d9dac"
}

import {
  to = module.event_hubs_weu.azurerm_key_vault_secret.event_hub_keys["io-cosmosdb-message-status.io-cdc"]
  id = "https://io-p-kv.vault.azure.net/secrets/evh-io-cosmosdb-message-status-io-cdc-key/7dad5971086f4d058470283a32682a3d"
}

import {
  to = module.event_hubs_weu.azurerm_key_vault_secret.event_hub_keys["io-cosmosdb-message-status.io-messages"]
  id = "https://io-p-kv.vault.azure.net/secrets/evh-io-cosmosdb-message-status-io-messages-key/b8622fb3177141a7974f1a421b58983c"
}

import {
  to = module.event_hubs_weu.azurerm_key_vault_secret.event_hub_keys["io-cosmosdb-profiles.io-fn-elt"]
  id = "https://io-p-kv.vault.azure.net/secrets/evh-io-cosmosdb-profiles-io-fn-elt-key/054648e5a2b54d57b87affd80ada2df5"
}

import {
  to = module.event_hubs_weu.azurerm_key_vault_secret.event_hub_keys["io-cosmosdb-profiles.pdnd"]
  id = "https://io-p-kv.vault.azure.net/secrets/evh-io-cosmosdb-profiles-pdnd-key/4b5a24bdbb964e85b3f1790e45699b41"
}

import {
  to = module.event_hubs_weu.azurerm_key_vault_secret.event_hub_keys["io-cosmosdb-services.io-fn-elt"]
  id = "https://io-p-kv.vault.azure.net/secrets/evh-io-cosmosdb-services-io-fn-elt-key/9fa19a20e49c449bbda4ecc2973c500b"
}

import {
  to = module.event_hubs_weu.azurerm_key_vault_secret.event_hub_keys["io-cosmosdb-services.pdnd"]
  id = "https://io-p-kv.vault.azure.net/secrets/evh-io-cosmosdb-services-pdnd-key/5a08bcae79d84402b53618c4dc1ce65f"
}

import {
  to = module.event_hubs_weu.azurerm_key_vault_secret.event_hub_keys["pdnd-io-cosmosdb-service-preferences.io-fn-elt"]
  id = "https://io-p-kv.vault.azure.net/secrets/evh-pdnd-io-cosmosdb-service-preferences-io-fn-elt-key/a92476402501461eb8b358c6d8eeff6c"
}

import {
  to = module.event_hubs_weu.azurerm_key_vault_secret.event_hub_keys["pdnd-io-cosmosdb-service-preferences.pdnd"]
  id = "https://io-p-kv.vault.azure.net/secrets/evh-pdnd-io-cosmosdb-service-preferences-pdnd-key/30610dd23b2248149f042755e154b444"
}

import {
  to = module.event_hubs_weu.azurerm_resource_group.event_rg
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg"
}

import {
  to = module.event_hubs_weu.module.event_hub.azurerm_eventhub.events["import-command"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.EventHub/namespaces/io-p-evh-ns/eventhubs/import-command"
}

import {
  to = module.event_hubs_weu.module.event_hub.azurerm_eventhub.events["io-cosmosdb-message-status"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.EventHub/namespaces/io-p-evh-ns/eventhubs/io-cosmosdb-message-status"
}

import {
  to = module.event_hubs_weu.module.event_hub.azurerm_eventhub.events["io-cosmosdb-message-status-for-view"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.EventHub/namespaces/io-p-evh-ns/eventhubs/io-cosmosdb-message-status-for-view"
}

import {
  to = module.event_hubs_weu.module.event_hub.azurerm_eventhub.events["io-cosmosdb-profiles"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.EventHub/namespaces/io-p-evh-ns/eventhubs/io-cosmosdb-profiles"
}

import {
  to = module.event_hubs_weu.module.event_hub.azurerm_eventhub.events["io-cosmosdb-services"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.EventHub/namespaces/io-p-evh-ns/eventhubs/io-cosmosdb-services"
}

import {
  to = module.event_hubs_weu.module.event_hub.azurerm_eventhub.events["pdnd-io-cosmosdb-service-preferences"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.EventHub/namespaces/io-p-evh-ns/eventhubs/pdnd-io-cosmosdb-service-preferences"
}

import {
  to = module.event_hubs_weu.module.event_hub.azurerm_eventhub_authorization_rule.events["import-command.io-fn-elt"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.EventHub/namespaces/io-p-evh-ns/eventhubs/import-command/authorizationRules/io-fn-elt"
}

import {
  to = module.event_hubs_weu.module.event_hub.azurerm_eventhub_authorization_rule.events["import-command.ops"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.EventHub/namespaces/io-p-evh-ns/eventhubs/import-command/authorizationRules/ops"
}

import {
  to = module.event_hubs_weu.module.event_hub.azurerm_eventhub_authorization_rule.events["io-cosmosdb-message-status-for-view.io-cdc"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.EventHub/namespaces/io-p-evh-ns/eventhubs/io-cosmosdb-message-status-for-view/authorizationRules/io-cdc"
}

import {
  to = module.event_hubs_weu.module.event_hub.azurerm_eventhub_authorization_rule.events["io-cosmosdb-message-status-for-view.io-messages"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.EventHub/namespaces/io-p-evh-ns/eventhubs/io-cosmosdb-message-status-for-view/authorizationRules/io-messages"
}

import {
  to = module.event_hubs_weu.module.event_hub.azurerm_eventhub_authorization_rule.events["io-cosmosdb-message-status.io-cdc"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.EventHub/namespaces/io-p-evh-ns/eventhubs/io-cosmosdb-message-status/authorizationRules/io-cdc"
}

import {
  to = module.event_hubs_weu.module.event_hub.azurerm_eventhub_authorization_rule.events["io-cosmosdb-message-status.io-messages"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.EventHub/namespaces/io-p-evh-ns/eventhubs/io-cosmosdb-message-status/authorizationRules/io-messages"
}

import {
  to = module.event_hubs_weu.module.event_hub.azurerm_eventhub_authorization_rule.events["io-cosmosdb-profiles.io-fn-elt"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.EventHub/namespaces/io-p-evh-ns/eventhubs/io-cosmosdb-profiles/authorizationRules/io-fn-elt"
}

import {
  to = module.event_hubs_weu.module.event_hub.azurerm_eventhub_authorization_rule.events["io-cosmosdb-profiles.pdnd"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.EventHub/namespaces/io-p-evh-ns/eventhubs/io-cosmosdb-profiles/authorizationRules/pdnd"
}

import {
  to = module.event_hubs_weu.module.event_hub.azurerm_eventhub_authorization_rule.events["io-cosmosdb-services.io-fn-elt"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.EventHub/namespaces/io-p-evh-ns/eventhubs/io-cosmosdb-services/authorizationRules/io-fn-elt"
}

import {
  to = module.event_hubs_weu.module.event_hub.azurerm_eventhub_authorization_rule.events["io-cosmosdb-services.pdnd"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.EventHub/namespaces/io-p-evh-ns/eventhubs/io-cosmosdb-services/authorizationRules/pdnd"
}

import {
  to = module.event_hubs_weu.module.event_hub.azurerm_eventhub_authorization_rule.events["pdnd-io-cosmosdb-service-preferences.io-fn-elt"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.EventHub/namespaces/io-p-evh-ns/eventhubs/pdnd-io-cosmosdb-service-preferences/authorizationRules/io-fn-elt"
}

import {
  to = module.event_hubs_weu.module.event_hub.azurerm_eventhub_authorization_rule.events["pdnd-io-cosmosdb-service-preferences.pdnd"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.EventHub/namespaces/io-p-evh-ns/eventhubs/pdnd-io-cosmosdb-service-preferences/authorizationRules/pdnd"
}

import {
  to = module.event_hubs_weu.module.event_hub.azurerm_eventhub_consumer_group.events["io-cosmosdb-message-status-for-view.io-messages"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.EventHub/namespaces/io-p-evh-ns/eventhubs/io-cosmosdb-message-status-for-view/consumerGroups/io-messages"
}

import {
  to = module.event_hubs_weu.module.event_hub.azurerm_eventhub_consumer_group.events["io-cosmosdb-message-status.io-messages"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.EventHub/namespaces/io-p-evh-ns/eventhubs/io-cosmosdb-message-status/consumerGroups/io-messages"
}

import {
  to = module.event_hubs_weu.module.event_hub.azurerm_eventhub_namespace.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.EventHub/namespaces/io-p-evh-ns"
}

import {
  to = module.event_hubs_weu.module.event_hub.azurerm_monitor_metric_alert.this["active_connections"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.Insights/metricAlerts/io-p-evh-ns-ACTIVE_CONNECTIONS"
}

import {
  to = module.event_hubs_weu.module.event_hub.azurerm_monitor_metric_alert.this["error_trx"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.Insights/metricAlerts/io-p-evh-ns-ERROR_TRX"
}

import {
  to = module.event_hubs_weu.module.event_hub.azurerm_monitor_metric_alert.this["no_trx"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-evt-rg/providers/Microsoft.Insights/metricAlerts/io-p-evh-ns-NO_TRX"
}

import {
  to = module.event_hubs_weu.module.eventhub_snet.azurerm_subnet.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/io-p-eventhub-snet"
}

# COSMOS

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_account.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["activations"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/activations"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["change-feed-leases"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/change-feed-leases"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["cqrs-leases"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/cqrs-leases"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["leaseMessageStatusForMessageRetention"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/leaseMessageStatusForMessageRetention"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["leases-services"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/leases-services"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["leases-services-2"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/leases-services-2"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["logins"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/logins"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["message-status"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/message-status"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["message-view"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/message-view"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["messages"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/messages"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["notification-status"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/notification-status"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["notifications"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/notifications"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["operations-leases-services"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/operations-leases-services"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["pdnd-leases"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/pdnd-leases"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["profile-emails-leases"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/profile-emails-leases"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["profile-emails-uniqueness-leases"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/profile-emails-uniqueness-leases"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["profile-emails-uniqueness-leases-itn"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/profile-emails-uniqueness-leases-itn"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["profile-emails-uniqueness-leases-itn-002"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/profile-emails-uniqueness-leases-itn-002"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["profiles"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/profiles"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["sender-services"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/sender-services"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["services"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/services"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["services-cms--legacy-watcher-lease"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/services-cms--legacy-watcher-lease"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["services-preferences"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/services-preferences"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["services-subsmigrations-leases-002"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/services-subsmigrations-leases-002"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["services-subsmigrations-leases-003"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/services-subsmigrations-leases-003"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["subscription-cidrs"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/subscription-cidrs"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these["user-data-processing"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/user-data-processing"
}

import {
  to = module.cosmos_api_weu.azurerm_cosmosdb_sql_database.db
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db"
}

import {
  to = module.cosmos_api_weu.azurerm_monitor_metric_alert.throttling_alert
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.Insights/metricAlerts/[IO-COMMONS | io-p-cosmos-api] Throttling"
}

import {
  to = module.cosmos_api_weu.azurerm_private_endpoint.sql
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.Network/privateEndpoints/io-p-cosmos-api-sql-endpoint"
}

import {
  to = module.cosmos_api_weu.azurerm_private_endpoint.sql_itn
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.Network/privateEndpoints/io-p-itn-api-cosno-pep-01"
}

import {
  to = module.cosmos_api_weu.azurerm_role_assignment.cosno_api_auth_admins
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/providers/Microsoft.Authorization/roleAssignments/e09302e5-f9ff-774f-864e-bce1b6d02f5c"
}

import {
  to = module.cosmos_api_weu.azurerm_role_assignment.cosno_api_auth_devs
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/providers/Microsoft.Authorization/roleAssignments/e3100aed-6e01-24d3-cbf0-bd2f89132786"
}

import {
  to = module.cosmos_api_weu.azurerm_role_assignment.cosno_api_com_admins
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/providers/Microsoft.Authorization/roleAssignments/2e856da0-6516-a947-1fef-94c6fd8a4080"
}

import {
  to = module.cosmos_api_weu.azurerm_role_assignment.cosno_api_com_devs
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/providers/Microsoft.Authorization/roleAssignments/75bd88df-99e6-958f-25c2-37ad2e5a7160"
}

import {
  to = module.cosmos_api_weu.azurerm_role_assignment.cosno_api_identities["41a75ef2-d909-4adc-b746-36ff057560a1"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/providers/Microsoft.Authorization/roleAssignments/9b774b99-9267-5227-04a4-06002bd6ddf9"
}

import {
  to = module.cosmos_api_weu.azurerm_role_assignment.cosno_api_identities["5877b6c1-d7c3-43d1-b670-570e77a721af"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/providers/Microsoft.Authorization/roleAssignments/fc6c7cfe-d564-c6f7-6a37-e3d1e64b20ab"
}

import {
  to = module.cosmos_api_weu.azurerm_role_assignment.cosno_api_svc_admins
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/providers/Microsoft.Authorization/roleAssignments/953f3125-9243-043f-1e4d-e51c48d512c8"
}

import {
  to = module.cosmos_api_weu.azurerm_role_assignment.cosno_api_svc_devs
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/providers/Microsoft.Authorization/roleAssignments/5b5dc67f-689e-7903-b608-de0a7abc287e"
}

import {
  to = module.cosmos_api_weu.module.cosno_api_auth_admins.module.cosmos.azurerm_cosmosdb_sql_role_assignment.this["io-p-cosmos-api|db|*|reader"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlRoleAssignments/30462e54-4e51-1d6e-5949-386982e9940e"
}

import {
  to = module.cosmos_api_weu.module.cosno_api_auth_devs.module.cosmos.azurerm_cosmosdb_sql_role_assignment.this["io-p-cosmos-api|db|*|reader"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlRoleAssignments/ce57a21a-77ee-0429-9388-10f5b4173707"
}

import {
  to = module.cosmos_api_weu.module.cosno_api_com_admins.module.cosmos.azurerm_cosmosdb_sql_role_assignment.this["io-p-cosmos-api|db|*|reader"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlRoleAssignments/b56d6b83-5c5b-cf3f-1eb3-4c2511a2de66"
}

import {
  to = module.cosmos_api_weu.module.cosno_api_com_devs.module.cosmos.azurerm_cosmosdb_sql_role_assignment.this["io-p-cosmos-api|db|*|reader"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlRoleAssignments/aee54daf-fccb-d564-1758-9cf936ae8841"
}

import {
  to = module.cosmos_api_weu.module.cosno_api_svc_admins.module.cosmos.azurerm_cosmosdb_sql_role_assignment.this["io-p-cosmos-api|db|*|reader"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlRoleAssignments/c02ecd91-e9d9-9229-8289-ab00a71def66"
}

import {
  to = module.cosmos_api_weu.module.cosno_api_svc_devs.module.cosmos.azurerm_cosmosdb_sql_role_assignment.this["io-p-cosmos-api|db|*|reader"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlRoleAssignments/fc7e7cce-25cf-a9e9-ddf3-d49f28ca82cb"
}