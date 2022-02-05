terraform {
  source = "${path_relative_from_include("global")}/modules/helm/resources/helm_release"
}

locals {
  name   = basename(get_terragrunt_dir()) # Get the name from the folder
  common = read_terragrunt_config(find_in_parent_folders("namespace-config.hcl"))
}

inputs = {
  name          = local.name
  namespace     = local.common.inputs.namespace_name
  repository    = "https://charts.jetstack.io"
  chart         = "cert-manager"
  chart_version = "v1.7.0"

  values = [
    file("values/values.yaml")
  ]
}

include "provider" {
  path = find_in_parent_folders("provider-config.hcl")
}

include "global" {
  path = find_in_parent_folders("global-config.hcl")
}
