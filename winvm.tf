

resource "azurerm_virtual_network" "this_vnet" {
  name                = "${loacal.owner}-${loacal.environment}-${var.vnet}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.this_rg.location
  resource_group_name = azurerm_resource_group.this_rg.name
}



resource "azurerm_windows_virtual_machine" "this_vm" {
  name                = "${loacal.owner}-${loacal.environment}-${var.win_vm_name}"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_F2"
  admin_username      = "${loacal.owner}-${loacal.environment}-${var.win_vm_username}"
  admin_password      = "${loacal.owner}-${loacal.environment}-${var.win_vm_password}"
  network_interface_ids = [
    azurerm_network_interface.this_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}