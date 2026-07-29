# This file will contain all the removed without destroy code blocks generated and used during the common domain split into multiple subdomains / platform
# https://pagopa.atlassian.net/browse/IOPLT-1626

removed {
  from = azurerm_resource_group.github_runner

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.github_runner_itn.azurerm_container_app_environment.github_runner

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.github_runner_itn.azurerm_subnet.github_runner

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.github_runner_itn.module.container_app_github_runner.azurerm_container_app_job.github_runner

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.github_runner_itn.module.container_app_github_runner.azurerm_key_vault_access_policy.keyvault_containerapp

  lifecycle {
    destroy = false
  }
}