output "linux_web_app_id" {
  value = azurerm_linux_web_app.webapp.id
}
output "linux_web_app_name" {
  value = azurerm_linux_web_app.webapp.name
}
output "linux_web_app_outbound_ips" {
  value = azurerm_linux_web_app.webapp.outbound_ip_addresses
}
output "web_default_hostname" {
  value = azurerm_linux_web_app.webapp.default_hostname
}