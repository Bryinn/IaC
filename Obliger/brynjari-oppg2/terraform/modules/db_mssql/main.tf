resource "azurerm_mssql_server" "mssql_server" {
  name                         = "mssql-server-${local.instance_name}"
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.administrator_creds.username
  administrator_login_password = var.administrator_creds.password
  minimum_tls_version          = "1.2"
  tags                         = var.common_tags
  public_network_access_enabled= false

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

resource "azurerm_mssql_database" "mssql_db_backup" {
  name         = "mssql_db_backup_${local.instance_name}"
  server_id    = azurerm_mssql_server.mssql_server.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = var.max_size_gb[0]
  sku_name     = var.sku_name[0]
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

module "db_blob" {
  source = "../blob_storage"
  rg_name = var.rg_name
  location = var.location
  instance_name = "${var.instance_name}db"
  sa_name = "${var.instance_name}"
  common_tags = var.common_tags
}

resource "azurerm_mssql_database_extended_auditing_policy" "extended_auditing_policy" {
  database_id                             = azurerm_mssql_database.mssql_db_backup.id
  storage_endpoint                        = module.db_blob.primary_blob_endpoint
  storage_account_access_key              = module.db_blob.access_key
  storage_account_access_key_is_secondary = true
  retention_in_days                       = 90
}