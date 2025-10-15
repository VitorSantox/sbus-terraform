
resource "azurerm_servicebus_namespace" "sbus_lab_001" {
  name                = var.sbus_name
  location            = azurerm_resource_group.location
  resource_group_name = azurerm_resource_group.name
  sku                 = "Basic"

  tags = {
    source = "terraform"
  }
}

