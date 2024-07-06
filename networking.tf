resource "azurerm_virtual_network" "this_vnet" {
  name                = "${local.owner}-${var.virtual_network}-${local.environment}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.this_rg.location
  resource_group_name = azurerm_resource_group.this_rg.name
}

<<<<<<< HEAD
resource "azurerm_subnet" "this_subnet" {
=======
/*resource "azurerm_subnet" "example" {
>>>>>>> 288cbcbe6eaccec8f2addd972627d489b0a6950c
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.this_rg.name
  virtual_network_name = azurerm_virtual_network.this_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "this_nic" {
  name                = "${local.owner}-${var.network_nic}-${local.environment}"
  location            = azurerm_resource_group.this_rg.location
  resource_group_name = azurerm_resource_group.this_rg.name

  ip_configuration {
    name                          = "ip_config-vm"
    subnet_id                     = azurerm_subnet.this_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this_publicip.id
  }
}*/

resource "azurerm_public_ip" "this_publicip" {
  name                = "${local.owner}-${var.public_ip}-${local.environment}"
  resource_group_name = azurerm_resource_group.this_rg.name
  location            = azurerm_resource_group.this_rg.location
  allocation_method   = "Static"

  tags = local.tags
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
