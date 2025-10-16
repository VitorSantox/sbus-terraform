variable "azurerm_virtual_network_name" {
    description = "Nome da network"
    type = string
}

variable "azurerm_subnet_name" {
  description = "subnet name"
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

# NOVAS VARIÁVEIS PARA OS ENDEREÇOS IP
variable "vnet_address_space" {
  description = "Lista de CIDRs para a VNet (ex: [\"10.0.0.0/16\"])"
  type        = list(string)
}

variable "subnet_address_prefixes" {
  description = "Lista de CIDRs para a Subnet (ex: [\"10.0.2.0/24\"])"
  type        = list(string)
}