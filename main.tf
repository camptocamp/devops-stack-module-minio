locals {
  cluster_name = "tpi"
}

module "kind" {
  source = "git::https://github.com/camptocamp/devops-stack-module-cluster-kind.git?ref=v2.1.0"

  cluster_name       = local.cluster_name
  kubernetes_version = "v1.24.7"
}
