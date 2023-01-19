#Common variables
location    = "eastus"
environment = "PROD"

# NSG variables. In this NSG we allow inbound SSH and RDP and deny all outbound internet traffic except AzureMonitor services
allowed_protocols_list = [{
  name                       = "Allow_SSH"
  priority                   = 100
  access                     = "Allow"
  direction                  = "Inbound"
  destination_port_range     = "22"
  destination_address_prefix = "*"
  },
  {
    name                       = "Allow_RDP"
    priority                   = 200
    access                     = "Allow"
    direction                  = "Inbound"
    destination_port_range     = "3389"
    destination_address_prefix = "*"
  },
  {
    name                       = "Allow_Monitor"
    priority                   = 100
    access                     = "Allow"
    direction                  = "Outbound"
    destination_port_range     = "443"
    destination_address_prefix = "AzureMonitor"
  },
  {
    name                       = "Deny_Internet"
    priority                   = 200
    access                     = "Deny"
    direction                  = "Outbound"
    destination_port_range     = "0-65535"
    destination_address_prefix = "Internet"
  }
]

#Virtual network variables

vnetname          = "LearnTerraformVNet"
address_space     = ["192.168.30.0/24"]
address_pref_publ = ["192.168.30.0/25"]
address_pref_priv = ["192.168.30.128/25"]

#VM variables
vm_size              = "Standard_B1ls"
storage_account_type = "Standard_LRS"
source_image_sku     = "18.04-LTS"
