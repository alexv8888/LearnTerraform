#Create a resource group for all resources

resource "azurerm_resource_group" "resource_group" {
  name     = "Learn_Terraform_RG-${var.environment}"
  location = var.location
}

#Create a public IP for a frontend host

resource "azurerm_public_ip" "public_ip" {
  name                = "Learn_Terraform_PublicIp-${var.environment}"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  allocation_method   = "Static"

  tags = {
    environment = var.environment
  }
}

#Create virtual network and one subnet

module "vnet" {
  source        = "./modules/network"
  location      = var.location
  rgname        = azurerm_resource_group.resource_group.name
  vnetname      = "Learn_Terraform_VNet-${var.environment}"
  environment   = var.environment
  address_space = var.address_space
  address_pref_priv  = var.address_pref_priv
  address_pref_publ  = var.address_pref_publ
}

# Create a network security group and associate it with the subnet from the previous step

resource "azurerm_network_security_group" "nsg" {
  name                = "Learn_Terraform_SecurityGroup-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  dynamic "security_rule" {
    for_each = var.allowed_protocols_list
    content {
      name                       = security_rule.value["name"]
      priority                   = security_rule.value["priority"]
      direction                  = security_rule.value["direction"]
      access                     = security_rule.value["access"]
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value["destination_port_range"]
      source_address_prefix      = "*"
      destination_address_prefix = security_rule.value["destination_address_prefix"]
    }
  }

  tags = {
    environment = var.environment
  }
}


resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = module.vnet.public_subnet_id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Generate admin password for the both VMs and save it in the key vault

module "generate_pass" {
  source      = "./modules/keyvault"
  location    = var.location
  rgname      = azurerm_resource_group.resource_group.name
  environment = var.environment
}

#Create a NIC for the frontend VM

resource "azurerm_network_interface" "nic-front" {
  name                = "Learn_Terraform-FrontendNic-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.vnet.public_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }

  tags = {
    environment = var.environment
  }
}

#Create a frontend VM

resource "azurerm_linux_virtual_machine" "ubuntuserver-front" {
  name                            = "Learn_Terraform_FrontendVM-${var.environment}"
  resource_group_name             = azurerm_resource_group.resource_group.name
  location                        = var.location
  size                            = var.vm_size
  admin_username                  = "adminuser"
  admin_password                  = module.generate_pass.created_password
  disable_password_authentication = "false"
  computer_name                   = "FrontendVM-${var.environment}"
  network_interface_ids = [
    azurerm_network_interface.nic-front.id,
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

#Create a NIC for the backend VM

resource "azurerm_network_interface" "nic-back" {
  name                = "Learn_Terraform-BackendNic-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.vnet.private_subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = var.environment
  }
}

#Create a backend VM

resource "azurerm_linux_virtual_machine" "ubuntuserver-back" {
  name                            = "Learn_Terraform_BackendVM-${var.environment}"
  resource_group_name             = azurerm_resource_group.resource_group.name
  location                        = var.location
  size                            = var.vm_size
  admin_username                  = "adminuser"
  admin_password                  = module.generate_pass.created_password
  disable_password_authentication = "false"
  computer_name                   = "BackendVM-${var.environment}"
  network_interface_ids = [
    azurerm_network_interface.nic-back.id,
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