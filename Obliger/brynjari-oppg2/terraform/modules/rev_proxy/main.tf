resource "azurerm_public_ip" "lb_ip" {
  name                = "${local.lb_name}-IP"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  tags                = var.common_tags
}

resource "azurerm_lb" "lb" {
  name                = local.lb_name
  location            = var.location
  resource_group_name = var.rg_name

  frontend_ip_configuration {
    name                 = azurerm_public_ip.lb_ip.name
    public_ip_address_id = azurerm_public_ip.lb_ip.id
  }
  tags = var.common_tags
}

resource "azurerm_lb_backend_address_pool" "lb_ap" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "${local.lb_name}AP"
  virtual_network_id = var.virtual_network_id
  
}

resource "azurerm_lb_backend_address_pool_address" "application_addesses" {
  count = length(var.applications)
  name                                = "${var.applications[count.index]}_${azurerm_lb_backend_address_pool.lb_ap.name}_IP"
  backend_address_pool_id             = azurerm_lb_backend_address_pool.lb_ap.id
  backend_address_ip_configuration_id = azurerm_lb.lb.frontend_ip_configuration[0].id
}


resource "azurerm_lb_rule" "lb_backend" {
  name                           = "${azurerm_lb.lb.name}-rule"
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_public_ip.lb_ip.name
  backend_address_pool_ids = [ "${azurerm_lb_backend_address_pool.lb_ap.id}" ]
  
}

