module "apim" {
  source  = "pagopa-dx/azure-api-management/azurerm"
  version = "~> 2.0"

  environment = {
    prefix          = var.prefix
    env_short       = "d"
    location        = var.location
    app_name        = "apim"
    instance_number = "01"
  }

  resource_group_name = var.resource_group
  use_case            = var.use_case

  publisher_email           = data.azurerm_key_vault_secret.apim_publisher_email.value
  publisher_name            = "IO"
  notification_sender_email = data.azurerm_key_vault_secret.apim_publisher_email.value

  public_ip_address_id         = azurerm_public_ip.apim.id
  enable_public_network_access = true

  virtual_network = {
    name                = var.vnet_common.name
    resource_group_name = var.vnet_common.resource_group_name
  }

  subnet_id                     = azurerm_subnet.apim.id
  virtual_network_type_internal = true

  application_insights = {
    enabled             = false
    connection_string   = var.ai_connection_string
    sampling_percentage = 5.0
    verbosity           = "error"
  }

  autoscale = {
    enabled                       = false
    default_instances             = 2
    minimum_instances             = 2
    maximum_instances             = 6
    scale_out_capacity_percentage = 50
    scale_out_time_window         = "PT3M"
    scale_out_value               = "2"
    scale_out_cooldown            = "PT5M"
    scale_in_capacity_percentage  = 20
    scale_in_time_window          = "PT5M"
    scale_in_value                = "2"
    scale_in_cooldown             = "PT5M"
  }

  tags = var.tags
}