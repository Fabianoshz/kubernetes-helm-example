dependency "namespace" {
  config_path = "../../../../kubernetes/minikube/namespaces/auth"
}

inputs = {
  namespace_name = dependency.namespace.outputs.name
}
