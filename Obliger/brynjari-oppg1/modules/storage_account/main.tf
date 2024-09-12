resource "azurerm_resource_group" "rg_sa" {
  name = "rg_sa_${lower(var.resource_name)}_${var.name_conv}"
  location = var.location
  tags = var.common_tags
}

resource "azurerm_storage_account" "sa" {
  count = var.sa_instances
  name = "${lower(var.project)}${lower(var.resource_name)}${count.index+1}"
  resource_group_name = azurerm_resource_group.rg_sa.name
  location = azurerm_resource_group.rg_sa.location
  account_tier = "Standard"
  account_replication_type = var.replication_type
  tags = var.common_tags
  
}

# storage countainers created for every storage account
resource "azurerm_storage_container" "sc" {
  depends_on = [ azurerm_storage_account.sa ]
  count = var.sa_instances
  name                  = "sc-${lower(var.project)}-${lower(var.resource_name)}-${count.index+1}"
  storage_account_name  = "${lower(var.project)}${lower(var.resource_name)}${count.index+1}"
  container_access_type = var.sc_access_type
  
}

# output sa connection string id
#output "sa_connection_string" {
#    value = azurerm_storage_account.sa.primary_connection_string
#  }
output "sa_id" {
    value = values(azurerm_storage_account.sa).id
  }