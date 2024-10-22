variable "coder" {
  type = object({
    namespace    = optional(string, "")
    url          = optional(string, "")
    internal_url = optional(string, "http://coder:8080")
  })

  default = {}
}

locals {
  init_script = var.coder.internal_url != "" ? replace(coder_agent.main.init_script, var.coder.url, var.coder.internal_url) : coder_agent.main.init_script
}
