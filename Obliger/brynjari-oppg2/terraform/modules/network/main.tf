data "azurerm_client_config" "current" {}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg_${lower(var.instance_name)}"
  location            = var.location
  resource_group_name = var.rg_name
  tags                = var.common_tags

}

resource "azurerm_virtual_network" "vn" {
  name                = "vn_${lower(local.name_conv)}"
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.address_space
  dns_servers         = var.dns_servers

  tags = var.common_tags
}

resource "azurerm_subnet" "subnets" {
  count                = length(var.sub_address_space)
  name                 = "sub_vn_${var.sub_address_space_names[count.index]}_${lower(local.name_conv)}"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes     = var.sub_address_space[count.index]
  delegation {
    name = "delegation"

    service_delegation {
      name    = var.delegations[count.index]
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }
}

