variable "workspace" {
  type = object({
    class = optional(string, "")
    type  = optional(string, "")
    metadata = optional(list(object({
      key         = string
      description = string
      script      = string
      interval    = optional(number, 30)
      timeout     = optional(number, 5)
      order       = optional(number)
    })), [])
  })

  default = {}
}
