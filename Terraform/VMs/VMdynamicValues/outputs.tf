output "vm-pub-ip" {
  value = "http://${azurerm_linux_virtual_machine.testvm2.public_ip_address}"
}