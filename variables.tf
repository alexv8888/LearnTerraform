variable "vnetname" {
}
variable "location" {
}

variable "environment" {
}

variable "allowed_protocols_list" {
  type = list(object({
    name                       = string
    priority                   = number
    access                     = string
    direction                  = string
    destination_port_range     = string
    destination_address_prefix = string

  }))
}

variable "address_space" {
  type = list(string)
}

variable "address_pref" {
  type = list(string)
}

variable "vm_size" {
}

variable "storage_account_type" {
}

variable "source_image_sku" {
}