resource "azurerm_resource_group" "rg_terraform_sbuslab" {
  name     = var.resource_group_name
  location = var.location
}
