resource "azurerm_resource_group" "rg_vm" {
  name = "rg_vm_${var.name_conv}"
  location = var.location
  tags = var.common_tags
}
/*
 resource "azurerm_virtual_machine" "main" {
  name                  = "Test1-vm"
  location              = azurerm_resource_group.rg_vm.location
  resource_group_name   = azurerm_resource_group.rg_vm.name
  network_interface_ids = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/rg_nsg_webapp_oblig1_prod/providers/Microsoft.Network/virtualNetworks/${var.network_interface_ids[0]}"]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
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
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}  */
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
