variable "pod" {
  type = object({
    labels       = optional(map(string), {})
    annotations  = optional(map(string), {})
    env          = optional(map(string), {})
    start_script = optional(string, "/opt/workspace/entrypoint.sh")
    tcp_ports    = optional(list(number), [])
    node_group   = optional(list(string), [])
    privileged   = optional(bool, false)
  })

  default = {}
}
