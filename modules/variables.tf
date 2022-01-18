#######################
## Standard variables
#######################

variable "cluster_name" {
  type = string
}

variable "base_domain" {
  type = string
}

variable "argocd_namespace" {
  type = string
}

variable "cluster_issuer" {
  type    = string
  default = "ca-issuer"
}

variable "namespace" {
  type    = string
  default = "minio"
}

variable "profiles" {
  type    = list(string)
  default = ["default"]
}

#######################
## Module variables
#######################

variable "minio" {
  type = any
  default = {
    buckets = {}
  }
}
