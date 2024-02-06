terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.70.0,<=3.80.0" #">= 2.79.1,<=2.80.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = $RGname "LUXRGM_TFStateFiles" 
    storage_account_name = "luxrgmtfstatefilestorage"
    container_name       = "lux-rgm-tf-statefiles"
    key                  = "LuxRGMTerraformState"
  }
}

provider "azurerm" {
  features {}

  client_id       = "66df9c79-cb3c-4877-977b-1e00e57ea07e"
  client_secret   = var.client_secret
  tenant_id       = "df7fa6cf-2f69-491d-bacd-8caa90484c7b"
  subscription_id = "77936c3d-6fe1-49f4-9127-015379a555e3"
}
