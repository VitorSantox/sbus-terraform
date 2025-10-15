output "subnet_id" {
  description = "ID da Subnet criada para ser usada pelas VMs."
  value       = azurerm_subnet.subnet001.id
}