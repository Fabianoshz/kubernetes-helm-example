locals {
  git_root_path = run_cmd("--terragrunt-quiet", "git", "rev-parse", "--show-toplevel")
}

remote_state {
  backend = "local"

  config = {
    path = "${local.git_root_path}/states/${path_relative_to_include("global-config.hcl")}/terraform.tfstate"
  }
}