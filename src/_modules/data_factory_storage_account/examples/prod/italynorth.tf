module "data_factory" {
  source = "../modules/data_factory"
  
  data_factories = {
    factory1 = {
      name                = "01" #io-p-italynorth-wallet-migration-adf-01
      location            = local.location
      resource_group_name = local.resource_group
      tags                = local.tags
    }
  }
  

  azure_runtimes = {
    runtime1 = {
      name        = "01" #io-p-italynorth-wallet-migration-az-runtime-01
      location            = local.location
      data_factory = "factory1"
    }
  }

  self_hosted_runtimes = {
    shruntime1 = {
      name        = "01" #io-p-italynorth-wallet-migration-sf-runtime-01
      data_factory = "factory1"
    }
  }
linked_services = {
    service1 = {
      name            = "01" #io-p-italynorth-wallet-migration-ls-01
      data_factory    = "factory1"
      storage_account = "stbipdevtest1"
    },
    service2 = {
      name            = "02" #io-p-italynorth-wallet-migration-ls-02
      data_factory    = "factory1"
      storage_account = "stbipdevtest"
    }
  }

linked_services_tables = {
    service3 = {
      name            = "03" #io-p-italynorth-wallet-migration-ls-03
      data_factory    = "factory1"
      storage_account = "stbipdevtest1"
      connection_string = ""
    },
    service4 = {
      name            = "04" #io-p-italynorth-wallet-migration-ls-04
      data_factory    = "factory1"
      storage_account = "stbipdevtest"
      connection_string = ""
    }
  }

  storage_account_resource_groups = local.storage_account_resource_groups  

datasets = {
  dataset1 = {
    name           = "01" #io-p-italynorth-wallet-migration-ds-01
    data_factory   = "factory1"
    type           = "AzureBlob"
    linked_service = "service1"
    fileName       = ""  
    folderPath     = "source"
    encoding_name   = "UTF8"
  }

  dataset2 = {
    name           = "02" #io-p-italynorth-wallet-migration-ds-02
    data_factory   = "factory1"
    type           = "AzureBlob"
    linked_service = "service2"
    fileName       = ""  
    folderPath     = "output"
    encoding_name   = "UTF8"
  }
}

datasets_tables = {
  "dataset1"= {
    name           = "03" #io-p-italynorth-wallet-migration-ds-03
    data_factory   = "factory1"
    linked_service = "service3"
    table_name     = "Table1"
  },
  "dataset2"= {
    name           = "04" #io-p-italynorth-wallet-migration-ds-04
    data_factory   = "factory1"
    linked_service = "service4"
    table_name     = "Table2"
  }
}

  pipelines = {
    pipeline1 = {
      name              = "01" #iopitwalletmigrationpipeline01
      data_factory      = "factory1"
      wildcard_file_name = "*.json"
      input_dataset     = "io-p-italynorth-wallet-migration-ds-container-01"
      output_dataset    = "io-p-italynorth-wallet-migration-ds-container-02"
      variables         = {} 
    }
  }

pipelines_tables = {
  "pipeline1"= {
    name                   = "02" #iopitwalletmigrationpipeline02
    data_factory           = "factory1"
    variables              = {}
    input_dataset          = "io-p-italynorth-wallet-migration-ds-table-03"
    output_dataset         = "io-p-italynorth-wallet-migration-ds-table-04"
  }
}
}