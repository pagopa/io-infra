# Use this file to import the wanted resources inside the state file, 
# remember to cleanup the import code blocks with a separate PR once the import has been completed successfully.
# Here is the documentation which explains how to use the import code block: https://developer.hashicorp.com/terraform/language/block/import

# MONITORING ITALYNORTH

import {
  to = module.monitoring_italynorth.azurerm_application_insights.appi
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/components/io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_application_insights_standard_web_test.web_tests["CIE L2"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/webTests/CIE L2-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_application_insights_standard_web_test.web_tests["CIE L3"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/webTests/CIE L3-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_application_insights_standard_web_test.web_tests["Spid-registry"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/webTests/Spid-registry-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_application_insights_standard_web_test.web_tests["SpidL2-arubaid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/webTests/SpidL2-arubaid-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_application_insights_standard_web_test.web_tests["SpidL2-infocamere"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/webTests/SpidL2-infocamere-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_application_insights_standard_web_test.web_tests["SpidL2-infocertid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/webTests/SpidL2-infocertid-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_application_insights_standard_web_test.web_tests["SpidL2-lepidaid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/webTests/SpidL2-lepidaid-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_application_insights_standard_web_test.web_tests["SpidL2-namirialid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/webTests/SpidL2-namirialid-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_application_insights_standard_web_test.web_tests["SpidL2-posteid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/webTests/SpidL2-posteid-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_application_insights_standard_web_test.web_tests["SpidL2-sielteid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/webTests/SpidL2-sielteid-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_application_insights_standard_web_test.web_tests["SpidL2-spiditalia"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/webTests/SpidL2-spiditalia-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_application_insights_standard_web_test.web_tests["SpidL2-timid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/webTests/SpidL2-timid-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_application_insights_standard_web_test.web_tests["api-app.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/webTests/api-app.io.pagopa.it-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_application_insights_standard_web_test.web_tests["api-mtls.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/webTests/api-mtls.io.pagopa.it-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_application_insights_standard_web_test.web_tests["api-web.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/webTests/api-web.io.pagopa.it-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_application_insights_standard_web_test.web_tests["api.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/webTests/api.io.italia.it-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_application_insights_standard_web_test.web_tests["api.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/webTests/api.io.pagopa.it-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_application_insights_standard_web_test.web_tests["app-backend.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/webTests/app-backend.io.italia.it-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_application_insights_standard_web_test.web_tests["assets.cdn.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/webTests/assets.cdn.io.pagopa.it-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_application_insights_standard_web_test.web_tests["continua.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/webTests/continua.io.pagopa.it-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_application_insights_standard_web_test.web_tests["developerportal-backend.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/webTests/developerportal-backend.io.italia.it-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_application_insights_standard_web_test.web_tests["firmaconio.selfcare.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/webTests/firmaconio.selfcare.pagopa.it-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_application_insights_standard_web_test.web_tests["github-raw-status-backend"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/webTests/github-raw-status-backend-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_application_insights_standard_web_test.web_tests["io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/webTests/io.italia.it-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_key_vault_secret.appinsights_connection_string
  id = "https://io-p-itn-platform-kv-01.vault.azure.net/secrets/appinsights-connection-string/093f83e453ec4de783a15a986627f2f8"
}

import {
  to = module.monitoring_italynorth.azurerm_key_vault_secret.appinsights_instrumentation_key
  id = "https://io-p-itn-platform-kv-01.vault.azure.net/secrets/appinsights-instrumentation-key/82bd98556d794b6aa020812420cddfde"
}

import {
  to = module.monitoring_italynorth.azurerm_log_analytics_workspace.log
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.OperationalInsights/workspaces/io-p-itn-common-log-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_action_group.email
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/actionGroups/EmailPagoPA"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_action_group.error
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/actionGroups/iopitnerror"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_action_group.quarantine_error
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/actionGroups/iopitnquarantineerror"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_action_group.slack
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/actionGroups/SlackPagoPA"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_metric_alert.metric_alerts["CIE L2"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/CIE L2-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_metric_alert.metric_alerts["CIE L3"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/CIE L3-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_metric_alert.metric_alerts["Spid-registry"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/Spid-registry-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_metric_alert.metric_alerts["SpidL2-arubaid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/SpidL2-arubaid-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_metric_alert.metric_alerts["SpidL2-infocamere"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/SpidL2-infocamere-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_metric_alert.metric_alerts["SpidL2-infocertid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/SpidL2-infocertid-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_metric_alert.metric_alerts["SpidL2-lepidaid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/SpidL2-lepidaid-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_metric_alert.metric_alerts["SpidL2-namirialid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/SpidL2-namirialid-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_metric_alert.metric_alerts["SpidL2-posteid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/SpidL2-posteid-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_metric_alert.metric_alerts["SpidL2-sielteid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/SpidL2-sielteid-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_metric_alert.metric_alerts["SpidL2-spiditalia"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/SpidL2-spiditalia-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_metric_alert.metric_alerts["SpidL2-timid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/SpidL2-timid-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_metric_alert.metric_alerts["api-app.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/api-app.io.pagopa.it-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_metric_alert.metric_alerts["api-mtls.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/api-mtls.io.pagopa.it-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_metric_alert.metric_alerts["api-web.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/api-web.io.pagopa.it-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_metric_alert.metric_alerts["api.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/api.io.italia.it-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_metric_alert.metric_alerts["api.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/api.io.pagopa.it-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_metric_alert.metric_alerts["app-backend.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/app-backend.io.italia.it-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_metric_alert.metric_alerts["assets.cdn.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/assets.cdn.io.pagopa.it-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_metric_alert.metric_alerts["continua.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/continua.io.pagopa.it-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_metric_alert.metric_alerts["developerportal-backend.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/developerportal-backend.io.italia.it-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_metric_alert.metric_alerts["firmaconio.selfcare.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/firmaconio.selfcare.pagopa.it-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_metric_alert.metric_alerts["github-raw-status-backend"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/github-raw-status-backend-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_metric_alert.metric_alerts["io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/io.italia.it-test-io-p-itn-common-appi-01"
}

import {
  to = module.monitoring_italynorth.azurerm_monitor_scheduled_query_rules_alert_v2.mailup
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/scheduledQueryRules/[SEND.MAILUP.COM] Many Failures"
}

# MONITORING WESTEUROPE

import {
  to = module.monitoring_westeurope.azurerm_application_insights.appi
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/components/io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["CIE L2"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/CIE L2-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["CIE L3"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/CIE L3-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["Spid-registry"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/Spid-registry-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["SpidL2-arubaid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/SpidL2-arubaid-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["SpidL2-infocamere"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/SpidL2-infocamere-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["SpidL2-infocertid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/SpidL2-infocertid-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["SpidL2-lepidaid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/SpidL2-lepidaid-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["SpidL2-namirialid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/SpidL2-namirialid-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["SpidL2-posteid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/SpidL2-posteid-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["SpidL2-sielteid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/SpidL2-sielteid-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["SpidL2-spiditalia"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/SpidL2-spiditalia-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["SpidL2-timid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/SpidL2-timid-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["api-app.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/api-app.io.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["api-mtls.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/api-mtls.io.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["api-web.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/api-web.io.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["api.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/api.io.italia.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["api.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/api.io.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["app-backend.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/app-backend.io.italia.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["assets.cdn.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/assets.cdn.io.italia.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["assets.cdn.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/assets.cdn.io.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["continua.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/continua.io.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["developerportal-backend.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/developerportal-backend.io.italia.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["firmaconio.selfcare.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/firmaconio.selfcare.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["github-raw-status-backend"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/github-raw-status-backend-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_application_insights_standard_web_test.web_tests["io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/webTests/io.italia.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_key_vault_secret.appinsights_connection_string
  id = "https://io-p-kv-common.vault.azure.net/secrets/appinsights-connection-string/45a5a6fbebcc4d569e4ceb1da3b671af"
}

import {
  to = module.monitoring_westeurope.azurerm_key_vault_secret.appinsights_instrumentation_key
  id = "https://io-p-kv-common.vault.azure.net/secrets/appinsights-instrumentation-key/5e6a72f75f77406e85ca51464f093e9d"
}

import {
  to = module.monitoring_westeurope.azurerm_log_analytics_workspace.log
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.OperationalInsights/workspaces/io-p-law-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_action_group.email
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/actionGroups/EmailPagoPA"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_action_group.error
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/actionGroups/ioperror"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_action_group.quarantine_error
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/actionGroups/iopquarantineerror"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_action_group.slack
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/actionGroups/SlackPagoPA"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["CIE L2"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/CIE L2-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["CIE L3"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/CIE L3-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["Spid-registry"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/Spid-registry-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["SpidL2-arubaid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/SpidL2-arubaid-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["SpidL2-infocamere"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/SpidL2-infocamere-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["SpidL2-infocertid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/SpidL2-infocertid-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["SpidL2-lepidaid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/SpidL2-lepidaid-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["SpidL2-namirialid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/SpidL2-namirialid-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["SpidL2-posteid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/SpidL2-posteid-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["SpidL2-sielteid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/SpidL2-sielteid-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["SpidL2-spiditalia"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/SpidL2-spiditalia-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["SpidL2-timid"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/SpidL2-timid-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["api-app.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/api-app.io.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["api-mtls.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/api-mtls.io.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["api-web.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/api-web.io.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["api.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/api.io.italia.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["api.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/api.io.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["app-backend.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/app-backend.io.italia.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["assets.cdn.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/assets.cdn.io.italia.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["assets.cdn.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/assets.cdn.io.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["continua.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/continua.io.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["developerportal-backend.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/developerportal-backend.io.italia.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["firmaconio.selfcare.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/firmaconio.selfcare.pagopa.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["github-raw-status-backend"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/github-raw-status-backend-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_metric_alert.metric_alerts["io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/metricAlerts/io.italia.it-test-io-p-ai-common"
}

import {
  to = module.monitoring_westeurope.azurerm_monitor_scheduled_query_rules_alert_v2.mailup
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Insights/scheduledQueryRules/[SEND.MAILUP.COM] Many Failures"
}