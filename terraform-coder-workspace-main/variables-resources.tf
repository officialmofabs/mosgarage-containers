variable "resources" {
  type = object({
    request_cpu    = optional(string, "")
    request_memory = optional(string, "")
    limit_cpu      = optional(string, "")
    limit_memory   = optional(string, "")
  })

  default = {}
}
