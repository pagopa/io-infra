### Common resources

locals {
  devportal = {
    backend_hostname  = trimsuffix(azurerm_dns_a_record.developerportal_backend_io_italia_it.fqdn, ".")
    frontend_hostname = "developer.${var.dns_zone_io}.italia.it"
  }
}
