output "resource_group_name" {
  description = "Nome do Resource Group criado"
  value = azurerm_resource_group.rg_terraform_sbuslab.name
}

output "location" {
  description = "Localização do Resource Group criado"
  value = azurerm_resource_group.rg_terraform_sbuslab.location
}

output "resource_group_id" {
    description = "ID do Resource Group criado"
    value = azurerm_resource_group.rg_terraform_sbuslab.id
}