# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
# terraform {
#   backend "azurerm" {
#     resource_group_name  = "rg-terraform-state"
#     storage_account_name = "stamrictfstatesdev"
#     container_name       = "tfstate"
#     key                  = "dev.tfstate"
#   }
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "=3.0.0"
#     }
#   }
# }
 
provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

#Create Resource Group
resource "azurerm_resource_group" "rgfirst" {
  name     = var.resource_group_name
  location = var.location
}
