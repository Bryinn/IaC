resource "azurerm_resource_group" "rg_vm" {
  name = "rg_vm_${var.name_conv}"
  location = var.location
  tags = var.common_tags
}

resource "azurerm_virtual_machine" "vms" {
  count = length(var.vm_names)

  name                  = "${var.vm_names[count.index]}-vm"
  location              = azurerm_resource_group.rg_vm.location
  resource_group_name   = azurerm_resource_group.rg_vm.name
  network_interface_ids = [var.network_interface_ids[count.index]]
  vm_size               = var.vm_sizes[count.index]

  delete_os_disk_on_termination = true
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = var.vm_names[count.index]
    admin_username = var.secrets[count.index].name
    admin_password = var.secrets[count.index].value
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = var.common_tags
}