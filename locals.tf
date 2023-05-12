locals {
  helm_values = [{
    minio = {
      mode = "standalone" # Set the deployment mode of MinIO to standalone
      resources = {
        requests = {
          memory = "128Mi"
        }
      }
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
        hosts = [
          "minio.apps.${var.base_domain}",
          "minio.apps.${var.cluster_name}.${var.base_domain}",
        ]
        tls = [{
          secretName = "minio-tls"
          hosts = [
            "minio.apps.${var.base_domain}",
            "minio.apps.${var.cluster_name}.${var.base_domain}",
          ]
        }]
      }
      metrics = {
        serviceMonitor = {
          enabled = var.enable_service_monitor
        }
      }
      rootUser     = "root"
      rootPassword = random_password.minio_root_secretkey.result
      users        = var.config_minio.users
      buckets      = var.config_minio.buckets
      policies     = var.config_minio.policies
    }
  }]
}
