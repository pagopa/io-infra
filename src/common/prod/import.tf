import {
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/components/io-p-ai-common"
  to = module.monitoring_weu.azurerm_application_insights.appi
}

import {
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/CIE-test-io-p-ai-common"
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["CIE"]
}

import {
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/Spid-registry-test-io-p-ai-common"
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["Spid-registry"]
}

import {
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/SpidL2-arubaid-test-io-p-ai-common"
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["SpidL2-arubaid"]
}

import {
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/SpidL2-infocamere-test-io-p-ai-common"
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["SpidL2-infocamere"]
}

import {
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["SpidL2-infocertid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/SpidL2-infocertid-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["SpidL2-lepidaid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/SpidL2-lepidaid-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["SpidL2-namirialid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/SpidL2-namirialid-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["SpidL2-posteid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/SpidL2-posteid-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["SpidL2-sielteid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/SpidL2-sielteid-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["SpidL2-spiditalia"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/SpidL2-spiditalia-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["api-app.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/api-app.io.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["api-mtls.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/api-mtls.io.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["api-web.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/api-web.io.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["api.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/api.io.italia.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["api.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/api.io.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["api.io.selfcare.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/api.io.selfcare.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["app-backend.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/app-backend.io.italia.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["assets.cdn.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/assets.cdn.io.italia.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["assets.cdn.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/assets.cdn.io.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["continua.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/continua.io.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["developerportal-backend.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/developerportal-backend.io.italia.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["firmaconio.selfcare.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/firmaconio.selfcare.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["github-raw-status-backend"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/github-raw-status-backend-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/io.italia.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests["io.selfcare.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/io.selfcare.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_log_analytics_workspace.log
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.OperationalInsights/workspaces/io-p-law-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_action_group.email
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/actionGroups/EmailPagoPA"
}

import {
  to = module.monitoring_weu.azurerm_monitor_action_group.error
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/actionGroups/ioperror"
}

import {
  to = module.monitoring_weu.azurerm_monitor_action_group.quarantine_error
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/actionGroups/iopquarantineerror"
}

import {
  to = module.monitoring_weu.azurerm_monitor_action_group.slack
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/actionGroups/SlackPagoPA"
}

import {
  to = module.monitoring_weu.azurerm_monitor_action_group.trial_system_error
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/actionGroups/ioptrialsystemerror"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["CIE"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/CIE-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["Spid-registry"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/Spid-registry-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["SpidL2-arubaid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/SpidL2-arubaid-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["SpidL2-infocamere"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/SpidL2-infocamere-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["SpidL2-infocertid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/SpidL2-infocertid-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["SpidL2-lepidaid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/SpidL2-lepidaid-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["SpidL2-namirialid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/SpidL2-namirialid-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["SpidL2-posteid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/SpidL2-posteid-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["SpidL2-sielteid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/SpidL2-sielteid-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["SpidL2-spiditalia"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/SpidL2-spiditalia-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["api-app.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/api-app.io.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["api-mtls.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/api-mtls.io.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["api-web.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/api-web.io.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["api.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/api.io.italia.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["api.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/api.io.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["api.io.selfcare.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/api.io.selfcare.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["app-backend.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/app-backend.io.italia.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["assets.cdn.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/assets.cdn.io.italia.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["assets.cdn.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/assets.cdn.io.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["continua.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/continua.io.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["developerportal-backend.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/developerportal-backend.io.italia.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["firmaconio.selfcare.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/firmaconio.selfcare.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["github-raw-status-backend"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/github-raw-status-backend-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/io.italia.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts["io.selfcare.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/io.selfcare.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_weu.azurerm_monitor_scheduled_query_rules_alert_v2.mailup
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/scheduledQueryRules/[SEND.MAILUP.COM] Many Failures"
}
