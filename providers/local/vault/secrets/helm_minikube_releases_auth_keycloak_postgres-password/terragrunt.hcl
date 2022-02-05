locals {
  name = basename(get_terragrunt_dir()) # Get the name from the folder
}

inputs = {
  filename = "${path_relative_from_include("global")}/terraform/secrets/${local.name}"
}

include "provider" {
  path = find_in_parent_folders("provider-config.hcl")
}

include "global" {
  path = find_in_parent_folders("global-config.hcl")
}
