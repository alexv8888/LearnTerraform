variable "location" {
  type = string
  
}
variable "rgname" {
  type = string
}

variable "vnetname" {
  type = string
}
variable "environment" {
  type = string
}

variable "address_space" {
  type = list(string)
  
}

variable "address_pref" {
  type = list(string)
  
}