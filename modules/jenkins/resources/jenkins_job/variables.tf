variable name {
  type = string
  default = ""
}

variable display_name {
  type = string
}

variable github_credentials_id {
  type = string
}

variable repo_owner {
  type = string
}

variable repository {
  type = string
}

variable repository_url {
  type = string
}

variable jenkinsfile_path {
  type = string
}

variable enable_behaviours {
  type    = bool
  default = true
}

variable suppress_automatic_scm_triggering {
  type    = bool
  default = false
}