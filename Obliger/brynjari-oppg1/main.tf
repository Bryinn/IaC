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
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

module "network" {
  source = "./modules/network"
  location = var.location
  address_space = ["10.0.0.0/16"]
  sub_address_space = [
    ["10.0.1.0/24", "10.0.2.0/24"],
    ["10.0.3.0/24"]
  ]
  sub_address_space_names = ["webapp", "honeypot"]

  dns_servers = ["10.0.0.5"]
  common_tags = local.common_tags
  name_conv = local.name_conv
  resource_name = "webapp"
}

module "storage_account" {
  source = "./modules/storage_account"
  location = var.location
  replication_type = "LRS"
  sa_instances = 3
  sc_access_type = "private"
  common_tags = local.common_tags
  name_conv = local.name_conv
  resource_name = "webapp"
  project = var.project
}

module "key_vault" {
  source = "./modules/key_vault"
  location = var.location
  resource_name = "webapp"
  common_tags = local.common_tags
  name_conv = local.name_conv
  project = var.project
  key_name = [ ]
  key_ops = [ "encrypt", "verify", "sign", "decrypt" ]
  key_size = 4096
  key_type = "rsa"
  secrets = {
    Brynjari = "123123heihei!!!"
  }
  sa_keys_as_secrets = module.storage_account.primary_access_keys
  sa_names = module.storage_account.sa_names
}

module "VM" {
  source = "./modules/virtual_machine"
  location = var.location
  vm_names = [ "webapp" ]
  vm_sizes = [ var.vm_sizes.medium ]
  subnet_id = module.network.subnet_ouput[0].id
  secrets = [ module.key_vault.kv_output_secrets[0] ]
  common_tags = local.common_tags
  name_conv = local.name_conv
}
