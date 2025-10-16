# 1. Output da String de Conexão do Service Bus
output "sbus_connection_string" {
  description = "String de Conexão Primária para o Service Bus Namespace."
  # Pega o output do módulo "sbus"
  value     = module.sbus.sbus_connection_string
  sensitive = true
}

# 2. Output do IP Público (Produtor)
output "produtor_ip" {
  description = "IP Público da VM Produtora para acesso SSH."
  # Pega o output do módulo "vm_produtor"
  value = module.vm_produtor.vm_public_ip
}

# 3. Output do IP Público (Consumidor)
output "consumidor_ip" {
  description = "IP Público da VM Consumidora para acesso SSH."
  # Pega o output do módulo "vm_consumidor"
  value = module.vm_consumidor.vm_public_ip
}