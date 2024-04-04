locals {

  resource_group_name_common = "${var.project}-rg-common"

  cgn_cosmosdb_containers = [
    {
      name               = "user-cgns"
      partition_key_path = "/fiscalCode"
      autoscale_settings = {
        max_throughput = 2000
      },
    },
    {
      name               = "user-eyca-cards"
      partition_key_path = "/fiscalCode"
      autoscale_settings = {
        max_throughput = 2000
      },
    },
  ]
}
