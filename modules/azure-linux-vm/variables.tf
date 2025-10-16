
variable "azurerm_linux_virtual_machine_name" {
  description = "linux virtual machine name"
  type = string
}

variable "target_resource_group_name"{
    description = "Nome do Resource Group onde a VM será criada"
    type = string
}

variable "target_resource_group_location" {
    description = "Localização do Resource Group onde a VM será criada"
    type = string
}

variable "target_subnet_id" {
  description = "O ID da Subnet criada pelo módulo network."
  type        = string
}
