terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.116.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg_bry_backend_oblig2"
    storage_account_name = "sabrybackendoblig2"
    container_name       = "sc-sa-backend-oblig2"
    key                  = "bry-backend-oblig2-key"
  }
}

provider "azurerm" {
  subscription_id = "c07d12e1-5880-4a69-837d-8004c99145fc"
  features {}
}

resource "azurerm_resource_group" "rg_global" {
  name     = local.rg_name
  location = var.location
}
module "global_vault" {
  source          = "../modules/key_vault"
  location        = azurerm_resource_group.rg_global.location
  rg_name         = azurerm_resource_group.rg_global.name
  instance_name   = var.common_instance_name
  expiration_date = var.expiration_date
  common_tags     = var.common_tags
}