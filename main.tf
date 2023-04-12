# In this file we call the modules of our use case of DevOps Stack.
# locals are used to define comman variables for external use.
locals {
  cluster_name = "tpi"
}

# Module KinD with cluster name and version
module "kind" {
  source = "git::https://github.com/camptocamp/devops-stack-module-cluster-kind.git?ref=v2.1.0"

  cluster_name       = local.cluster_name
  kubernetes_version = "v1.24.7"
}

# Usage of helm provider with cluster access credientials
provider "helm" {
  kubernetes {
    host               = module.kind.parsed_kubeconfig.host
    client_certificate = module.kind.parsed_kubeconfig.client_certificate
    client_key         = module.kind.parsed_kubeconfig.client_key
    insecure           = true
  }
}

# metallb module is used to have a service type loadbalancer for the cluster KinD
module "metallb" {
  source = "git::https://github.com/camptocamp/devops-stack-module-metallb.git?ref=v1.0.1"

  subnet = module.kind.kind_subnet
}
