module "vpc" {

  source = "terraform-aws-modules/vpc/aws"

  name   = "${var.app_name}_vpc"
  cidr   = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = var.vpc_enable_nat_gateway
  enable_vpn_gateway = true
  single_nat_gateway = true
  tags = var.vpc_tags

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/vcc-eks-tf" = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/vcc-eks-tf" = "shared"
  }
}