provider "azurerm" {
  features {
    
  }
}

module "VM_pubIp" {
  source       = "./Modules/VM_PublicIp"
  rglocation   = "westus"
  env          = "Dev"
  subnet_names = ["web", "app", "data"]
}

output "vm-pub-ip" {
  value = "http://${module.VM_pubIp.vm-pub-ip}"
}