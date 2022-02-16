locals {
  default_yaml = [templatefile("${path.module}/values.tmpl.yaml", {
    base_domain    = var.base_domain,
    cluster_issuer = var.cluster_issuer,
    minio = {
      access_key = random_password.minio_accesskey.result
      secret_key = random_password.minio_secretkey.result
      domain     = "minio.apps.${var.cluster_name}.${var.base_domain}"
      buckets    = var.minio.buckets
    }
  })]
  all_yaml = concat(local.default_yaml, var.extra_yaml)
}
