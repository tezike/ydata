resource "helm_release" "ingress" {
  name       = "ingress"
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"

  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }
  set {
    name  = "controller.service.externalTrafficPolicy"
    value = "Cluster"
  }
}

data "kubernetes_service" "service_ingress" {
  metadata {
    name      = "ingress-ingress-nginx-controller"
    namespace = "default"
  }

  depends_on = [helm_release.ingress]
}

output "NginxLoadBalancerIP" {
  value = data.kubernetes_service.service_ingress.status.0.load_balancer.0.ingress.0.hostname
}