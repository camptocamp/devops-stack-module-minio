locals {
  default_yaml = [ templatefile("${path.module}/values.tmpl.yaml", {
    cluster_info   = var.cluster_info,
    cluster_issuer = var.cluster_issuer,
    minio          = {
      access_key = random_password.minio_accesskey.result
      secret_key = random_password.minio_secretkey.result
      domain     = "minio.apps.${var.cluster_info.cluster_name}.${var.cluster_info.base_domain}"
      buckets    = var.minio.buckets
    }
  }) ]
  all_yaml = concat(local.default_yaml, var.extra_yaml)
}
