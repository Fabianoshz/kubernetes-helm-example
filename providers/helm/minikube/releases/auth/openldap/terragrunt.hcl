dependency "namespace" {
  config_path = "${path_relative_from_include("global")}/providers/kubernetes/minikube/namespaces/${local.common.inputs.namespace_name}"
}

dependency "ldap-admin-password" {
  config_path = "${path_relative_from_include("global")}/providers/local/vault/secrets/helm_minikube_releases_auth_openldap_ldap-admin-password"
}

dependency "ldap-config-password" {
  config_path = "${path_relative_from_include("global")}/providers/local/vault/secrets/helm_minikube_releases_auth_openldap_ldap-config-password"
}

terraform {
  source = "${path_relative_from_include("global")}/modules/helm/resources/helm_release"
}

locals {
  name   = basename(get_terragrunt_dir()) # Get the name from the folder
  common = read_terragrunt_config(find_in_parent_folders("namespace-config.hcl"))
}

inputs = {
  name          = local.name
  namespace     = dependency.namespace.outputs.name
  repository    = "https://jp-gouin.github.io/helm-openldap"
  chart         = "openldap-stack-ha"
  chart_version = "2.1.6"

  values = [
    file("values/values.yaml")
  ]

  extra_yamls = [
    templatefile("extra-yamls/secrets/openldap-admin-creds.yaml", {
      name                 = "openldap-admin-creds"
      namespace            = local.common.inputs.namespace_name
      ldap_admin_password  = dependency.ldap-admin-password.outputs.secret
      ldap_config_password = dependency.ldap-config-password.outputs.secret
    })
  ]
}

include "provider" {
  path = find_in_parent_folders("provider-config.hcl")
}

include "global" {
  path = find_in_parent_folders("global-config.hcl")
}
