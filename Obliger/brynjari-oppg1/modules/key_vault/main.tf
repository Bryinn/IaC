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
    object_id = data.azurerm_client_config.current.object_id
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

resource "azurerm_key_vault_secret" "secrets" {
  for_each = var.secrets

  name = each.key
  value = each.value
  key_vault_id = azurerm_key_vault.kv.id

  tags = var.common_tags
}

resource "azurerm_key_vault_key" "key" {
  for_each = var.key_name

  name = each.value
  key_vault_id = azurerm_key_vault.kv.id
  key_type     = upper(var.key_type)
  key_size     = var.key_size
  key_opts     = var.key_ops

  rotation_policy {
    automatic {
      time_before_expiry = "P30D"
    }

    expire_after         = "P90D"
    notify_before_expiry = "P29D"
  }
  tags = var.common_tags
}
#data "azurerm_" "name" {
#  
#}
# output keyvault id
output "kv_output" {
    value = azurerm_key_vault.kv.id
  }

output "kv_ouput_keys" {
    value = values(azurerm_key_vault_key.key)
  }

output "kv_output_secrets" {
  value = values(azurerm_key_vault_secret.secrets)
}
