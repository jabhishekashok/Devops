terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.61.0"
    }
    aws = {
      source  = "hashicorp/aws"
      source  = "hashicorp/aws"
      version = "4.60.0"
    }
  }
  required_version = "> 1.0.0"
  backend "s3" {
    bucket         = "terraformremotebackendabhi"
    key            = "classes/hellotf"
    dynamodb_table = "terraformlock"
    region         = "ap-south-1"

  }

}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
  tags = {
    env = var.env
  }
}


