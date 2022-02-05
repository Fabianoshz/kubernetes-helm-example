locals {
  git_root_path = run_cmd("--terragrunt-quiet", "git", "rev-parse", "--show-toplevel")
}

terraform {
  before_hook "tfenv_test" {
    commands     = ["init", "apply", "plan", "destroy"]
    execute      = ["${local.git_root_path}/bin/tfenv-test.sh"]
  }

  before_hook "tgenv_test" {
    commands     = ["init", "apply", "plan", "destroy"]
    execute      = ["${local.git_root_path}/bin/tgenv-test.sh"]
  }

  before_hook "git_test" {
    commands     = ["init", "apply", "plan", "destroy"]
    execute      = ["${local.git_root_path}/bin/git-test.sh"]
  }

  extra_arguments "plugin_dir" {
    commands = [
        "init",
        "plan",
        "apply",
        "destroy",
        "output"
    ]

    env_vars = {
      TF_PLUGIN_CACHE_DIR = "${local.git_root_path}/terraform/plugins_cache"
    }
  }
}

remote_state {
  backend = "local"

  config = {
    path = "${local.git_root_path}/terraform/states/${path_relative_to_include("global-config.hcl")}/terraform.tfstate"
  }
}

download_dir = "${local.git_root_path}/terraform/terragrunt_cache"
