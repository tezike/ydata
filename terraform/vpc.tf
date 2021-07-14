resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.66.0"

  name                 = "${local.project_name}-vpc"
  cidr                 = var.vpc_subnet_cidr
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = var.private_subnet_cidr
  public_subnets       = var.public_subnet_cidr
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    Name                                            = "${var.eks_cluster_name}-vpc"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }

  public_subnet_tags = {
    Name                                            = "${var.eks_cluster_name}-eks-public"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/role/elb"                        = "1"
  }

  private_subnet_tags = {
    Name                                            = "${var.eks_cluster_name}-eks-private"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"               = "1"
  }
}
