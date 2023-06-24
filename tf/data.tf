data "aws_eks_cluster" "default" {
  name = "${var.app_name}_cluster"
}

data "aws_eks_cluster_auth" "default" {
  name = "${var.app_name}_cluster"
}