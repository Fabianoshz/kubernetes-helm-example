resource "keycloak_realm" "realm" {
  realm             = "gambiarra"
  enabled           = true
  display_name      = "Gambiarra"
  display_name_html = "<b>Gambiarra</b>"

  login_theme = "keycloak"

  password_policy = "upperCase(1) and length(8) and forceExpiredPasswordChange(365) and notUsername"
}
