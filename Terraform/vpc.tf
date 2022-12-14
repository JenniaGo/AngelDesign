provider "aws" {
  region = "eu-west-2"
  shared_config_files      = ["/Users/tf_user/.aws/conf"]
  shared_credentials_files = ["/Users/tf_user/.aws/creds"]
  profile                  = "AngelDesign"
}

variable vpc_cidr_block {}
variable private_subnet_cidr_blocks {}
variable public_subnet_cidr_blocks {}

data "aws_availability_zones" "azs" {}

module "AngelDesign-vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"
  
  name = "AngelDesign-vpc"
  cidr = var.vpc_cidr_block
  private_subnets = var.private_subnet_cidr_blocks
  public_subnets = var.public_subnet_cidr_blocks
  azs = data.aws_availability_zones.azs.names

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/angeldesign-eks-cluster" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/angeldesign-eks-cluster" = "shared"
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/angeldesign-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}
