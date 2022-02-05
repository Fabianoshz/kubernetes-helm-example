terraform {
  source = "${path_relative_from_include("global")}/modules/kubernetes/resources/namespace_v1"
}

inputs = {
  name = basename(get_terragrunt_dir()) # Get the name from the folder
}

include "provider" {
  path = find_in_parent_folders("provider-config.hcl")
}

include "global" {
  path = find_in_parent_folders("global-config.hcl")
}