dependency "namespace" {
  config_path = "${path_relative_from_include("global")}/providers/kubernetes/minikube/namespaces/${local.common.inputs.namespace_name}"
}

dependency "admin-password" {
  config_path = "${path_relative_from_include("global")}/providers/local/vault/secrets/helm_minikube_releases_auth_keycloak_admin-password"
}

dependency "management-password" {
  config_path = "${path_relative_from_include("global")}/providers/local/vault/secrets/helm_minikube_releases_auth_keycloak_management-password"
}

dependency "postgres-password" {
  config_path = "${path_relative_from_include("global")}/providers/local/vault/secrets/helm_minikube_releases_auth_keycloak_postgres-password"
}

dependency "cert_manager" {
  config_path = "${path_relative_from_include("global")}/providers/helm/minikube/releases/security/cert-manager"
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
  repository    = "https://charts.bitnami.com/bitnami"
  chart         = "keycloak"
  chart_version = "6.1.1"

  values = [
    file("values/auth.yaml"),
    file("values/ingress.yaml"),
    file("values/postgres.yaml"),
    file("values/service.yaml")
  ]

  extra_yamls = [
    templatefile("extra-yamls/secrets/keycloak-password.yaml", {
      name            = "keycloak-passwords"
      namespace       = local.common.inputs.namespace_name
      admin_pass      = dependency.admin-password.outputs.secret
      management_pass = dependency.management-password.outputs.secret
      postgres_pass   = dependency.postgres-password.outputs.secret
    })
  ]
}

include "provider" {
  path = find_in_parent_folders("provider-config.hcl")
}

include "global" {
  path = find_in_parent_folders("global-config.hcl")
}
