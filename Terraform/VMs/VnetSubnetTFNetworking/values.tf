variable "rglocation" {
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

variable "vnetlocations" {
  type = object({
    primary   = string
    secondary = string
  })
  default = {
    primary   = "southindia"
    secondary = "westindia"
  }
}

variable "vnetnames" {
  type = object({
    primary   = string
    secondary = string
  })
  default = {
    primary   = "ntier-primary"
    secondary = "ntier-secondary"
  }

}
variable "names" {
  type = object({
    env_name             = string
    resource_group_name  = string
    virtual_network_name = string
    test_vm_name         = string
    test_vm_nic_name     = string
    nsg_primary = string
    nsg_secondary = string
    secruleprimary = string
    secrulesecondary = string

  })
  default = {
    env_name             = "Dev"
    resource_group_name  = "test-rg"
    test_vm_name         = "test-vm"
    test_vm_nic_name     = "test-nic"
    nsg_primary = "nsg-primary"
    nsg_secondary = "nsg-secondary"
    secruleprimary = "security-primary"
    secruleprimary = "security-secondary"
  }
}