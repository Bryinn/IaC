
resource "azurerm_resource_group" "rg-nsg" {
  name = "rg_nsg_${lower(var.resource_name)}_${var.name_conv}"
  location = var.location
  tags = var.common_tags
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg_${lower(var.resource_name)}_${var.name_conv}"
  location            = azurerm_resource_group.rg-nsg.location
  resource_group_name = azurerm_resource_group.rg-nsg.name
  tags = var.common_tags
}

resource "azurerm_virtual_network" "vn" {
  name                = "vn_${lower(var.resource_name)}_${var.name_conv}"
  location            = azurerm_resource_group.rg-nsg.location
  resource_group_name = azurerm_resource_group.rg-nsg.name
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  
  tags = var.common_tags
}

resource "azurerm_subnet" "subnets" {
  for_each = var.sub_address_space
  name = "sub_vn_${each.key}_${lower(var.resource_name)}_${var.name_conv}"
  resource_group_name = azurerm_resource_group.rg-nsg.name
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes = each.value
}

# output subnet id
output "subnet_ouput" {
    value = values(azurerm_subnet.subnets).id
  }
