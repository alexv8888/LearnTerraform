output "PrivateServerIP" {
  value = azurerm_linux_virtual_machine.UbuntuServer.private_ip_address
}

output "PublicServerIP" {
  value = azurerm_linux_virtual_machine.UbuntuServer.public_ip_address
}

