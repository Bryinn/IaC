

resource "azurerm_resource_group" "rg_sa" {
  for_each = {
    region = var.instances_by_region
  }
  name = "rg_sa_${local.name_conv}"
  location = each.value
  tags = local.common_tags
}

resource "azurerm_storage_account" "sa" {
  name = "sa_${azurerm_resource_group.rg_sa.location}_${local.name_conv}"
  resource_group_name = azurerm_resource_group.rg_sa.name
  location = azurerm_resource_group.rg_sa.location
  account_tier = "Standard"
  account_replication_type = var.replication_type
  tags = local.common_tags
}

