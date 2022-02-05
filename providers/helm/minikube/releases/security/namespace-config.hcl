dependency "namespace" {
  config_path = "../../../../kubernetes/minikube/namespaces/security"
}

inputs = {
  namespace_name = dependency.namespace.outputs.name
}
