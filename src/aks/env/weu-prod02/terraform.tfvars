prefix         = "io"
env_short      = "p"
env            = "prod"
domain         = "prod02-aks"
location       = "westeurope"
location_short = "weu"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "IO"
  Source      = "https://github.com/pagopa/io-infra/src/sign"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

lock_enable = true

### External resources

vnet_name                = "io-p-vnet-common"
vnet_resource_group_name = "io-p-rg-common"

monitor_resource_group_name                 = "io-p-rg-common"
log_analytics_workspace_name                = "io-p-law-common"
log_analytics_workspace_resource_group_name = "io-p-rg-common"

### Aks

aks_sku_tier = "Paid"

aks_system_node_pool = {
  name                         = "system01"
  vm_size                      = "Standard_D2ds_v5"
  os_disk_type                 = "Ephemeral"
  os_disk_size_gb              = "75"
  node_count_min               = "2"
  node_count_max               = "3"
  only_critical_addons_enabled = true
  node_labels                  = { node_name : "aks-system-01", node_type : "system" },
  node_tags                    = { node_tag_1 : "1" },
}

aks_user_node_pool = {
  enabled         = true
  name            = "user01"
  vm_size         = "Standard_D8ds_v5"
  os_disk_type    = "Ephemeral"
  os_disk_size_gb = "300"
  node_count_min  = "2"
  node_count_max  = "3"
  node_labels     = { node_name : "aks-user-01", node_type : "user" },
  node_taints     = [],
  node_tags       = { node_tag_1 : "1" },
}

aks_cidr_subnet = ["10.12.0.0/17"]
