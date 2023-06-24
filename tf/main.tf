provider "aws" {
    region = var.region
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.default.token
}

terraform {
  backend "s3" {
    bucket = "pin-votting-tfstate"
    region = "us-east-1"
    encrypt = true
    key = "pin/deploy.tfstate"
  }
}