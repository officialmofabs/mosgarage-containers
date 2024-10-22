data "coder_parameter" "git_pat" {
  count        = var.params.pat ? 1 : 0
  order        = 200
  name         = "02-pat-git"
  display_name = "Git PAT"
  default      = ""
  icon         = "/emojis/1f511.png"
  mutable      = true
}

data "coder_parameter" "tcp_ports" {
  count        = var.params.ports ? 1 : 0
  order        = 100
  name         = "01-tcp-ports"
  display_name = "TCP ports (separated by a comma)"
  default      = ""
  icon         = "/emojis/1f511.png"
  mutable      = true
}

locals {
  port_list = var.params.ports ? [for s in split(",", data.coder_parameter.tcp_ports[0].value) : s if s != "" && can(tonumber(s))] : []
  tcp_ports = [for s in local.port_list : tonumber(s)]
  pod_ports = concat(local.tcp_ports, var.pod.tcp_ports)
}

variable "params" {
  type = object({
    ports = optional(bool, false)
    pat   = optional(bool, false)
  })

  default = {}
}
