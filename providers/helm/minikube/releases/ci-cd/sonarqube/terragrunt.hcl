dependency "namespace" {
  config_path = "${path_relative_from_include("global")}/providers/kubernetes/minikube/namespaces/${local.common.inputs.namespace_name}"
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
  repository    = "https://SonarSource.github.io/helm-chart-sonarqube"
  chart         = "sonarqube"
  chart_version = "2.0.0+233"

  values = [
    file("values/extra-containers.yaml"),
    file("values/ingress.yaml"),
    file("values/plugins.yaml"),
    file("values/values.yaml")
  ]
}

include "provider" {
  path = find_in_parent_folders("provider-config.hcl")
}

include "global" {
  path = find_in_parent_folders("global-config.hcl")
}
