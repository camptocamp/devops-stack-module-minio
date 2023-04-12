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

# Kubernetes provider with need access to the cluster.
provider "kubernetes" {
  host               = module.kind.parsed_kubeconfig.host
  client_certificate = module.kind.parsed_kubeconfig.client_certificate
  client_key         = module.kind.parsed_kubeconfig.client_key
  insecure           = true
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

# This module is used to install ArgoCD using helm provider(helm-release chart)
module "argocd_bootstrap" {
  source = "git::https://github.com/camptocamp/devops-stack-module-argocd.git//bootstrap?ref=v1.0.0"
}

# Calling ArgoCD provider with required access to the cluster.
provider "argocd" {
  server_addr                 = "127.0.0.1:8080"
  auth_token                  = module.argocd_bootstrap.argocd_auth_token
  insecure                    = true
  plain_text                  = true
  port_forward                = true
  port_forward_with_namespace = module.argocd_bootstrap.argocd_namespace
  kubernetes {
    host                   = module.kind.parsed_kubeconfig.host
    client_certificate     = module.kind.parsed_kubeconfig.client_certificate
    client_key             = module.kind.parsed_kubeconfig.client_key
    cluster_ca_certificate = module.kind.parsed_kubeconfig.cluster_ca_certificate
  }
}

# We use Traefik that acts like ingress controler inside the cluster.
module "ingress" {
  source = "git::https://github.com/camptocamp/devops-stack-module-traefik.git//kind?ref=v1.0.0"

  cluster_name = local.cluster_name

  base_domain = "something.com"

  argocd_namespace = module.argocd_bootstrap.argocd_namespace
}

