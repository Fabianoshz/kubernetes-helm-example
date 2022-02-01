# This will create a helm release using the provided kustomization file.
# This allows you to make a more complex kustomization setup, but
# you can't use the terragrunt/terraform functions on your kustomize
# files. Also you always have to the the extra-yamls folder.

terraform {
  source = "../../../../../../modules/helm/resources/helm_release"
}

locals {
  name   = basename(get_terragrunt_dir()) # Get the name from the folder
  common = read_terragrunt_config(find_in_parent_folders("namespace-config.hcl"))
}

inputs = {
  name          = local.name
  namespace     = local.common.inputs.namespace_name
  repository    = "https://charts.jenkins.io"
  chart         = "jenkins"
  chart_version = "3.11.3"

  values = [
    file("values/additionalPlugins.yaml"),
    file("values/JCasC.yaml")
  ]

  # The jenkins chart can take a while to start depending on your connection.
  timeout = 600

  generate_kustomize = false
}

# This is adding the provider specific configuration
include "provider" {
  path = find_in_parent_folders("provider-config.hcl")
}

# This is adding the global configuration, where you should put all the things that are globally common.
include "global" {
  path = find_in_parent_folders("global-config.hcl")
}
