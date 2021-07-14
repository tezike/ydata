variable "eks_k8s_version" {
  type    = string
  default = "1.20"
}

variable "eks_cluster_name" {
  default = "ydata_cluster"
  type    = string
}

variable "eks_instance_type" {
  default = "m5.xlarge"
  type    = string
}


variable "eks_min_scale" {
  default = 1
}

variable "eks_desired_scale" {
  default = 2
}

variable "eks_max_scale" {
  default = 5
}