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
  sub_address_space = {
    webapp = ["10.0.1.0/24", "10.0.2.0/24"]
    honeypot = ["10.0.3.0/24"]
  }
  dns_servers = ["10.0.0.5"]
  common_tags = local.common_tags
  name_conv = local.name_conv
  resource_name = "webapp"
}

module "key_vault" {
  source = "./modules/key_vault"
  location = var.location
  resource_name = "webapp"
  common_tags = local.common_tags
  name_conv = local.name_conv
  project = var.project
  key_name = [ "sa-access-key" ] # first key is sa-access-key
  key_ops = [ "encrypt", "verify", "sign", "decrypt" ]
  key_size = 4096
  key_type = "rsa"
  secrets = {
    Brynjari = "123123heihei"
  }
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
  sa_key = module.key_vault.kv_ouput_keys[0].id # first key is sa-access-key
}

module "VM" {
  source = "./modules/virtual_machine"
  location = var.location
  vm_names = [ "webapp" ]
  vm_sizes = [ var.vm_sizes.medium ]
  network_interface_ids = [ module.network.subnet_ouput[0].id ]
  secrets = [ module.key_vault.kv_output_secrets[0] ]

  common_tags = local.common_tags
  name_conv = local.name_conv
}
