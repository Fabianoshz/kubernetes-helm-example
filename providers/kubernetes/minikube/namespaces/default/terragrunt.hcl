terraform {
  after_hook "import_s3_state_bucket" {
    commands = ["init"]
    execute = ["${run_cmd("--terragrunt-quiet", "git", "rev-parse", "--show-toplevel")}/bin/import-resource.sh", "kubernetes_namespace_v1.namespace", basename(get_terragrunt_dir())]
  }

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
