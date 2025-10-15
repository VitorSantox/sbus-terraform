resource "azurerm_public_ip" "vm_pip" {
  # Usamos o nome da VM para garantir que o IP Público seja único
  name                = "${var.azurerm_linux_virtual_machine_name}-pip" 
  location            = var.target_resource_group_location
  resource_group_name = var.target_resource_group_name
  allocation_method   = "Dynamic" # Dynamic é suficiente para o lab
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.azurerm_linux_virtual_machine_name}-nic"
  location            = var.target_resource_group_location
  resource_group_name = var.target_resource_group_name
  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.target_subnet_id
    private_ip_address_allocation = "Dynamic"

    # Linha Adicionada para ASSOCIAR o IP Público à NIC
    public_ip_address_id          = azurerm_public_ip.vm_pip.id 
  }
}

resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.azurerm_linux_virtual_machine_name}-nsg"
  location            = var.target_resource_group_location
  resource_group_name = var.target_resource_group_name

  # Regra para permitir SSH (porta 22)
  security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "Internet" # Permite acesso de qualquer IP (Para o lab)
    destination_address_prefix = "*"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.azurerm_linux_virtual_machine_name
  resource_group_name = var.target_resource_group_name
  location            = var.target_resource_group_location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}