generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = templatefile("provider.conf", {
    url      = "https://keycloak.local.gambiarra.net" # TODO define a better way to get the Keycloak endpoint
    username = get_env("TG_KEYCLOAK_MINIKUBE_KEYCLOAK_USERNAME")
    password = get_env("TG_KEYCLOAK_MINIKUBE_KEYCLOAK_PASSWORD")
  })
}

generate "terraform" {
  path      = "terraform.tf"
  if_exists = "overwrite_terragrunt"
  contents  = file("../../terraform.conf")
}
