terraform {
  source = "${path_relative_from_include("global")}/modules/keycloak/resources/client"
}

inputs = {
  realm_id  = "gambiarra"
  client_id = "jenkins"
  name      = "Jenkins"
  enabled   = true

  access_type                  = "PUBLIC"
  direct_access_grants_enabled = true
  standard_flow_enabled        = true

  base_url  = "https://jenkins.local.gambiarra.net/"
  admin_url = "https://jenkins.local.gambiarra.net/"
  valid_redirect_uris = [
    "https://jenkins.local.gambiarra.net/*"
  ]
  web_origins = [
    "https://jenkins.local.gambiarra.net"
  ]

  login_theme = "keycloak"
}

include "provider" {
  path = find_in_parent_folders("provider-config.hcl")
}

include "global" {
  path = find_in_parent_folders("global-config.hcl")
}
