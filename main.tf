module "resource-group" {
  source              = "./modules/resource-group"
  resource_group_name = var.project_name
  location            = var.location
}

module "network" {
  source = "./modules/network"

  #Novos inputs: nomes usando as variaveis raiz
  azurerm_virtual_network_name = var.azurerm_virtual_network_name
  azurerm_subnet_name          = var.azurerm_subnet_name

  # INPUTS (Conectando ao RG)
  target_resource_group_name     = module.resource-group.resource_group_name
  target_resource_group_location = module.resource-group.location

  # INPUTS (Endereçamento IP - Hardcoded aqui para simplicidade, mas pode vir do tfvars)
  vnet_address_space      = ["10.0.0.0/16"]
  subnet_address_prefixes = ["10.0.2.0/24"]

}

module "sbus" {
  source                         = "./modules/sbus"
  namespace_name                 = var.sbus_namespace_name
  target_resource_group_name     = module.resource-group.resource_group_name
  target_resource_group_location = module.resource-group.location
}

module "vm_produtor" {
  source = "./modules/linux-vm"

  #Inputs do RG
  target_resource_group_name     = module.resource-group.resource_group_name
  target_resource_group_location = module.resource-group.location

  #input output do network
  target_subnet_id = module.network.subnet_id

  #input nome da vm
  azurerm_linux_virtual_machine_name = "produtor-sbus-01"
}

module "vm_consumidor" {
  source = "./modules/linux-vm"

  #Inputs do RG
  target_resource_group_name     = module.resource-group.resource_group_name
  target_resource_group_location = module.resource-group.location

  #input output do network
  target_subnet_id = module.network.subnet_id

  #input nome da vm
  azurerm_linux_virtual_machine_name = "consumidor-sbus-01"
}