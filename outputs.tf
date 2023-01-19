output "UbuntuServer-Front_IP-address1" {
  value = azurerm_linux_virtual_machine.ubuntuserver-front.private_ip_address
}

output "UbuntuServer-Front_IP-address2" {
  value = azurerm_linux_virtual_machine.ubuntuserver-front.public_ip_address
}

output "UbuntuServer-Back_IP-address" {
  value = azurerm_linux_virtual_machine.ubuntuserver-back.private_ip_address
}