output "id" {
  value = resource.null_resource.this.id
}

output "access_key" {
  description = "Minio access key"
  value       = random_password.minio_accesskey.result
}

output "secret_key" {
  description = "Minio secret key"
  value       = random_password.minio_secretkey.result
}
