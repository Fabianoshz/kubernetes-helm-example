dependency "namespace" {
  config_path = "../../../../kubernetes/minikube/namespaces/ci-cd"
}

inputs = {
  namespace_name = dependency.namespace.outputs.name
}