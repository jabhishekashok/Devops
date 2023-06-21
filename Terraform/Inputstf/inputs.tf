variable "location" {
  type        = string
  default     = "eastus"
  description = "location of the resource group"

}

variable "vnet-range" {
  type        = list(string)
  default     = ["10.0.0.0/24"]
  description = "cidr range of vnet"
}