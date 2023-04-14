output "id" {
  description = "ID to pass other modules in order to refer to this module as a dependency."
  value       = resource.null_resource.this.id
}
output "minio_root_secretkey" {
  description = "Minio RootUser"
  value       = random_password.minio_root_secretkey
  sensitive   = true
}
