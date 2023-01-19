variable "location" {
  type = string
  description = "Location of the network"
}

variable "rgname" {
  type = string
  description = "A name of a resource group"
}

variable "environment" {
  type = string
  description = "Environment to deploy (QA, PROD)"
}

variable "vnetname" {
  type = string
  description = "Name of a virtual network"
}

variable "address_pref" {
  type = list(string)
  description = "Subnet ddress prefix"
}
variable "address_space" {
  type = list(string)
  description = "Network address spase"
}
