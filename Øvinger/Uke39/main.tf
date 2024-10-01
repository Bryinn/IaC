terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.116.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "rg_bry_backend"
    storage_account_name = "sabrybackend"
    container_name = "sc-sa-backend"
    key = "access-key-sa"
  }
}

provider "azurerm" {
    subscription_id = "c07d12e1-5880-4a69-837d-8004c99145fc"
  features {}
}

module "backend" {
  source = "./backend"
  
}

