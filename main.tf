# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
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

#Create Resource Group
resource "azurerm_resource_group" "rgfirst" {
  name     = "rg-mric-tf-001"  # var.resource_group -- will be environment variable
  location = var.location
}
