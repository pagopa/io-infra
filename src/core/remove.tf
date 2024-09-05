removed {
  from = azurerm_key_vault_access_policy.cdn_kv
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_access_policy.adgroup_admin
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_access_policy.adgroup_developers
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_access_policy.access_policy_kv_io_infra_ci
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_access_policy.access_policy_kv_io_infra_cd
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_access_policy.azdevops_platform_iac_policy_kv
  lifecycle {
    destroy = false
  }
}

# common

removed {
  from = azurerm_key_vault_access_policy.adgroup_admin_common
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_access_policy.adgroup_developers_common
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_access_policy.access_policy_io_infra_ci
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_access_policy.access_policy_io_infra_cd
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_access_policy.app_service
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_access_policy.cdn_common
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_access_policy.azdevops_platform_iac_policy_kv_common
  lifecycle {
    destroy = false
  }
}
