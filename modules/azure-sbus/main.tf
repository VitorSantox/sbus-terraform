
resource "azurerm_servicebus_namespace" "sbus_lab_001" {
  name                = var.namespace_name
  location            = var.target_resource_group_location
  resource_group_name = var.target_resource_group_name
  sku                 = "Basic"

  tags = {
    source = "terraform"
  }
}

