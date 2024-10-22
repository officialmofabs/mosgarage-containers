variable "git" {
  type = object({
    domain  = optional(string, "gitlab.com")
  })

  default = {}
}
