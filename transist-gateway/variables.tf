variable "vpc_cidr_list" {
  type = map(object({
    cidr_block = string,
    vpc_name   = string
  }))
  default = {
    vpc-a = {
      cidr_block = "10.10.0.0/16"
      vpc_name   = "vpc_a"
    }
    vpc-b = {
      cidr_block = "10.11.0.0/16"
      vpc_name   = "vpc_b"
    }
    vpc-c = {
      cidr_block = "10.12.0.0/16"
      vpc_name   = "vpc_c"
    }
    vpc-d = {
      cidr_block = "10.13.0.0/16"
      vpc_name   = "vpc_d"
    }
  }
}

variable "subnet_list" {
  type = map(object({
    cidr_block        = string,
    vpc_name          = string,
    availability_zone = string,
    subnet_name       = string

  }))
  default = {
    subnet_a = {
      cidr_block        = "10.10.1.0/24",
      vpc_name          = "vpc-a",
      availability_zone = "ap-southeast-1a",
      subnet_name       = "private_subnet_vpc_a"
    },
    subnet_b = {
      cidr_block        = "10.11.1.0/24",
      vpc_name          = "vpc-b",
      availability_zone = "ap-southeast-1a",
      subnet_name       = "private_subnet_vpc_b"
    },
    subnet_c = {
      cidr_block        = "10.12.1.0/24",
      vpc_name          = "vpc-c",
      availability_zone = "ap-southeast-1a",
      subnet_name       = "private_subnet_vpc_c"
    },
    subnet_d_public = {
      cidr_block        = "10.13.1.0/24",
      vpc_name          = "vpc-d",
      availability_zone = "ap-southeast-1a",
      subnet_name       = "public_subnet_vpc_d"
  },
   subnet_d_private = {
      cidr_block        = "10.13.2.0/24",
      vpc_name          = "vpc-d",
      availability_zone = "ap-southeast-1a",
      subnet_name       = "private_subnet_vpc_d"
  } }
}

variable "sg_list" {
  type = map(object({
    sg_name         = string,
    vpc_name        = string,
    cidr_block_list = set(string)
  }))
  default = {
    sg_a = {
      sg_name         = "sg_allow_ssh_vpc_a",
      vpc_name        = "vpc-a",
      cidr_block_list = ["10.10.0.0/16", "10.11.0.0/16", "10.12.0.0/16", "10.13.0.0/16"]
    },
    sg_b = {
      sg_name         = "sg_allow_ssh_vpc_b",
      vpc_name        = "vpc-b",
      cidr_block_list = ["10.10.0.0/16", "10.11.0.0/16", "10.12.0.0/16", "10.13.0.0/16"]
    },
    sg_c = {
      sg_name         = "sg_allow_ssh_vpc_c",
      vpc_name        = "vpc-c",
      cidr_block_list = ["10.10.0.0/16", "10.11.0.0/16", "10.12.0.0/16", "10.13.0.0/16"]
    },
    sg_d = {
      sg_name         = "sg_allow_ssh_vpc_d",
      vpc_name        = "vpc-d"
      cidr_block_list = ["0.0.0.0/0"]
    }
  }
}

variable "instance_list" {
  type = map(object({
    instance_name = string,
    subnet_name   = string,
    sg_name       = string,
    public_access = bool
  }))
  default = {
    "instance_a" = {
      instance_name = "instance_a",
      subnet_name   = "subnet_a",
      sg_name       = "sg_a"
      public_access = false

    },
    "instance_b" = {
      instance_name = "instance_b",
      subnet_name   = "subnet_b",
      sg_name       = "sg_b"
      public_access = false

    },
    "instance_c" = {
      instance_name = "instance_c",
      subnet_name   = "subnet_c",
      sg_name       = "sg_c"
      public_access = false

    },
    "instance_d" = {
      instance_name = "instance_d",
      subnet_name   = "subnet_d_public",
      sg_name       = "sg_d"
      public_access = true

    }
  }

}
