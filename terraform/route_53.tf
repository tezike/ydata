locals {
  # https://github.com/hashicorp/terraform-provider-kubernetes/issues/942#issuecomment-731516100

  # "a0ccf7496f46842639b2d0f8c98adfdb-83188769.us-east-1.elb.amazonaws.com"
  lb_name_parts = split("-", split(".", data.kubernetes_service.service_ingress.status.0.load_balancer.0.ingress.0.hostname).0)
}

# https://www.reddit.com/r/aws/comments/o7oqr0/how_do_i_get_the_domain_name_of_the_load_balancer/
#'[a0ccf7496f46842639b2d0f8c98adfdb]'
# data "aws_lb" "lb" {
#     # name = regex(
#     #       "(^[^-]+)",
#     #       data.kubernetes_service.service_ingress.status[0].load_balancer[0].ingress[0].hostname
#     #     )[0]
#     # name =  "a82455920c5c847659c8e9d216b301c9"
# }


resource "aws_route53_zone" "ydata_kubeflow" {
  name = "ydata.ml"
}

resource "aws_route53_record" "ydata_www" {
  allow_overwrite = true
  name            = "kubeflow.ydata.ml"
  type            = "A"
  zone_id         = aws_route53_zone.ydata_kubeflow.zone_id

  alias {
    name = data.kubernetes_service.service_ingress.status.0.load_balancer.0.ingress.0.hostname
    # [TODO]: Figure out how to make this dynamic
    # zone_id                = "${data.aws_lb.lb.zone_id}" # LB zone
    zone_id                = "Z35SXDOTRQ7X7K" # LB zone
    evaluate_target_health = false
  }
}

output "name_servers" {
  value = aws_route53_zone.ydata_kubeflow.name_servers
}