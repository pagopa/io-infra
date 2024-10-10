# Main.tf per l'ambiente DEV
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

data "azurerm_client_config" "current" {}

module "data_factory" {
  source = "../../modules/data_factory"

  data_factories            = var.data_factories
  pipelines                 = var.pipelines
  azure_runtimes            = var.azure_runtimes
  self_hosted_runtimes      = var.self_hosted_runtimes
  linked_services           = var.linked_services
  datasets                  = var.datasets
  storage_account_resource_groups = var.storage_account_resource_groups  # Aggiungi questa riga
}


