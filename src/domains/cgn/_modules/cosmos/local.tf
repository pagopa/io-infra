locals {
  project = "io-${var.env_short}"

  cgn_cosmosdb_containers = [
    {
      name               = "user-cgns"
      partition_key_path = "/fiscalCode"
      autoscale_settings = {
        max_throughput = 1000
      },
    },
    {
      name               = "user-eyca-cards"
      partition_key_path = "/fiscalCode"
      autoscale_settings = {
        max_throughput = 1000
      },
    },
  ]
}
