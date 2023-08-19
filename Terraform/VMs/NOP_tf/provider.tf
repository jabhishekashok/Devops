terraform {
  backend "azurerm" {
    resource_group_name  = "selfhosted"
    storage_account_name = "terraformstorageabhi1"
    container_name       = "terraformstatefiles1"
    key                  = "terraformVMSshAuth.tfstate"
  }
}
provider "azurerm" {
  features {}
}

