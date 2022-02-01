variable "name" {
  type        = string
  description = "(Required) The name of the release, this will be what you see when you run 'helm list' on the cluster"
}

variable "namespace" {
  type        = string
  default     = "default"
  description = "(Optional) The namespace of the release, mind that the resources might have different namespaces inside the template."
}

variable "repository" {
  type        = string
  description = "(Required) The repository of the release you want to use. Ex.: 'https://helm.nginx.com/stable'"
}

variable "chart" {
  type        = string
  description = "(Required) The name of the chart inside the repository. Ex.: 'nginx-ingress'"
}

variable "chart_version" {
  type        = string
  default     = "latest"
  description = "(Optional) The version of the chart. Ex.: '1.0.0'"
}

variable "timeout" {
  type        = number
  default     = 300
  description = "(Optional) The timeout in seconds that the helm will wait for the relase to be deployed. Some charts might need higher values."
}

variable "values" {
  type        = list(string)
  default     = []
  description = "(Optional) A list of values to be passed down to the release."
  validation {
    condition = can([for value in var.values : yamldecode(value)])
    error_message = "One of the values is an invalid yaml or is empty."
  }
}

variable "extra_yamls" {
  type        = list(string)
  default     = []
  description = "(Optional) A list of extra yamls to be inserted on the release using kustomize on the helm post-render action."
  validation {
    condition = can([for yaml in var.extra_yamls : yamldecode(yaml)])
    error_message = "One of the extra_yamls is an invalid yaml or is empty."
  }
}

variable "generate_kustomize" {
  type        = bool
  default     = true
  description = "(Optional) Auto generate the kustomization.yaml file for the kustomize on the helm post-render action."
}
