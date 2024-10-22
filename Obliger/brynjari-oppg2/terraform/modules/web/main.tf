resource "azurerm_service_plan" "sp_web" {
  name                = local.sp_name
  resource_group_name = var.rg_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "webapp" {
  name                  = local.webapp_name
  location              = var.location
  resource_group_name   = var.rg_name
  service_plan_id       = azurerm_service_plan.sp_web.id
  https_only            = true
  site_config { 
    minimum_tls_version = "1.2"
  }
}

resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id             = azurerm_linux_web_app.webapp.id
  repo_url           = var.repo_url
  branch             = var.branch
  use_manual_integration = false
  use_mercurial      = false
}