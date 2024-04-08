output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "subscription_id" {
  value = data.azurerm_subscription.current.subscription_id
}

output "managed_identity_github_ci" {
  value = {
    name                = module.identity_ci.identity_app_name
    resource_group_name = module.identity_ci.identity_resource_group
  }
}

output "managed_identity_github_cd" {
  value = {
    name                = module.identity_cd.identity_app_name
    resource_group_name = module.identity_cd.identity_resource_group
  }
}
