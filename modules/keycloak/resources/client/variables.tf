variable realm_id {
  type        = string
  default     = ""
  description = "(Required)"
}

variable client_id {
  type        = string
  default     = ""
  description = "(Required)"
}

variable name {
  type        = string
  default     = ""
  description = "(Required)"
}

variable enabled {
  type        = bool
  default     = true
  description = "(Optional)"
}

variable access_type {
  type        = string
  default     = ""
  description = "(Required) CONFIDENTIAL, PUBLIC o BEARER-ONLY"
}

variable direct_access_grants_enabled {
  type        = bool
  default     = false
  description = "(Optional)"
}

variable standard_flow_enabled {
  type        = bool
  default     = false
  description = "(Optional)"
}

variable base_url {
  type        = string
  default     = ""
  description = "(Optional)"
}

variable admin_url {
  type        = string
  default     = ""
  description = "(Optional)"
}

variable valid_redirect_uris {
  type        = list(string)
  default     = []
  description = "(Optional)"
}

variable web_origins {
  type        = list(string)
  default     = []
  description = "(Optional)"
}

variable login_theme {
  type        = string
  default     = "keycloak"
  description = "(Optional)"
}
