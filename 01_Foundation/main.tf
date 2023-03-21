terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-mgmt-terraform"
    storage_account_name = "stmgmttfdev001"
    container_name       = "tfcontain"
    key                  = "tfcontain.tfstate"
  }
}

provider "azurerm" {
  features {}
}
