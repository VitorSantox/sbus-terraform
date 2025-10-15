variable "azurerm_virtual_network_name" {
    description = "Nome da network"
    type = string
    default     = "network001" 
}

variable "azurerm_subnet_name" {
  description = "subnet name"
  type = string
  default     = "subnet001"
}
variable "target_resource_group_name"{
    description = "Nome do Resource Group onde a VM será criada"
    type = string
}

variable "target_resource_group_location" {
    description = "Localização do Resource Group onde a VM será criada"
    type = string
}