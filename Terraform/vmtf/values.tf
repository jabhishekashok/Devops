variable "location" {
  type        = string
  default     = "eastus"
  description = "location of the resource group"
}

variable "address_space" {
  type        = list(string)
  default     = ["10.0.0.0/16"]
  description = "list of vnet adresses"
}

variable "subnet_names" {
  type    = list(string)
  default = ["web", "app", "db"]
}

variable "subnet_index" {
  type    = number
  default = 1
}

variable "names" {
  type = object({
    env_name             = string
    resource_group_name  = string
    virtual_network_name = string
    mssql_server_name    = string
    mssql_database_name  = string
    test_vm_name         = string
    test_vm_nic_name     = string

  })
  default = {
    env_name             = "Dev"
    resource_group_name  = "test-rg"
    virtual_network_name = "testvnet"
    mssql_server_name    = "qtntier-db"
    mssql_database_name  = "qtdevops"
    test_vm_name         = "test-vm"
    test_vm_nic_name     = "test-nic"
  }
}


