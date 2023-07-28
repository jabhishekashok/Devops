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