terraform {
  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = ">= 4.0.0"
    }
  }
}

provider "keycloak" {
  client_id = "admin-cli"
  username  = "keycloak"
  password  = "password"
  url       = "http://localhost:8080"
}

resource "keycloak_realm" "realm" {
  realm                = "example-realm"
  enabled              = true
  display_name         = "Example Realm"
  display_name_html    = "<b>Example Realm</b>"
  login_theme          = "base"
  account_theme        = "base"
  admin_theme          = "base"
  email_theme          = "base"
  access_code_lifespan = "30m"
  ssl_required         = "external"
  password_policy      = "upperCase(1) and length(8) and forceExpiredPasswordChange(365) and notUsername"

  internationalization {
    supported_locales = [
      "en",
      "de"
    ]
    default_locale = "en"
  }
}

resource "keycloak_openid_client" "service" {
  realm_id    = keycloak_realm.realm.id
  client_id   = "example-open-client"
  name        = "Example Open Client"
  enabled     = true
  access_type = "CONFIDENTIAL"
  login_theme = "base"
}