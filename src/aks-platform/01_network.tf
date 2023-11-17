data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_virtual_network" "vnet_common" {
  name                = local.vnet_common_name
  resource_group_name = local.vnet_common_resource_group_name
}

# System Node Pool Subnet
module "aks_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v4.1.4"
  name                                      = "${local.project}-aks-snet"
  address_prefixes                          = var.aks_system_cidr_subnet
  resource_group_name                       = data.azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name                      = data.azurerm_virtual_network.vnet.name
  private_endpoint_network_policies_enabled = false
}

# User Node Pool Subnet
module "aks_user_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v4.1.4"
  name                                      = "${local.project}-aks-user-snet"
  address_prefixes                          = var.aks_user_cidr_subnet
  resource_group_name                       = data.azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name                      = data.azurerm_virtual_network.vnet.name
  private_endpoint_network_policies_enabled = false
}

resource "azurerm_public_ip" "aks_outbound" {
  count = var.aks_num_outbound_ips

  name                = format("%s-aksoutbound-pip-%02d", local.project, count.index + 1)
  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = azurerm_resource_group.aks_rg.location
  sku                 = "Standard"
  allocation_method   = "Static"
  zones               = [1, 2, 3]

  tags = var.tags
}

# vnet_common needs a vnet link with aks private dns zone
# aks terrform module doesn't export private dns zone
resource "null_resource" "create_vnet_commmon_aks_link" {
  triggers = {
    cluster_name = local.aks_name
    vnet_id      = data.azurerm_virtual_network.vnet_common.id
    vnet_name    = data.azurerm_virtual_network.vnet_common.name
  }

  provisioner "local-exec" {
    command = <<EOT
      dns_zone_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${self.triggers.cluster_name}')].{name:name}")
      dns_zone_resource_group_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${self.triggers.cluster_name}')].{resourceGroup:resourceGroup}")
      az network private-dns link vnet create \
        --name ${self.triggers.vnet_name} \
        --registration-enabled false \
        --resource-group $dns_zone_resource_group_name \
        --virtual-network ${self.triggers.vnet_id} \
        --zone-name $dns_zone_name
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
      dns_zone_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${self.triggers.cluster_name}')].{name:name}")
      dns_zone_resource_group_name=$(az network private-dns zone list --output tsv --query "[?contains(id,'${self.triggers.cluster_name}')].{resourceGroup:resourceGroup}")
      az network private-dns link vnet delete \
        --name ${self.triggers.vnet_name} \
        --resource-group $dns_zone_resource_group_name \
        --zone-name $dns_zone_name \
        --yes
    EOT
  }
}
