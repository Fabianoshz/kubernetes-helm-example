dependency "namespace" {
  config_path = "${path_relative_from_include("global")}/providers/kubernetes/minikube/namespaces/${local.common.inputs.namespace_name}"
}

dependency "keycloak" {
  config_path = "${path_relative_from_include("global")}/providers/helm/minikube/releases/auth/keycloak"
}

dependency "cert_manager" {
  config_path = "${path_relative_from_include("global")}/providers/helm/minikube/releases/security/cert-manager"
}

terraform {
  source = "${path_relative_from_include("global")}/modules/helm/resources/helm_release"
}

locals {
  name              = basename(get_terragrunt_dir()) # Get the name from the folder
  common            = read_terragrunt_config(find_in_parent_folders("namespace-config.hcl"))
  hostname          = "jenkins.local.gambiarra.net"
  keycloak_auth_url = "https://keycloak.local.gambiarra.net/auth/" # TODO get directly from keycloak
  keycloak_realm    = "gambiarra" # TODO get directly from keycloak
}

inputs = {
  name          = local.name
  namespace     = dependency.namespace.outputs.name
  repository    = "https://charts.jenkins.io"
  chart         = "jenkins"
  chart_version = "3.11.3"

  values = [
    file("values/ingress.yaml"),
    file("values/plugins.yaml"),
    templatefile("values/JCasC.yaml", {
      keycloak_auth_url = local.keycloak_auth_url
      keycloak_realm = local.keycloak_realm
    })
  ]

  extra_yamls = [
    templatefile("extra-yamls/configmaps/config.yaml", {
      name      = "${local.name}-config"
      namespace = local.common.inputs.namespace_name
    })
  ]

  timeout = 1500
}

include "provider" {
  path = find_in_parent_folders("provider-config.hcl")
}

include "global" {
  path = find_in_parent_folders("global-config.hcl")
}
