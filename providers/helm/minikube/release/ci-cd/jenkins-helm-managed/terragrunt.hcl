# This will create a helm release using the auto generated kustomize option.
# All you have to do to add new files to your helm template is to pass the
# values you want on the variable 'extra_yamls', they will be rendered
# using the post-render action on helm and will be added to you release.

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

  extra_yamls = [
    templatefile("extra-yamls/configmaps/config.yaml", {
      name      = "${local.name}-config"
      namespace = local.common.inputs.namespace_name
    }),
  ]

  # The jenkins chart can take a while to start depending on your connection.
  timeout = 600
}

# This is adding the provider specific configuration
include "provider" {
  path = find_in_parent_folders("provider-config.hcl")
}

# This is adding the global configuration, where you should put all the things that are globally common.
include "global" {
  path = find_in_parent_folders("global-config.hcl")
}
