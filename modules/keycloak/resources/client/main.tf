resource "keycloak_openid_client" "openid_client" {
  realm_id  = var.realm_id
  client_id = var.client_id
  name      = var.name
  enabled   = var.enabled

  access_type                  = var.access_type
  direct_access_grants_enabled = var.direct_access_grants_enabled
  standard_flow_enabled        = var.standard_flow_enabled

  base_url            = var.base_url
  admin_url           = var.admin_url
  valid_redirect_uris = var.valid_redirect_uris
  web_origins         = var.web_origins

  login_theme = var.login_theme
}
