location    = "eastus"
environment = "QA"
allowed_protocols_list = [{
  name                   = "AllowSSH"
  priority               = 100
  destination_port_range = "22"

  },
  {
    name                   = "AllowRDP"
    priority               = 200
    destination_port_range = "3389"
  }
]
address_space        = ["192.168.29.0/24"]
address_pref         = ["192.168.29.0/25"]
vm_size              = "Standard_B1ls"
storage_account_type = "Standard_LRS"
source_image_sku     = "18.04-LTS"