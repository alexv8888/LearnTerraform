#Common variables

variable "location" {
}

variable "environment" {
}

#NSG variables

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

#Virtual network variables

variable "vnetname" {
}

variable "address_space" {
  type = list(string)
}

variable "address_pref_publ" {
  type = list(string)
}

variable "address_pref_priv" {
  type = list(string)
}

#VM variables

variable "vm_size" {
}

variable "storage_account_type" {
}

variable "source_image_sku" {
}