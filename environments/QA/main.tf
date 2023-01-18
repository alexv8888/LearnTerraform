resource "azurerm_resource_group" "resource_group" {
  name     = "Learn_Terraform_RG-${var.environment}"
  location = var.location
}

resource "azurerm_public_ip" "public_ip" {
  name                = "Learn_Terraform_PublicIp-${var.environment}"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  allocation_method   = "Static"

  tags = {
    environment = var.environment
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "Learn_Terraform_SecurityGroup-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  dynamic "security_rule" {
    for_each = var.allowed_protocols_list
    content {
      name                       = security_rule.value["name"]
      priority                   = security_rule.value["priority"]
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value["destination_port_range"]
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

  tags = {
    environment = var.environment
  }
}


resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = module.network.vnet_subnets[0]
  network_security_group_id = azurerm_network_security_group.nsg.id
}

#resource "azurerm_virtual_network" "virtual_network" {
#  name                = "Learn_Terraform_VNet-${var.environment}"
#  address_space       = var.address_space
#  location            = var.location
#  resource_group_name = azurerm_resource_group.resource_group.name
#}

#resource "azurerm_subnet" "subnet" {
#  name                 = "internal-${var.environment}"
#  resource_group_name  = azurerm_resource_group.resource_group.name
#  virtual_network_name = azurerm_virtual_network.virtual_network.name
#  address_prefixes     = var.address_pref
#}


module "network" {
  source              = "Azure/network/azurerm"
  version             = "5.0.0"
  resource_group_name = azurerm_resource_group.resource_group.name
  use_for_each        = true
  address_spaces      = var.address_space
  subnet_prefixes     = var.address_pref
  vnet_name           = "Learn_Terraform_VNet-${var.environment}"
  subnet_names        = ["internal-${var.environment}"]
  tags = {
    environment = var.environment
  }

  depends_on = [azurerm_resource_group.resource_group]
}

resource "azurerm_network_interface" "nic" {
  name                = "Learn_Terraform-nic-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.network.vnet_subnets[0]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_linux_virtual_machine" "UbuntuServer" {
  name                            = "Learn_Terraform_Server-${var.environment}"
  resource_group_name             = azurerm_resource_group.resource_group.name
  location                        = var.location
  size                            = var.vm_size
  admin_username                  = "adminuser"
  admin_password                  = azurerm_key_vault_secret.password.value
  disable_password_authentication = "false"
  computer_name                   = "host-${var.environment}"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = var.source_image_sku
    version   = "latest"
  }

}