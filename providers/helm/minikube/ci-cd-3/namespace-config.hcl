dependency "namespace" {
  config_path = "../../../kubernetes/minikube/namespaces/ci-cd-3"
}

inputs = {
  namespace_name = dependency.namespace.outputs.name
}