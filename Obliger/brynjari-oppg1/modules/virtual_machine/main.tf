resource "azurerm_resource_group" "rg_vm" {
  name = "rg_vm_${var.name_conv}"
  location = var.location
  tags = var.common_tags
}

resource "azurerm_network_interface" "nic" {
  count = length(var.vm_names)
  name                = "${var.vm_names[count.index]}-nic"
  location            = azurerm_resource_group.rg_vm.location
  resource_group_name = azurerm_resource_group.rg_vm.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  count = length(var.vm_names)
  depends_on = [ azurerm_network_interface.nic ]
  name                = "${var.vm_names[count.index]}-vm"
  resource_group_name = azurerm_resource_group.rg_vm.name
  location            = azurerm_resource_group.rg_vm.location
  size                = var.vm_sizes[count.index]
  admin_username      = var.secrets[count.index].name
  admin_password = var.secrets[count.index].value
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
    
  }
} 
