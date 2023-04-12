# Here we define the users what we need to output to access to repective consoles.
output "keycloak_admin_credentials" {
  value     = module.oidc.admin_credentials
  sensitive = true
}
