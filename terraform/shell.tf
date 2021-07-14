module "update_kubeconfig" {
  source     = "./modules/shell"
  command    = "aws eks update-kubeconfig --name ${var.eks_cluster_name} --region ${var.region}"
  depends_on = [module.eks]
}

module "install_all" {
  source     = "./modules/shell"
  command    = "cd ../manifests && sh install.sh"
  depends_on = [module.update_kubeconfig]
}
