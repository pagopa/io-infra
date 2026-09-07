output "apim" {
  value = {
    itn = module.apim_itn
  }
}

output "platform_api_gateway" {
  value = {
    itn = module.platform_api_gateway_apim_itn
  }
}

output "application_gateway" {
  value = {
    itn = module.application_gateway_itn
  }
}