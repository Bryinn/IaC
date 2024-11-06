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


resource "azurerm_resource_group" "rg_webapp" {
  name     = local.rg_name
  location = var.location
}

module "network" {
  source                  = "../modules/network"
  instance_name           = var.common_instance_name
  rg_name                 = azurerm_resource_group.rg_webapp.name
  address_space           = ["10.0.0.0/24"]
  sub_address_space       = [["10.0.0.0/25"], ["10.0.0.128/25"]]
  sub_address_space_names = ["HelloWorld", "ByeWorld"]
  dns_servers             = ["10.0.0.5", "10.0.0.132"]
  delegations             = ["Microsoft.Web/serverFarms", "Microsoft.Web/serverFarms"]
  location                = azurerm_resource_group.rg_webapp.location
  common_tags             = var.common_tags
}

#module "lb" {
#  source = "../modules/rev_proxy"
#  location = azurerm_resource_group.rg_webapp.location
#  rg_name = azurerm_resource_group.rg_webapp.name
#  virtual_network_id = module.network.subnet_ouput[0]
#  instance_name = "webapp"
#  applications = [ "${module.web.linux_web_app_name}" ]
#  common_tags = var.common_tags
#}

module "db" {
  source      = "../modules/db_mssql"
  common_tags = var.common_tags
  db_names    = ["main"]
  administrator_creds = {
    username = "testmanwithcheese"
    password = "ehag!381f#ailehgba"
  }
  rg_name       = azurerm_resource_group.rg_webapp.name
  instance_name = var.common_instance_name
  location      = azurerm_resource_group.rg_webapp.location
}
module "blob" {
  source        = "../modules/blob_storage"
  rg_name       = azurerm_resource_group.rg_webapp.name
  instance_name = var.common_instance_name
  location      = azurerm_resource_group.rg_webapp.location
  common_tags   = var.common_tags
  sa_name       = "bloblsa"
}
module "web" {
  source               = "../modules/web"
  db_connection_string = module.db.connection_string_value
  db_type              = module.db.type
  db_name              = module.db.db_name[0]
  rg_name              = azurerm_resource_group.rg_webapp.name
  instance_name        = var.common_instance_name
  location             = azurerm_resource_group.rg_webapp.location
  common_tags          = var.common_tags
  storage_account_details = {
    access_key   = "${module.blob.access_key}"
    share_name   = "${module.blob.share_name}"
    type         = "AzureBlob"
    account_name = "${module.blob.account_name}"
  }
  virtual_network_id = module.network.subnet_ouput[0]
}
