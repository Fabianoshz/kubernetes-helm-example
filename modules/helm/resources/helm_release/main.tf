locals {
  kustomize_template_md5 = md5(templatefile("extra-yamls/kustomization.yaml.template", {
    extra_yamls = var.extra_yamls
  }))

  extra_yamls_md5 = md5(join("", values(
    { for yaml in var.extra_yamls : yaml => md5(yaml) }
  )))
}

resource "helm_release" "release" {
  name       = var.name
  namespace  = var.namespace
  repository = var.repository
  chart      = var.chart
  version    = var.chart_version
  values     = var.values
  timeout    = var.timeout

  # Using the post-render to allow for more customization of the helm template.
  # You can add any logic on the kustomize.sh script.
  # Docs: https://helm.sh/docs/topics/advanced/#post-rendering
  postrender {
    binary_path = abspath("kustomize.sh")
  }

  # This value is set on the release so that whenever a file on the extra-yamls is updated
  # the release also updates, triggering the post-render. Is just the md5 of the auto
  # generated kustomization file or the files inside the extra-yamls folder if the user
  # disables the auto generation.
  set {
    name  = "extra-yamls-content-md5"
    value = var.generate_kustomize ? local.kustomize_template_md5 : local.extra_yamls_md5
  }

  # This depends on ensures that the files exists before the helm release
  # is updated on the cluster, allowing the post-render to run correctly.
  depends_on = [
    local_file.kustomization_file,
    local_file.yaml
  ]
}

# This creates a kustomization.yaml file given that we any value on the
# extra_yamls variable and the user asked for the auto generated
# kustomization file.
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

# Given that we have values on the extra_yamls variable we have to
# write it to the disk so that when the post-render is running
# we have the files available.
resource "local_file" "yaml" {
  count = length(var.extra_yamls)

  filename = "extra-yamls/${md5(var.extra_yamls[count.index])}.yaml"
  content  = var.extra_yamls[count.index]
}
