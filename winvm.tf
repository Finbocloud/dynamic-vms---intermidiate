resource "azurerm_windows_virtual_machine" "this_win_vm" {
  for_each            = toset(var.usernames)
  name                = "vm-for-${each.key}"
  computer_name       = "vm-${each.key}"
  resource_group_name = azurerm_resource_group.this_rg.name
  location            = azurerm_resource_group.this_rg.location
  size                = "Standard_F2"
  admin_username      = each.value
  admin_password      = azurerm_key_vault_secret.this_vm_secret[each.key].value
  network_interface_ids = [
    azurerm_network_interface.this_nic[each.key].id
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





resource "azurerm_network_interface" "this_nic" {
  for_each = toset(var.usernames)
  name     = "nic-for-${each.value}"
  location = azurerm_resource_group.this_rg.location

  resource_group_name = azurerm_resource_group.this_rg.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.this_subnet.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = azurerm_public_ip.students_public_ip[each.key].id
  }
  depends_on = [
  azurerm_subnet.this_subnet]
}

resource "azurerm_subnet" "this_subnet" {
  name                 = "${local.owner}-${local.environment}-${var.subnet}"
  resource_group_name  = azurerm_resource_group.this_rg.name
  virtual_network_name = azurerm_virtual_network.this_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}
