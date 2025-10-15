resource "azurerm_virtual_network" "network001" {
  name                = var.azurerm_virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = var.target_resource_group_location
  resource_group_name = var.target_resource_group_name
}

resource "azurerm_subnet" "subnet001" {
  name                 = var.azurerm_subnet_name
  resource_group_name  = var.target_resource_group_name
  virtual_network_name = azurerm_virtual_network.network001.name
  address_prefixes     = ["10.0.2.0/24"]
}