

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
