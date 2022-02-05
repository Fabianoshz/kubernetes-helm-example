resource "ldap_object" "object" {
  dn             = "ou=users,dc=gambiarra,dc=net"
  object_classes = ["top", "organizationalUnit"]
}
