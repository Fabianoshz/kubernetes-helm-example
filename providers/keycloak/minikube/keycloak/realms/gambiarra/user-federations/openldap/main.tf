resource "keycloak_ldap_user_federation" "ldap_user_federation" {
  name     = "openldap"
  realm_id = "gambiarra"
  enabled  = true

  username_ldap_attribute = "cn"
  rdn_ldap_attribute      = "cn"
  uuid_ldap_attribute     = "entryDN"
  user_object_classes     = [
    "inetOrgPerson"
  ]
  connection_url          = "ldap://openldap-openldap-stack-ha.auth.svc.cluster.local"
  users_dn                = "ou=users,dc=gambiarra,dc=net"
  bind_dn                 = "cn=admin,dc=gambiarra,dc=net"
  bind_credential         = "XLCu281CmAtPgUktvbd9CpJ1HPVNhTHgdBIPTrZppx"

  connection_timeout = "5s"
  read_timeout       = "10s"
}
