terraform {
  source = "../../../../../modules/helm/resources/helm_release"
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("namespace-config.hcl"))
}

inputs = {
  name          = basename(get_terragrunt_dir()) # Get the name from the folder
  namespace     = local.common.inputs.namespace_name
  repository    = "https://charts.jenkins.io"
  chart         = "jenkins"
  chart_version = "3.11.3"

  values = [
    "${file("values/additionalPlugins.yaml")}",
    "${file("values/JCasC.yaml")}",
    "${file("values/values.yaml")}"
  ]

  extra_yamls = [
    "${templatefile("extra-yamls/configmaps/config.yaml", {
      name = "${basename(get_terragrunt_dir())}-config"
      namespace = local.common.inputs.namespace_name
    })}",
  ]

  timeout = 600
}

include "provider" {
  path = find_in_parent_folders("provider-config.hcl")
}

include "global" {
  path = find_in_parent_folders("global-config.hcl")
}
