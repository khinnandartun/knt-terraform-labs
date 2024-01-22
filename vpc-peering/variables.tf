variable "vpc_cidr_block" {
  type    = string
  default = "10.10.0.0/16"
}
variable "public_subnet_1_cidr_block" {
  type    = string
  default = "10.10.1.0/24"
}
variable "public_subnet_2_cidr_block" {
  type    = string
  default = "10.10.2.0/24"
}

variable "private_subnet_cidr_block" {
  type    = string
  default = "10.10.4.0/24"
}

variable "isolated_private_subnet_cidr_block" {
  type    = string
  default = "10.10.3.0/24"
}

variable "different_vpc_cidr_block" {
  type    = string
  default = "10.11.0.0/16"
}

variable "differnet_private_subnet_cidr_block" {
  type    = string
  default = "10.11.1.0/24"
}