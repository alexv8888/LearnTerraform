#Common variables
location    = "eastus"
environment = "QA"

#NSG variables

allowed_protocols_list = [{
  name                       = "AllowSSH"
  priority                   = 100
  destination_port_range     = "22"
  access                     = "Allow"
  direction                  = "Inbound"
  destination_address_prefix = "*"
  },
  {
    name                       = "AllowRDP"
    priority                   = 200
    destination_port_range     = "3389"
    access                     = "Allow"
    direction                  = "Inbound"
    destination_address_prefix = "*"
  }
]

#Virtual network variables
vnetname          = "LearnTerraformVNet"
address_space     = ["192.168.29.0/24"]
address_pref_publ = ["192.168.29.0/25"]
address_pref_priv = ["192.168.29.128/25"]

#VM variables
vm_size              = "Standard_B1ls"
storage_account_type = "Standard_LRS"
source_image_sku     = "18.04-LTS"