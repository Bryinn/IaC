resource "azurerm_public_ip" "lb_ip" {
  name                = "${local.lb_name}-IP"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
}

resource "azurerm_lb" "lb" {
  name                = "${local.lb_name}"
  location            = var.location
  resource_group_name = var.rg_name

  frontend_ip_configuration {
    name                 = azurerm_public_ip.lb_ip.name
    public_ip_address_id = azurerm_public_ip.lb_ip.id
  }
}

resource "azurerm_lb_rule" "lb_backend" {
  name = "${azurerm_lb.lb.name}-rule"
  loadbalancer_id = azurerm_lb.lb.id
  protocol = "Tcp"
  frontend_port = 80
  backend_port = 80
  frontend_ip_configuration_name = azurerm_public_ip.lb_ip.name
  # backend_address_pool_ids = 
}

