resource "azurerm_virtual_network" "vnet" {
  name                = var.vnetname 
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.rgname
}
resource "azurerm_subnet" "PublicSubnet" {
  name                 = "PublicSubnet-${var.environment}"
  resource_group_name  = var.rgname
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.address_pref_publ
}

resource "azurerm_subnet" "PrivateSubnet" {
  name                 = "PrivateSubnet-${var.environment}"
  resource_group_name  = var.rgname
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.address_pref_priv
}