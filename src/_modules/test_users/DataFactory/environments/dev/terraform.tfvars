data_factories = {
  dev_adf = {
    name                = "adfdevbiptest1"
    location            = "Italy North"
    resource_group_name = "dev-fasanorg"
    tags                = {
      Provider     = "BIP"
      Environment  = "DEV"
      Application  = "Test"
      Owners       = "Cristian Felice Cuffari, Domenico Fasano"
    }
  }
}

azure_runtimes = {
  dev_runtime = {
    name         = "runtime-dev"
    location     = "West Europe"
    data_factory = "dev_adf"
  }
}

self_hosted_runtimes = {
  dev_self_hosted = {
    name         = "self-hosted-dev"
    data_factory = "dev_adf"
  }
}

linked_services = {
  dev_blob_service = {
    name                = "blob-storage-dev"
    data_factory        = "dev_adf"
    type                = "AzureBlobStorage"
    type_properties_json = <<JSON
{
  "connectionString": ""
}
JSON
    storage_account     = "stbipdevtest1"
  },
  prod_blob_service = {
    name                = "blob-storage-dev2"
    data_factory        = "dev_adf"
    type                = "AzureBlobStorage"
    type_properties_json = <<JSON
{
  "connectionString": ""
}
JSON
    storage_account     = "stbipdevtest"
  }
}

# Resource group associato agli storage account
storage_account_resource_groups = {
  dev_blob_service  = "dev-fasanorg"
  prod_blob_service = "dev-fasanorg"
}


datasets = {
  dev_json_dataset = {
    name                 = "json_dataset_dev"
    data_factory         = "dev_adf"
    type                 = "Json"
    linked_service       = "dev_blob_service"
    type_properties_json = <<JSON
{
  "location": {
    "container": "source",
    "fileName": "",
    "folderPath": "",
    "type": "AzureBlobStorageLocation"
  },
  "encodingName": "UTF-8"
}
JSON
  },
    dev2_json_dataset = {
    name                 = "json2_dataset_dev"
    data_factory         = "dev_adf"
    type                 = "Json"
    linked_service       = "prod_blob_service"
    type_properties_json = <<JSON
{
  "location": {
    "container": "destination",
    "fileName": "",
    "folderPath": "",
    "type": "AzureBlobStorageLocation"
  },
  "encodingName": "UTF-8"
}
JSON
  }

}

# Definizione della pipeline
pipelines = {
  pipeline_1 = {
    name          = "Pipeline1"
    data_factory  = "dev_adf"
    variables     = {
      "bob" = "item1"
    }
    activities_json = <<JSON
[
    {
        "name": "CopyActivity",
        "type": "Copy",
        "dependsOn": [],
        "policy": {
            "timeout": "0.12:00:00",
            "retry": 0,
            "retryIntervalInSeconds": 30,
            "secureOutput": false,
            "secureInput": false
        },
        "userProperties": [],
        "typeProperties": {
            "source": {
                "type": "JsonSource",
                "storeSettings": {
                    "type": "AzureBlobStorageReadSettings",
                    "recursive": true,
                    "enablePartitionDiscovery": false,
                    "wildcardFileName": "*"

                },
                "formatSettings": {
                    "type": "JsonReadSettings"
                }
            },
            "sink": {
                "type": "JsonSink",
                "storeSettings": {
                    "type": "AzureBlobStorageWriteSettings"
                },
                "formatSettings": {
                    "type": "JsonWriteSettings"
                }
            },
            "enableStaging": false
        },
        "inputs": [
            {
                "referenceName": "json_dataset_dev",
                "type": "DatasetReference"
            }
        ],
        "outputs": [
            {
                "referenceName": "json2_dataset_dev",
                "type": "DatasetReference"
            }
        ]
    }
]
    JSON
  }
}


