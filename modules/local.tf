locals {
  profiles_yaml = [ for i in var.profiles : templatefile("${path.module}/profiles/${i}.yaml", {
    base_domain    = var.base_domain,
    cluster_issuer = var.cluster_issuer,
    minio          = {
      access_key = random_password.minio_accesskey.result
      secret_key = random_password.minio_secretkey.result
      domain = "minio.apps.${var.cluster_name}.${var.base_domain}"
      extra_buckets = var.minio.extra_buckets
    }
  }) ]
  all_yaml = concat(local.profiles_yaml, var.extra_yaml)
}
