data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg_kv" {
  name     = "rg_kv_${lower(var.resource_name)}_${var.name_conv}"
  location = var.location
  tags = var.common_tags
}

resource "azurerm_key_vault" "kv" {
  name                        = "kv-${lower(var.resource_name)}-${lower(var.project)}"
  location                    = azurerm_resource_group.rg_kv.location
  resource_group_name         = azurerm_resource_group.rg_kv.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  enabled_for_disk_encryption = var.enabled_for_disk_encryption
  soft_delete_retention_days  = var.soft_delete_retention_days
  purge_protection_enabled    = var.purge_protection_enabled

  sku_name = var.sku_name

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id

        key_permissions = [
      "Create",
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover"
    ]

    storage_permissions = [
      "Get", "Set"
    ]
  }
  tags = var.common_tags
}

resource "azurerm_key_vault_secret" "name" {
  for_each = var.secrets

  name = each.key
  value = each.value
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_key" "key" {
  for_each = var.key_name

  name = each.value
  key_vault_id = azurerm_key_vault.kv.id
  key_type     = var.key_type
  key_size     = var.key_size
  key_opts     = var.key_ops

  rotation_policy {
    automatic {
      time_before_expiry = "P30D"
    }

    expire_after         = "P90D"
    notify_before_expiry = "P29D"
  }
}
#data "azurerm_" "name" {
#  
#}
resource "azurerm_storage_account_customer_managed_key" "sa_cmk" {
  for_each = var.storage_account_id

  storage_account_id = each.value
  key_vault_id       = azurerm_key_vault.kv.id
  key_name           = azurerm_key_vault_key.kv.name
}

# output keyvault id
output "kv_output" {
    value = azurerm_key_vault.kv.id
  }
