# ⚠️ Uncomment the configuration below after AGW creation ⚠️

# resource "azurerm_monitor_metric_alert" "this" {
#   for_each = local.monitor_metric_alert_criteria

#   name                = "${azurerm_application_gateway.this.name}-${upper(each.key)}"
#   description         = each.value.description
#   resource_group_name = var.resource_group_common
#   scopes              = [azurerm_application_gateway.this.id]
#   frequency           = each.value.frequency
#   window_size         = each.value.window_size
#   enabled             = true
#   severity            = each.value.severity
#   auto_mitigate       = each.value.auto_mitigate

#   dynamic "action" {
#     for_each = local.action
#     content {
#       # action_group_id - (required) is a type of string
#       action_group_id = action.value["action_group_id"]
#       # webhook_properties - (optional) is a type of map of string
#       webhook_properties = action.value["webhook_properties"]
#     }
#   }

#   dynamic "criteria" {
#     for_each = each.value.criteria
#     content {
#       aggregation      = criteria.value.aggregation
#       metric_namespace = local.metric_namespace
#       metric_name      = criteria.value.metric_name
#       operator         = criteria.value.operator
#       threshold        = criteria.value.threshold

#       dynamic "dimension" {
#         for_each = criteria.value.dimension
#         content {
#           name     = dimension.value.name
#           operator = dimension.value.operator
#           values   = dimension.value.values
#         }
#       }
#     }
#   }

#   dynamic "dynamic_criteria" {
#     for_each = each.value.dynamic_criteria
#     content {
#       aggregation              = dynamic_criteria.value.aggregation
#       metric_namespace         = local.metric_namespace
#       metric_name              = dynamic_criteria.value.metric_name
#       operator                 = dynamic_criteria.value.operator
#       alert_sensitivity        = dynamic_criteria.value.alert_sensitivity
#       evaluation_total_count   = dynamic_criteria.value.evaluation_total_count
#       evaluation_failure_count = dynamic_criteria.value.evaluation_failure_count

#       dynamic "dimension" {
#         for_each = dynamic_criteria.value.dimension
#         content {
#           name     = dimension.value.name
#           operator = dimension.value.operator
#           values   = dimension.value.values
#         }
#       }
#     }
#   }
#   tags = var.tags
# }

# #############################
# ##   Diagnostic Settings   ##
# #############################

# resource "azurerm_monitor_diagnostic_setting" "agw_sec_log_analytics" {
#   name                       = "AuditLogs_LogAnalytics"
#   target_resource_id         = azurerm_application_gateway.this.id
#   log_analytics_workspace_id = "/subscriptions/0da48c97-355f-4050-a520-f11a18b8be90/resourceGroups/sec-p-sentinel/providers/Microsoft.OperationalInsights/workspaces/sec-p-law"

#   enabled_log {
#     category = "ApplicationGatewayFirewallLog"
#   }

#   enabled_log {
#     category = "ApplicationGatewayAccessLog"
#   }

#   metric {
#     category = "AllMetrics"
#     enabled  = false
#   }
# }

# resource "azurerm_monitor_diagnostic_setting" "agw_sec_storage" {
#   name               = "AuditLogs_StorageAccount"
#   target_resource_id = azurerm_application_gateway.this.id
#   storage_account_id = "/subscriptions/0da48c97-355f-4050-a520-f11a18b8be90/resourceGroups/sec-p-sentinel/providers/Microsoft.Storage/storageAccounts/ppseclogs"

#   enabled_log {
#     category = "ApplicationGatewayFirewallLog"
#   }

#   enabled_log {
#     category = "ApplicationGatewayAccessLog"
#   }

#   metric {
#     category = "AllMetrics"
#     enabled  = false
#   }
# }