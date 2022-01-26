resource "helm_release" "release" {
  name       = var.name
  namespace  = var.namespace
  repository = var.repository
  chart      = var.chart
  version    = var.chart_version
  postrender {
    binary_path = "kustomize.sh"
  }
}