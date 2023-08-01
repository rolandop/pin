
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "${var.app_name}-cluster"
  cluster_version = "1.27"

  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   =  module.vpc.vpc_id
  subnet_ids                = module.vpc.private_subnets
  

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = var.instance
    disk_size = 30
  }

  eks_managed_node_groups = {
    blue = {}
    green = {
      min_size     = 3
      max_size     = 10
      desired_size = 3

      instance_types = var.instance
      capacity_type  = "SPOT"
    }
  }

  
  # aws-auth configmap
  manage_aws_auth_configmap = true 

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
