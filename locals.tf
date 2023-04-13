# Helm chart value overrides. They should be passed as a list of HCL structures
# Important we don't use the default helm values it's blank instead locals used to override it with custom values.
locals {
  helm_values = [{
    minio = {
      mode = "standalone" # set the deployment mode of MinIO to standalone
      resources = {
        requests = {
          memory = "128Mi" # specify the memory request for the container
        }
      }
      # specify the ingress configuration for the MinIO console UI
      consoleIngress = {
        enabled = true
        annotations = {
          "cert-manager.io/cluster-issuer"                   = "${var.cluster_issuer}"
          "traefik.ingress.kubernetes.io/router.entrypoints" = "websecure"
          "traefik.ingress.kubernetes.io/router.middlewares" = "traefik-withclustername@kubernetescrd"
          "traefik.ingress.kubernetes.io/router.tls"         = "true"
          "ingress.kubernetes.io/ssl-redirect"               = "true"
          "kubernetes.io/ingress.allow-http"                 = "false"
        }
        # specify the hostnames that the ingress should respond to
        hosts = [
          "minio.apps.${var.base_domain}",
          "minio.apps.${var.cluster_name}.${var.base_domain}",
        ]
        # specify the TLS configuration for the ingress
        tls = [{
          secretName = "minio-tls"
          hosts = [
            "minio.apps.${var.base_domain}",
            "minio.apps.${var.cluster_name}.${var.base_domain}",
          ]
        }]
      }
    }
  }]
}
