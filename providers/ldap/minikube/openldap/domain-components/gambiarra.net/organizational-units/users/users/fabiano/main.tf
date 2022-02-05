resource "ldap_object" "object" {
  dn             = "uid=fabiano.honorato,ou=users,dc=gambiarra,dc=net"
  object_classes = ["inetOrgPerson"]
  attributes = [
    { sn = "Honorato" },
    { givenName = "Fabiano" },
    { cn = "fabiano.honorato" },
    { displayName = "Mr. Fabiano Honorato" },
    { mail = "fabiano.honorato@gambiarra.net" },
    { userPassword = "password" }
  ]
}
