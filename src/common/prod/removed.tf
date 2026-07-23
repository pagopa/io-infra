# This file will contain all the removed without destroy code blocks generated and used during the common domain split into multiple subdomains / platform
# https://pagopa.atlassian.net/browse/IOPLT-1626

removed {
  from = dx_available_subnet_cidr.next_cidr_snet_agw

  lifecycle {
    destroy = false
  }
}

# APIM

removed {
  from = module.apim_itn.azurerm_key_vault_access_policy.apim_kv_policy

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_itn.azurerm_key_vault_access_policy.common

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_itn.azurerm_public_ip.apim

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_itn.azurerm_subnet.apim

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_itn.module.apim.azurerm_api_management_diagnostic.applicationinsights

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_itn.module.apim.azurerm_api_management_logger.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_itn.module.apim.azurerm_api_management.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_itn.module.apim.azurerm_monitor_autoscale_setting.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_itn.module.apim.azurerm_monitor_metric_alert.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_itn.module.apim.azurerm_network_security_group.nsg_apim

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_itn.module.apim.azurerm_private_dns_a_record.apim_azure_api_net

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_itn.module.apim.azurerm_private_dns_a_record.apim_management_azure_api_net

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_itn.module.apim.azurerm_private_dns_a_record.apim_scm_azure_api_net

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_itn.module.apim.azurerm_subnet_network_security_group_association.snet_nsg

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_itn.module.iam_adgroup_auth_admins.module.apim.azurerm_role_assignment.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_itn.module.iam_adgroup_bonus_admins.module.apim.azurerm_role_assignment.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_itn.module.iam_adgroup_com_admins.module.apim.azurerm_role_assignment.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_itn.module.iam_adgroup_svc_admins.module.apim.azurerm_role_assignment.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_itn.module.iam_adgroup_wallet_admins.module.apim.azurerm_role_assignment.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_itn.module.iam_cgn_pe_backend_app_01.module.apim.azurerm_role_assignment.this

  lifecycle {
    destroy = false
  }
}

# APP GATEWAY

removed {
  from = module.application_gateway_itn.azurerm_application_gateway.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.application_gateway_itn.azurerm_key_vault_access_policy.app_gateway_policy

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.application_gateway_itn.azurerm_key_vault_access_policy.app_gateway_policy_common

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.application_gateway_itn.azurerm_key_vault_access_policy.app_gateway_policy_ioweb

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.application_gateway_itn.azurerm_monitor_metric_alert.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.application_gateway_itn.azurerm_public_ip.agw

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.application_gateway_itn.azurerm_subnet.agw

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.application_gateway_itn.azurerm_user_assigned_identity.appgateway

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.application_gateway_itn.azurerm_web_application_firewall_policy.agw

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.application_gateway_itn.azurerm_web_application_firewall_policy.app

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.application_gateway_itn.module.app_gw_ioweb_kv.module.key_vault.azurerm_role_assignment.certificates

  lifecycle {
    destroy = false
  }
}

# PLATFORM API GATEWAY


removed {
  from = module.platform_api_gateway_apim_itn.azapi_resource.app_backend_pool

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_api_operation_policy.platform_internal_delete_session

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_api_operation_policy.platform_internal_get_cached_session

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_api_operation_policy.platform_legacy_get_ping

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_api_operation_policy.platform_legacy_get_ping_head

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_api_operation_policy.platform_legacy_get_server_info

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_api_operation_policy.platform_legacy_get_services_status

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_api_operation_policy.platform_legacy_get_services_status_head

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_api_operation_policy.platform_legacy_redirect

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_api_policy.platform_internal

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_api_policy.platform_legacy

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_api_version_set.platform_internal

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_api.platform_internal

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_api.platform_legacy

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_backend.app_backend_backends

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_named_value.platform_api_gateway_hostname_internal

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_named_value.session_manager_introspection_url

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_named_value.session_token_cache_prefix

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_policy_fragment.auth

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_policy_fragment.auth_cache

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_product_api.platform_platform_internal

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_product_api.platform_platform_legacy

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_product_policy.auth

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_product_policy.institutions

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_product_policy.platform

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_product_policy.sign

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_product.auth

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_product.institutions

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_product.platform

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_product.sign

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_key_vault_access_policy.platform_api_gateway_kv_policy

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_subnet.platform_api_gateway

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.module.iam_adgroup.module.apim.azurerm_role_assignment.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.module.platform_api_gateway.azurerm_api_management_diagnostic.applicationinsights

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.module.platform_api_gateway.azurerm_api_management_logger.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.module.platform_api_gateway.azurerm_api_management.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.module.platform_api_gateway.azurerm_monitor_autoscale_setting.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.module.platform_api_gateway.azurerm_monitor_diagnostic_setting.apim

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.module.platform_api_gateway.azurerm_monitor_metric_alert.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.module.platform_api_gateway.azurerm_network_security_group.nsg_apim

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.module.platform_api_gateway.azurerm_private_dns_a_record.apim_azure_api_net

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.module.platform_api_gateway.azurerm_private_dns_a_record.apim_management_azure_api_net

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.module.platform_api_gateway.azurerm_private_dns_a_record.apim_scm_azure_api_net

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.module.platform_api_gateway.azurerm_subnet_network_security_group_association.snet_nsg

  lifecycle {
    destroy = false
  }
}

# APIM IAM

removed {
  from = azurerm_role_assignment.apim_client_role

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_role_assignment.dev_portal_role

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_role_assignment.svc_devs_itn

  lifecycle {
    destroy = false
  }
}