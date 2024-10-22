variable "apps" {
  type = object({
    vscode   = optional(bool, false)
    vsweb    = optional(bool, false)
    terminal = optional(bool, true)
  })

  default = {}
}

variable "management" {
  type = object({
    url  = optional(string, "")
    icon = optional(string, "")
  })

  default = {}
}
