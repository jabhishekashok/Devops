variable "names" {
  type = object({
    resource_group_name = string
    vnet_name           = string
    subnet_name         = string
    nsg_name            = string
    public_ip_name      = string
    nic_name            = string
    linux_vm_name       = string
  })
  default = {
    resource_group_name = "test-rg"
    vnet_name           = "testvnet"
    subnet_name         = "testsubnet"
    nsg_name            = "testnsg"
    public_ip_name      = "testvmpubip"
    nic_name            = "testnic"
    linux_vm_name       = "testVM1"
  }
}

variable "rglocation" {
  type    = string
  default = "eastus"
}

variable "env" {
  type    = string
  default = "Prod"
}

variable "address_space" {
  type        = list(string)
  default     = ["10.0.0.0/16"]
  description = "list of vnet adresses"
}

variable "subnet_names" {
  type    = list(string)
  default = ["web",]
}

variable "subnet_index" {
  type    = number
  default = 1
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
    admin_username = "Dell"
    admin_password = "Qazwsx12345678"
    publisher      = "Canonical"
    offer          = "0001-com-ubuntu-server-focal"
    sku            = "20_04-lts"
    version        = "latest"
  }
}

variable "rollout" {
  type = string
  default = "0.0.0"
}

