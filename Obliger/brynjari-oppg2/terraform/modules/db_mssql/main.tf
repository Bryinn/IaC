resource "azurerm_mssql_server" "mssql_server" {
  name                         = "mssql_server_${local.instance_name}"
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.administrator_creds.username
  administrator_login_password = var.administrator_creds.password
  tags                         = var.common_tags
}

resource "azurerm_mssql_database" "mssql_db" {
  count = length(var.db_names)

  name         = "mssql_db_${var.db_names[count.index]}_${local.instance_name}"
  server_id    = azurerm_mssql_server.mssql_server.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = var.max_size_gb[count.index]
  sku_name     = var.sku_name[count.index]
  enclave_type = "VBS"

  tags = {
    project      = local.project
    owner        = local.owner
    billing_code = local.billing_code
    server       = azurerm_mssql_server.mssql_server.name
  }


  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}
