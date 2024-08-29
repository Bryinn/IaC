terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.116.0"
    }
  }
}

provider "azurerm" {
    subscription_id = "cc9de1cc-5867-4904-80ba-7b55a098b42f"
  features {}
}

resource "azurerm_resource_group" "rg-fd-bry" {
  name = "rg-fd-bry"
  location = "West Europe"
  
}
resource "azurerm_storage_account" "sa-fd-bry" {
  name = "fdtestbrystorageaccount1"
  resource_group_name = azurerm_resource_group.rg-fd-bry.name
  location = azurerm_resource_group.rg-fd-bry.location
  account_tier = "Standard"
  account_replication_type = "LRS"
}

