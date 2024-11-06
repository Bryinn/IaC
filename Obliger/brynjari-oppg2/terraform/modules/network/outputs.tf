output "subnet_ouput" {
  value = [ for i in azurerm_subnet.subnets: "${i.id}" ]
}