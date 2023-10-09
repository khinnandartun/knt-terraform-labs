variable "vpc_cidr" {
  type    = string
  default = "10.17.0.0/16"
}

variable "vpc_az1" {
  type    = string
  default = "ap-southeast-1a"
}
variable "vpc_az2" {
  type    = string
  default = "ap-southeast-1b"
}
variable "vpc_az3" {
  type    = string
  default = "ap-southeast-1c"
}

variable "vpc_az1_private_cidr" {
  type    = string
  default = "10.17.1.0/24"
}

variable "vpc_az2_private_cidr" {
  type    = string
  default = "10.17.2.0/24"
}

variable "vpc_az3_private_cidr" {
  type    = string
  default = "10.17.3.0/24"
}

variable "vpc_az1_public_cidr" {
  type    = string
  default = "10.17.11.0/24"
}

variable "vpc_az2_public_cidr" {
  type    = string
  default = "10.17.12.0/24"
}

variable "vpc_az3_public_cidr" {
  type    = string
  default = "10.17.13.0/24"
}

variable "eks_managed_node_instance_type" {
  type    = set(string)
  default = ["t2.small"]

}

variable "eks_auth_roles" {
  type = list(object({
    rolearn  = string,
    username = string,
    groups   = list(string)
  }))

  default = [{
    rolearn  = "arn:aws:iam::926233248796:role/aws-service-role/eks.amazonaws.com/AWSServiceRoleForAmazonEKS"
    username = "khinnandartun"
    groups   = ["system:masters"]
  }]

}

variable "eks_auth_users" {
  type = list(object({
    userarn  = string,
    username = string,
    groups   = list(string)
  }))

  default = [{
    userarn  = "arn:aws:iam::926233248796:user/khinnandartun"
    username = "khinnandartun"
    groups   = ["system:masters"]
  }]

}

variable "eks_auth_account" {
  type    = set(string)
  default = ["926233248796"]

}