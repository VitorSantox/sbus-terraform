variable "project_name" {
    description = "nome do projeto que será também o nome do RG"
    type = string
}

variable "location" {
    description = "localização do Resource Group"
    type = string  
}

variable "sbus_namespace_name" {
    description = "nome do service bus"
    type = string
}

variable "azurerm_network_interface_name" {
    description = "network interface name"
    type = string  
}

variable "azurerm_subnet_name" {
    description = "subnet name"
    type = string
}

variable "azurerm_virtual_network_name" {
  description = "nome da network"
  type = string
}
