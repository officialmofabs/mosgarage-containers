variable "nfs" {
  type = object({
    enabled      = optional(bool, false)
    claim_name   = optional(string, "coder-pv-claim")
    root         = optional(string, "/efs")
    mount_root   = optional(bool, false)
    common       = optional(string, "/efs/common")
    mount_common = optional(bool, false)
    path         = optional(string, "/home/coder")
    subpath      = optional(string, "home")
    mount_user   = optional(bool, false)
    user         = optional(string, "/efs/user")
  })

  default = {}
}

locals {
  env_nfs = var.nfs != null ? [
    { name = "NFS_ROOT", value = var.nfs.root },
    { name = "NFS_COMMON", value = var.nfs.common },
    { name = "NFS_USER", value = var.nfs.user },
    { name = "NFS_WORKSPACE", value = "${var.nfs.user}/${var.workspace.class}/${data.coder_workspace.me.name}" }
  ] : []
}
