variable "names" {
  type = object({
    resource_group_name = string
    vnet_name           = string
    subnet_name         = string
    nop_nsg_name        = string
    db_nsg_name         = string
    public_ip_name      = string
    nic_name            = string
    linux_vm_name       = string
  })
  default = {
    resource_group_name = "nop-rg"
    vnet_name           = "nopvnet"
    subnet_name         = "nopsubnet"
    nop_nsg_name        = "nopnsg"
    db_nsg_name         = "dbnsg"
    public_ip_name      = "nopvmpubip"
    nic_name            = "nopnic"
    linux_vm_name       = "nopVM1"
  }
}

variable "rglocation" {
  type    = string
  default = "eastus"
}

variable "env" {
  type    = string
  default = "Dev"
}

variable "address_space" {
  type        = list(string)
  default     = ["10.0.0.0/16"]
  description = "list of vnet adresses"
}

variable "subnet_names" {
  type    = list(string)
  default = ["nop", "db"]
}

variable "subnet_index" {
  type    = number
  default = 0
}

variable "vm_details" {
  type = object({
    vm_size        = string
    admin_username = string
    admin_password = string
    publisher      = string
    offer          = string
    sku            = string
    version        = string

  })
  default = {
    vm_size        = "Standard_B1s"
    admin_username = "azureuser"
    admin_password = "Qazwsx12345678"
    publisher      = "Canonical"
    offer          = "0001-com-ubuntu-server-focal"
    sku            = "20_04-lts"
    version        = "latest"
  }
}

variable "db_details" {
  type = object({
    mysqldb_srvr_name              = string
    mysql_srvr_administrator_login = string
    mysql_srvr_administrator_pwd   = string
    mysql_sku_name                 = string
    mysql_storage_mb               = number
    mysql_version                  = string
    mysql_db_name                  = string
  })
  default = {
    mysqldb_srvr_name              = "nopcommercedbserver"
    mysql_srvr_administrator_login = "qtdevops"
    mysql_srvr_administrator_pwd   = "qt@devops0987"
    mysql_sku_name                 = "GP_Gen5_2"
    mysql_storage_mb               = 5120
    mysql_version                  = "5.7"
    mysql_db_name                  = "nopcommercemysqldb1"
  }
}
