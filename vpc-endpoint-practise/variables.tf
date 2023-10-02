variable "vpc_cidr_block" {
    type = string
    default = "10.11.0.0/16"
  
}

variable "private_subnet_cidr" {
    type = string
    default = "10.11.1.0/24"
  
}

variable "private_subnet_az" {
    type = string
    default = "ap-southeast-1a"
  
}

variable "instance_key_name" {
    type = string
    default = "knt-mac-key"
  
}