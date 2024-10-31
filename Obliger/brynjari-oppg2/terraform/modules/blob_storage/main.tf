resource "azurerm_storage_account" "sa" {
  name                     = local.sa_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = var.sa_account_tier
  account_replication_type = var.sa_account_replication
  tags                     = var.common_tags
}

resource "azurerm_storage_container" "sc" {
  name                  = local.sc_name
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = var.sc_access_type
}

resource "azurerm_storage_blob" "blob" {
  name                   = local.blob_name
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.sc.name
  type                   = var.blob_storage_type
}

