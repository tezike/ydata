module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.eks_cluster_name
  cluster_version = var.eks_k8s_version
  subnets         = module.vpc.private_subnets

  tags = {
    managed-by = "terraform"
  }

  vpc_id = module.vpc.vpc_id

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  worker_groups = [
    {
      name                          = "worker-1"
      instance_type                 = var.eks_instance_type
      asg_desired_capacity          = var.eks_desired_scale
      asg_max_size                  = var.eks_max_scale
      asg_min_size                  = var.eks_min_scale
      autoscaling_enabled           = true
      additional_security_group_ids = [aws_security_group.worker_one.id]
    }
  ]
}