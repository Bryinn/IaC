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

module "network" {
  source = "./network"
  company = var.company
  location = var.location
  project = var.project
  project_owner = var.project_owner
  billing_code = var.billing_code
}

module "storageAccount" {
  source = "./storage_account"
  company = var.company
  location = var.location
  project = var.project
  project_owner = var.project_owner
  billing_code = var.billing_code
  environment = "prod"
  replication_type = "LRS"
  instances_per_region = {nor = 2, euw = 1}
}

