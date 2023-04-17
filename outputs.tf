output "id" {
  description = "ID to pass other modules in order to refer to this module as a dependency."
  value       = resource.null_resource.this.id
}

output "endpoint" {
  description = "MinIO endpoint for where the buckets are available."
  value       = "minio.${var.namespace}:9000"
}
output "minio_root_user_credentials" {
  value     = random_password.minio_root_secretkey
  sensitive = true
}
