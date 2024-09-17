# IO Infra - Notification Hubs

<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.107.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_metric_alert.alert_nh_common_anomalous_pns_success_volume](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.alert_nh_common_partition_1_anomalous_pns_success_volume](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.alert_nh_common_partition_1_pns_errors](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.alert_nh_common_partition_2_anomalous_pns_success_volume](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.alert_nh_common_partition_2_pns_errors](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.alert_nh_common_partition_3_anomalous_pns_success_volume](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.alert_nh_common_partition_3_pns_errors](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.alert_nh_common_partition_4_anomalous_pns_success_volume](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.alert_nh_common_partition_4_pns_errors](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_metric_alert.alert_nh_common_pns_errors](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_notification_hub.common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub) | resource |
| [azurerm_notification_hub.common01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub) | resource |
| [azurerm_notification_hub.common_partition_1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub) | resource |
| [azurerm_notification_hub.common_partition_2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub) | resource |
| [azurerm_notification_hub.common_partition_3](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub) | resource |
| [azurerm_notification_hub.common_partition_4](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub) | resource |
| [azurerm_notification_hub.sandbox](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub) | resource |
| [azurerm_notification_hub.sandbox_partition_1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub) | resource |
| [azurerm_notification_hub_authorization_rule.common_default_full](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub_authorization_rule) | resource |
| [azurerm_notification_hub_authorization_rule.common_default_listen](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub_authorization_rule) | resource |
| [azurerm_notification_hub_authorization_rule.common_partition_1_default_full](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub_authorization_rule) | resource |
| [azurerm_notification_hub_authorization_rule.common_partition_1_default_listen](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub_authorization_rule) | resource |
| [azurerm_notification_hub_authorization_rule.common_partition_2_default_full](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub_authorization_rule) | resource |
| [azurerm_notification_hub_authorization_rule.common_partition_2_default_listen](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub_authorization_rule) | resource |
| [azurerm_notification_hub_authorization_rule.common_partition_3_default_full](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub_authorization_rule) | resource |
| [azurerm_notification_hub_authorization_rule.common_partition_3_default_listen](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub_authorization_rule) | resource |
| [azurerm_notification_hub_authorization_rule.common_partition_4_default_full](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub_authorization_rule) | resource |
| [azurerm_notification_hub_authorization_rule.common_partition_4_default_listen](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub_authorization_rule) | resource |
| [azurerm_notification_hub_authorization_rule.sandbox_default_full](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub_authorization_rule) | resource |
| [azurerm_notification_hub_authorization_rule.sandbox_default_listen](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub_authorization_rule) | resource |
| [azurerm_notification_hub_authorization_rule.sandbox_partition_1_default_full](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub_authorization_rule) | resource |
| [azurerm_notification_hub_authorization_rule.sandbox_partition_1_default_listen](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub_authorization_rule) | resource |
| [azurerm_notification_hub_namespace.common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub_namespace) | resource |
| [azurerm_notification_hub_namespace.common_partition_1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub_namespace) | resource |
| [azurerm_notification_hub_namespace.common_partition_2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub_namespace) | resource |
| [azurerm_notification_hub_namespace.common_partition_3](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub_namespace) | resource |
| [azurerm_notification_hub_namespace.common_partition_4](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub_namespace) | resource |
| [azurerm_notification_hub_namespace.sandbox](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub_namespace) | resource |
| [azurerm_notification_hub_namespace.sandbox_partition_1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub_namespace) | resource |
| [azurerm_resource_group.notifications](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_key_vault.weu_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.ntfns_common_ntf_common_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.ntfns_common_ntf_common_api_key_sandbox](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.ntfns_common_ntf_common_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.ntfns_common_ntf_common_token_sandbox](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_monitor_action_group.io_com_action_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_resource_group.weu_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
