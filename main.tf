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
  name     = var.RESOURCE_GROUP_NAME
  location = var.location
}

resource "azurerm_sql_server" "sqlserver" {
  name                         = var.SQL_SERVER_NAME
  resource_group_name          = azurerm_resource_group.rgfirst.name
  location                     = azurerm_resource_group.rgfirst.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
}

resource "azurerm_sql_database" "sqldb" {
  name                             = var.SQL_DB_NAME
  resource_group_name              = azurerm_resource_group.rgfirst.name
  location                         = azurerm_resource_group.rgfirst.location
  server_name                      = azurerm_sql_server.sqlserver.name
  edition                          = "Basic"
  collation                        = "SQL_Latin1_General_CP1_CI_AS"
  create_mode                      = "Default"
  requested_service_objective_name = "Basic"
}

# Enables the "Allow Access to Azure services" box as described in the API docs
# https://docs.microsoft.com/en-us/rest/api/sql/firewallrules/createorupdate
resource "azurerm_sql_firewall_rule" "example" {
  name                = "allow-azure-services"
  resource_group_name = azurerm_resource_group.rgfirst.name
  server_name         = azurerm_sql_server.sqlserver.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}
