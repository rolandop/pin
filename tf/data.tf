data "aws_eks_cluster" "default" {
   name = "${var.app_name}-cluster"
   depends_on = [module.eks.cluster_name]
}

data "aws_eks_cluster_auth" "default" {
   name = "${var.app_name}-cluster"
   depends_on = [module.eks.cluster_name]
}
