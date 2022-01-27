locals {
  kustomize_template_md5 = md5(templatefile("extra-yamls/kustomization.yaml.template", {
    extra_yamls = var.extra_yamls
  }))

  files = fileset("extra-yamls", "**/*.yaml")
  content_md5 = { for fn in local.files : fn => filemd5("extra-yamls/${fn}") }
  content_md5_joined = md5(join("", values(local.content_md5)))
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
    value = var.generate_kustomize ? local.kustomize_template_md5 : local.content_md5_joined
  }

  depends_on = [
    local_file.kustomization_file,
    null_resource.yaml
  ]
}

resource "local_file" "kustomization_file" {
  count = length(var.extra_yamls) > 0 && var.generate_kustomize ? 1 : 0

  filename = "extra-yamls/kustomization.yaml"
  content  = templatefile("extra-yamls/kustomization.yaml.template", {
    extra_yamls = var.extra_yamls
  })

  depends_on = [
    null_resource.yaml
  ]
}

resource "null_resource" "yaml" {
  for_each = fileset("extra-yamls", "**/*.yaml")
  
  triggers = {
    content     = file("extra-yamls/${each.value}")
    content_md5 = filemd5("extra-yamls/${each.value}")
  }
}
