output "vm_public_ip" {
  description = "O endereço IP público da Máquina Virtual (se houver)."
  # Assumindo que você criou o IP Público associado à NIC (Network Interface)
  # Se o IP público foi criado separadamente e associado à NIC, você deve referenciá-lo aqui.
  # Se ele está sendo alocado automaticamente, você precisa garantir que o módulo NIC/VM 
  # crie e exporte a referência correta.
  # VOU USAR A REFERÊNCIA MAIS COMUM:
  value       = azurerm_public_ip.vm_pip.ip_address # Exemplo: Se você tivesse criado um PIP chamado 'vm_pip'
}

output "vm_id" {
  description = "O ID da Máquina Virtual no Azure."
  value       = azurerm_linux_virtual_machine.vm.id
}