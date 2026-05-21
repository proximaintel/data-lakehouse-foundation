variable "location" {
  type    = string
  default = "eastus2"
}

variable "environment" {
  type    = string
  default = "prod"
}

variable "workspace_name" {
  type    = string
  default = "dbw-lakehouse"
}

variable "vnet_cidr" {
  type    = string
  default = "10.20.0.0/16"
}

variable "tags" {
  type = map(string)
  default = {
    managed-by = "terraform"
    project    = "data-lakehouse"
  }
}
