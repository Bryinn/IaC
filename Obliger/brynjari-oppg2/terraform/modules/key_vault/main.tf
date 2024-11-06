resource "azurerm_storage_account" "sa" {
  name                     = local.sa_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  min_tls_version          = "TLS1_2"
}

resource "azurerm_storage_container" "sc" {
  name                  = "sc-${local.name_conv}"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"

}


resource "azurerm_key_vault" "kv" {
  name                        = "kv-${local.name_conv}"
  location                    = var.location
  resource_group_name         = var.rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true

  sku_name = "standard"


  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "List", "Create",
    ]

    secret_permissions = [
      "Get", "Set", "List",
    ]

    storage_permissions = [
      "Get", "Set", "List",
    ]
  }
  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
  }
}

resource "azurerm_key_vault_secret" "sa_accesskey" {
  name            = "access-key-kv-sa"
  value           = azurerm_storage_account.sa.primary_access_key
  key_vault_id    = azurerm_key_vault.kv.id
  expiration_date = var.expiration_date
  content_type    = "password"
}


resource "azurerm_key_vault_secret" "secrets" {
  for_each = var.secrets

  name = each.key
  value = each.value
  key_vault_id = azurerm_key_vault.kv.id
  expiration_date = var.expiration_date

  content_type = "password"
  tags = var.common_tags
}