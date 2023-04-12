# In this file we call the modules of our use case of DevOps Stack.
# locals are used to define comman variables for external use.
locals {
  cluster_name   = "tpi"
  cluster_issuer = "ca-issuer"
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

# We use this module to manage cerificates for depoyed services inside the cluster
module "cert-manager" {
  source = "git::https://github.com/camptocamp/devops-stack-module-cert-manager.git//self-signed?ref=v1.0.1"

  cluster_name     = local.cluster_name
  base_domain      = format("%s.nip.io", replace(module.ingress.external_ip, ".", "-"))
  argocd_namespace = module.argocd_bootstrap.argocd_namespace
}

# We use keycloak modules for user authentication for example to access ArgoCD, grafana, alertmanager and prometheus
module "oidc" {
  source = "git::https://github.com/camptocamp/devops-stack-module-keycloak?ref=v1.0.2"

  cluster_name     = local.cluster_name
  base_domain      = format("%s.nip.io", replace(module.ingress.external_ip, ".", "-"))
  cluster_issuer   = local.cluster_issuer
  argocd_namespace = module.argocd_bootstrap.argocd_namespace

  dependency_ids = {
    traefik      = module.ingress.id
    cert-manager = module.cert-manager.id
  }
}

# Keykloak provder with specifed access
provider "keycloak" {
  client_id                = "admin-cli"
  username                 = module.oidc.admin_credentials.username
  password                 = module.oidc.admin_credentials.password
  url                      = "https://keycloak.apps.${local.cluster_name}.${format("%s.nip.io", replace(module.ingress.external_ip, ".", "-"))}"
  tls_insecure_skip_verify = true
}

# odic_bootstrap with its dependencies
module "oidc_bootstrap" {
  source = "git::https://github.com/camptocamp/devops-stack-module-keycloak//oidc_bootstrap?ref=v1.0.2"

  cluster_name   = local.cluster_name
  base_domain    = format("%s.nip.io", replace(module.ingress.external_ip, ".", "-"))
  cluster_issuer = local.cluster_issuer

  dependency_ids = {
    oidc = module.oidc.id
  }
}

# Kube-prometheus-stack module that includes prometheus, grafana and Alertmanager
module "prometheus-stack" {
  source = "git::https://github.com/camptocamp/devops-stack-module-kube-prometheus-stack//kind?ref=v1.0.0"

  cluster_name     = local.cluster_name
  argocd_namespace = module.argocd_bootstrap.argocd_namespace
  base_domain      = format("%s.nip.io", replace(module.ingress.external_ip, ".", "-"))
  cluster_issuer   = local.cluster_issuer

  prometheus = {
    oidc = module.oidc_bootstrap.oidc
  }
  alertmanager = {
    oidc = module.oidc_bootstrap.oidc
  }
  grafana = {
    enabled                 = true
    oidc                    = module.oidc_bootstrap.oidc
    additional_data_sources = true
  }

  helm_values = [{
    kube-prometheus-stack = {
      grafana = {
        extraSecretMounts = [
          {
            name       = "ca-certificate"
            secretName = "grafana-tls"
            mountPath  = "/etc/ssl/certs/ca.crt"
            readOnly   = true
            subPath    = "ca.crt"
          },
        ]
      }
    }
  }]

  dependency_ids = {
    keycloak     = module.oidc.id
    cert-manager = module.cert-manager.id
  }
}





