terraform {
  required_providers {
    # Definimos que o Azure Provider é obrigatório
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  # A versão do Terraform que estamos usando
  required_version = ">= 1.0"
}

# Configuração básica do Provedor Azure
provider "azurerm" {
  features {}
  # O Terraform usará as credenciais disponíveis no Cloud Shell ou bash(Service Principal/MSI)
}