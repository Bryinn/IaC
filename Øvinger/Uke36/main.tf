terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.116.0"
    }
  }
}

provider "azurerm" {
    subscription_id = "c07d12e1-5880-4a69-837d-8004c99145fc"
  features {}
}


resource "azurerm_resource_group" "rg-NSG-o3-bry" {
  name = "rg-NSG-o3-bry"
  location = var.location
  tags = local.common_tags
}

resource "azurerm_network_security_group" "nsg-o3-bry" {
  name                = "example-security-group"
  location            = azurerm_resource_group.rg-NSG-o3-bry.location
  resource_group_name = azurerm_resource_group.rg-NSG-o3-bry.name
  tags = local.common_tags
}

resource "azurerm_virtual_network" "vn-o3-bry" {
  name                = "example-network-1"
  location            = azurerm_resource_group.rg-NSG-o3-bry.location
  resource_group_name = azurerm_resource_group.rg-NSG-o3-bry.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
  

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.nsg-o3-bry.id
  }

  tags = local.common_tags
  
}



resource "azurerm_resource_group" "rg-SA-o3-bry" {
  name = "rg-SA-o3-bry"
  location = var.location
  tags = local.common_tags
}

resource "azurerm_storage_account" "sa1-o3-bry" {
  name = "o3testbrystorageaccount1"
  resource_group_name = azurerm_resource_group.rg-SA-o3-bry.name
  location = azurerm_resource_group.rg-SA-o3-bry.location
  account_tier = "Standard"
  account_replication_type = "LRS"
  tags = local.common_tags
}

resource "azurerm_storage_account" "sa2-o3-bry" {
  name = "o3testbrystorageaccount2"
  resource_group_name = azurerm_resource_group.rg-SA-o3-bry.name
  location = azurerm_resource_group.rg-SA-o3-bry.location
  account_tier = "Standard"
  account_replication_type = "LRS"
  tags = local.common_tags
}

resource "azurerm_storage_account" "sa3-o3-bry" {
  name = "o3testbrystorageaccount3"
  resource_group_name = azurerm_resource_group.rg-SA-o3-bry.name
  location = azurerm_resource_group.rg-SA-o3-bry.location
  account_tier = "Standard"
  account_replication_type = "LRS"
  tags = local.common_tags
}
