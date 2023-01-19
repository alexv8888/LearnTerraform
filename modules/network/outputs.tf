output "public_subnet_id" {
  value = azurerm_subnet.PublicSubnet.id
}

output "private_subnet_id" {
  value = azurerm_subnet.PrivateSubnet.id
}