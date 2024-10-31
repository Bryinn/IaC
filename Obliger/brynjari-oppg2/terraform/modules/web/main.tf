resource "azurerm_service_plan" "sp_web" {
  name                = local.sp_name
  resource_group_name = var.rg_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "P1v2"
  tags                = var.common_tags
}

resource "azurerm_linux_web_app" "webapp" {
  name                = local.webapp_name
  location            = var.location
  resource_group_name = var.rg_name
  service_plan_id     = azurerm_service_plan.sp_web.id
  https_only          = true
  storage_account {
    name         = local.abs_sa_name
    access_key   = var.storage_account_details.access_key
    account_name = var.storage_account_details.account_name
    share_name   = var.storage_account_details.share_name
    type         = var.storage_account_details.type
  }
  site_config {
    minimum_tls_version = "1.2"
  }
  connection_string {
    name  = local.connection_string_name
    type  = var.db_connection_string.type
    value = var.db_connection_string.value
  }
  tags = var.common_tags
}

resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id                 = azurerm_linux_web_app.webapp.id
  repo_url               = var.repo_url
  branch                 = var.branch
  use_manual_integration = false
  use_mercurial          = false
}
