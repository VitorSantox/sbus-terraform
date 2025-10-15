output "sbus_connection_string" {
  description = "String de Conexão Primária para o Service Bus Namespace."
  # Esta é a sintaxe para obter a string de conexão padrão do recurso Namespace.
  value       = azurerm_servicebus_namespace.sbus_namespace.default_primary_connection_string 
  sensitive   = true # Boa prática: oculta o valor nos logs do Terraform
}

output "sbus_namespace_name" {
  description = "O nome do Service Bus Namespace."
  value       = azurerm_servicebus_namespace.sbus_namespace.name
}