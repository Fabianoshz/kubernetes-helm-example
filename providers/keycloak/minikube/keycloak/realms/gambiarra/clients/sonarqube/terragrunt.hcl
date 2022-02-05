inputs = {
  realm_id  = "gambiarra"
  client_id = "sonarqube"

  name    = "Sonarqube"
  enabled = true

  access_type = "PUBLIC"

  direct_access_grants_enabled = true
  standard_flow_enabled = true

  base_url = "https://sonarqube.local.gambiarra.net/"
  admin_url = "https://sonarqube.local.gambiarra.net/"

  valid_redirect_uris = [
    "https://sonarqube.local.gambiarra.net/*"
  ]
  web_origins = [
    "https://sonarqube.local.gambiarra.net"
  ]

  login_theme = "keycloak"
}

include "provider" {
  path = find_in_parent_folders("provider-config.hcl")
}

include "global" {
  path = find_in_parent_folders("global-config.hcl")
}
