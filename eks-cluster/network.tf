module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"
  name    = "eks-vpc"
  cidr    = var.vpc_cidr

  azs             = [var.vpc_az1, var.vpc_az2, var.vpc_az3]
  private_subnets = [var.vpc_az1_private_cidr, var.vpc_az2_private_cidr, var.vpc_az3_private_cidr]
  public_subnets  = [var.vpc_az1_public_cidr, var.vpc_az2_public_cidr, var.vpc_az3_public_cidr]

  enable_nat_gateway = true
  enable_vpn_gateway = true
  single_nat_gateway = true

  tags = {
    eks-cluster = "true"
    Environment = "dev"
  }
}