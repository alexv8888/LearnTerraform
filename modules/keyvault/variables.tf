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

