output "public_ip" {
  value = azurerm_public_ip.lb_ip.ip_address
}
output "private_ips" {
  value = azurerm_lb.lb.private_ip_addresses
}