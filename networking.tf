resource "azurerm_subnet" "this_subnet" {
  name                 = "${local.owner}-${local.environment}-${var.subnet}"
  resource_group_name  = azurerm_resource_group.this_rg.name
  virtual_network_name = azurerm_virtual_network.this_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "this_nic" {
  for_each            = toset(var.usernames)
  name                = "nic-for-${each.value}"
  location            = azurerm_resource_group.this_rg.location
  resource_group_name = azurerm_resource_group.this_rg.name

  ip_configuration {
    name                          = "ip-config-vm"
    subnet_id                     = azurerm_subnet.this_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this_publicip[each.key].id
  }
}

resource "azurerm_public_ip" "this_publicip" {
  for_each = toset(var.usernames)
  name                = "public-ip-for-${each.value}"
  resource_group_name = azurerm_resource_group.this_rg.name
  location            = azurerm_resource_group.this_rg.location
  allocation_method   = "Static"

  tags = local.tags
}