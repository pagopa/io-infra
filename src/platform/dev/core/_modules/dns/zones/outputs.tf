output "function_private_dns_zone_ids" {
  description = "Private DNS zone IDs for Function Apps and their Storage accounts."

  # The DX Function module uses these IDs to decide at plan time whether to look up each zone.
  value = merge(
    {
      for service, name in local.function_storage_private_dns_zones :
      service => "${data.azurerm_resource_group.common.id}/providers/Microsoft.Network/privateDnsZones/${name}"
    },
    { azurewebsites = data.azurerm_private_dns_zone.app_service.id },
  )

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.storage,
    azurerm_private_dns_zone_virtual_network_link.app_service,
  ]
}
