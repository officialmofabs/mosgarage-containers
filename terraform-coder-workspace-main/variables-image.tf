variable "image" {
  type = object({
    name         = optional(string, "julzor/coder-workspace-services")
    tag          = optional(string, "latest")
    pull_secrets = optional(string, "")
  })

  default = {}
}
