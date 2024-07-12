#bad to put all current configuration
data "azurerm_client_config" "current" {}
resource "azurerm_key_vault" "this_keyvault" {
  name                       = "solarkeyvault"
  location                   = azurerm_resource_group.this_rg.location
  resource_group_name        = azurerm_resource_group.this_rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "premium"
  soft_delete_retention_days = 7
  network_acls {
    default_action             = "Deny"
    bypass                     = "AzureServices"
    ip_rules                   = ["81.105.32.49"]
    virtual_network_subnet_ids = []
  }
}

# Assuming you have a for_each loop defined
resource "azurerm_key_vault_secret" "this_vm_secret" {
  for_each = toset(var.usernames) # some map or list variable
  name     = "secret-for-${each.key}"
  # random_password is still fadded coz there is no value generated yet
  value        = random_password.this_password[each.value].result
  key_vault_id = azurerm_key_vault.this_keyvault.id
}
