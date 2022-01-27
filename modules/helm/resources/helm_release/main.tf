locals {
  kustomize_template_md5 = md5(templatefile("extra-yamls/kustomization.yaml.template", {
    extra_yamls = var.extra_yamls
  }))

  extra_yamls = { for yaml in var.extra_yamls : yaml => md5(yaml) }
  extra_yamls_md5 = md5(join("", values(local.extra_yamls)))
}

resource "helm_release" "release" {
  name       = var.name
  namespace  = var.namespace
  repository = var.repository
  chart      = var.chart
  version    = var.chart_version
  values     = var.values
  timeout    = var.timeout

  postrender {
    binary_path = abspath("kustomize.sh")
  }

  set {
    name  = "extra-yamls-content-md5"
    value = var.generate_kustomize ? local.kustomize_template_md5 : local.extra_yamls_md5
  }

  depends_on = [
    local_file.kustomization_file,
    local_file.yaml
  ]
}

resource "local_file" "kustomization_file" {
  count = length(var.extra_yamls) > 0 && var.generate_kustomize ? 1 : 0

  filename = "extra-yamls/kustomization.yaml"
  content  = templatefile("extra-yamls/kustomization.yaml.template", {
    extra_yamls = var.extra_yamls
  })

  depends_on = [
    local_file.yaml
  ]
}

resource "local_file" "yaml" {
  count = length(var.extra_yamls)

  filename = "extra-yamls/${md5(var.extra_yamls[count.index])}.yaml"
  content  = var.extra_yamls[count.index]
}
