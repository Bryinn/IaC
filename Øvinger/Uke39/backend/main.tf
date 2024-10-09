data "azurerm_client_config" "current" {}


resource "azurerm_resource_group" "rg_sa" {
  name = "rg_bry_backend"
  location = "norwayeast"
}

resource "azurerm_storage_account" "sa" {  
  name = "sabrybackend"
  resource_group_name = azurerm_resource_group.rg_sa.name
  location = azurerm_resource_group.rg_sa.location
  account_tier = "Standard"
  account_replication_type = "GRS"

}

resource "azurerm_storage_container" "sc" {
  name                  = "sc-sa-backend"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
  
}


resource "azurerm_key_vault" "kv" {
  name                        = "kv-bry-backend"
  location                    = azurerm_resource_group.rg_sa.location
  resource_group_name         = azurerm_resource_group.rg_sa.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get","List","Create",
    ]

    secret_permissions = [
      "Get","Set","List",
    ]

    storage_permissions = [
      "Get","Set","List",
    ]
  }
}

resource "azurerm_key_vault_secret" "sa_backend_accesskey" {
  name = "web-terraform-tfstate"
  value = azurerm_storage_account.sa.primary_access_key
  key_vault_id = azurerm_key_vault.kv.id
}