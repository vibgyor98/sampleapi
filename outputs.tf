output "webapp_url" {
  # value = azurerm_app_service.webapp[0].default_site_hostname
  value = azurerm_app_service.webapp.default_site_hostname
}

output "webapp_ips" {
  # value = azurerm_app_service.webapp[0].outbound_ip_addresses
  value = azurerm_app_service.webapp.outbound_ip_addresses
}