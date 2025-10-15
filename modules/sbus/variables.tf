variable "namespace_name" {
  description = "Nome do Service Bus Namespace"
  type        = string
}

variable "target_resource_group_name" {
  description = "Nome do Resource Group onde o Service Bus será criado"
  type        = string
}

variable "target_resource_group_location" {
  description = "localização do resource group"
  type        = string
}