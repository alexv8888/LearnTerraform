terraform {
  backend "azurerm" {
    resource_group_name  = "terraform_backend"
    storage_account_name = "backend2246"
    container_name       = "backend"
    key                  = "prod.terraform.tfstate"
  }
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.39.1"
    }
  }
}

provider "azurerm" {
  features {}
}