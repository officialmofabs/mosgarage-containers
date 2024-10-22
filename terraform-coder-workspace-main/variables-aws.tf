variable "aws" {
  type = object({
    use_token = optional(bool, false)
  })

  default = {}
}
