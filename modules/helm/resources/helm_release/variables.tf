variable "name" {
  type        = string
  default     = ""
}

variable "namespace" {
  type        = string
  default     = ""
}

variable "repository" {
  type        = string
  default     = ""
}

variable "chart" {
  type        = string
  default     = ""
}

variable "chart_version" {
  type        = string
  default     = ""
}

variable "timeout" {
  type        = number
  default     = 300
}

variable "values" {
  type        = list(string)
  default     = []
}

variable "extra_yamls" {
  type        = list(string)
  default     = []
}

variable "generate_kustomize" {
  type        = bool
  default     = true
}
