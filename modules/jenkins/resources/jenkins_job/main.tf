resource "jenkins_job" "job" {
  name = length(var.name) > 0 ? var.name : var.repository

  template = templatefile("./job.xml", {
      display_name                      = var.display_name
      github_credentials_id             = var.github_credentials_id
      repo_owner                        = var.repo_owner
      repository                        = var.repository
      repository_url                    = var.repository_url
      jenkinsfile_path                  = var.jenkinsfile_path
      enable_behaviours                 = var.enable_behaviours
      suppress_automatic_scm_triggering = var.suppress_automatic_scm_triggering
    }
  )
}
