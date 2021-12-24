# https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs
terraform {
  required_providers {
    keycloak = {
      source = "mrparkers/keycloak"
      version = "3.6.0"
    }
  }
}

variable "realm_name" {
  type = string
  description = "Realm name"
  default = "my-realm"
}

# Example Usage (password grant)
provider "keycloak" {
  client_id = "admin-cli"
  username = "admin"
  password = "admin"
  url = "http://localhost:8080"
}

# Example Usage (client credentials grant)
# provider "keycloak" {
#   client_id     = "terraform"
#   client_secret = "884e0f95-0f42-4a63-9b1f-94274655669e"
#   url           = "http://localhost:8080"
# }

# https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs/data-sources/realm
resource "keycloak_realm" "my-realm" {
  realm = var.realm_name
  enabled = true
  display_name = "my realm"
  ssl_required = "external"
  registration_allowed = false
}

# https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs/resources/openid_client
resource "keycloak_openid_client" "openid_client" {
  realm_id = keycloak_realm.my-realm.id
  client_id = "test-client"
  name = "test client"
  enabled = true
  access_type = "CONFIDENTIAL"
  standard_flow_enabled = true
  implicit_flow_enabled = true
  direct_access_grants_enabled = true
  service_accounts_enabled = true

  valid_redirect_uris = [
    "*"
  ]
}

# https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs/resources/user_roles
resource "keycloak_role" "client_role" {
  realm_id = keycloak_realm.my-realm.id
  client_id = keycloak_openid_client.openid_client.id
  name = "my-client-role"
  description = "My Client Role"
}
