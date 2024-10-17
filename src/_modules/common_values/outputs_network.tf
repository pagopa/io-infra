
output "virtual_networks" {
  description = <<EOF
  WHAT: All vnets into itn and weu regions
  EOF
  value = {
    itn = {
      common = local.core.networking.itn.vnet_common
    }
    weu = {
      common = local.core.networking.weu.vnet_common
      beta = {
        name                = data.azurerm_virtual_network.weu_beta.name
        resource_group_name = data.azurerm_virtual_network.weu_beta.resource_group_name
      }
      prod01 = {
        name                = data.azurerm_virtual_network.weu_prod01.name
        resource_group_name = data.azurerm_virtual_network.weu_prod01.resource_group_name
      }
    }
  }
}

output "pep_subnets" {
  description = <<EOF
  WHAT: Private Endpoint dedicated subnets into itn and weu regions
  EOF
  value = {
    itn = {
      id = local.core.networking.itn.pep_snet.id
    },
    weu = {
      id = local.core.networking.weu.pep_snet.id
    }
  }
}

output "dns_zones" {
  description = <<EOF
  WHAT: All common dns zones
  EOF
  value = {
    io_italia = {
      name                = "io.italia.it"
      resource_group_name = "${local.project_weu_legacy}-rg-external"
    }
    io_papopa = {
      name                = "io.pagopa.it"
      resource_group_name = "${local.project_weu_legacy}-rg-external"
    }
    io_selfcare = {
      name                = "io.selfcare.pagopa.it"
      resource_group_name = "${local.project_weu_legacy}-rg-external"
    }
    firmaconio_selfcare = {
      name                = "firmaconio.selfcare.pagopa.it"
      resource_group_name = "${local.project_weu_legacy}-rg-external"
    }
    io_web = {
      name                = "ioapp.it"
      resource_group_name = "${local.project_weu_legacy}-rg-external"
    }
  }
}

output "private_dns_zones" {
  description = <<EOF
  WHAT: All private dns zones
  EOF
  value = {
    io_papopa = {
      name                = "internal.io.pagopa.it"
      resource_group_name = "${local.project_weu_legacy}-rg-internal"
    }
    redis = {
      name                = "privatelink.redis.cache.windows.net"
      resource_group_name = "${local.project_weu_legacy}-rg-common"
    }
    postgres = {
      name                = "privatelink.postgres.database.azure.com"
      resource_group_name = "${local.project_weu_legacy}-rg-common"
    }
    mysql = {
      name                = "privatelink.mysql.database.azure.com"
      resource_group_name = "${local.project_weu_legacy}-rg-common"
    }
    azurecr = {
      name                = "privatelink.azurecr.io"
      resource_group_name = "${local.project_weu_legacy}-rg-common"
    }
    mongo = {
      name                = "privatelink.mongo.cosmos.azure.com"
      resource_group_name = "${local.project_weu_legacy}-rg-common"
    }
    eventhub = {
      name                = "privatelink.servicebus.windows.net"
      resource_group_name = "${local.project_weu_legacy}-rg-common"
    }
    cosmos = {
      name                = "privatelink.documents.azure.com"
      resource_group_name = "${local.project_weu_legacy}-rg-common"
    }
    storage_account_blob = {
      name                = "privatelink.blob.core.windows.net"
      resource_group_name = "${local.project_weu_legacy}-rg-common"
    }
    storage_account_queue = {
      name                = "privatelink.queue.core.windows.net"
      resource_group_name = "${local.project_weu_legacy}-rg-common"
    }
    storage_account_table = {
      name                = "privatelink.table.core.windows.net"
      resource_group_name = "${local.project_weu_legacy}-rg-common"
    }
    app_service = {
      name                = "privatelink.azurewebsites.net"
      resource_group_name = "${local.project_weu_legacy}-rg-common"
    }
    search = {
      name                = "privatelink.search.windows.net"
      resource_group_name = "${local.project_weu_legacy}-rg-common"
    }
    azure_api = {
      name                = "azure-api.net"
      resource_group_name = "${local.project_weu_legacy}-rg-common"
    }
    management_azure_api = {
      name                = "management.azure-api.net"
      resource_group_name = "${local.project_weu_legacy}-rg-common"
    }
    scm_azure_api = {
      name                = "scm.azure-api.net"
      resource_group_name = "${local.project_weu_legacy}-rg-common"
    }
  }
}