# Here we define all the required provides for the modules 
terraform {
  required_providers {
    # We use offical helm provider of hashicorp for modules like ArgoCD bootstrap and metallb with specific version contraint.
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2"
    }
    # We use this ArgoCD provider to deploy the remaining modules.
    argocd = {
      source  = "oboukili/argocd"
      version = "~> 4"
    }
    keycloak = {
      source  = "mrparkers/keycloak"
      version = "~> 4"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}
