locals {
  app_name       = "coder-user"
  app_instance   = "coder-user-${lower(data.coder_workspace_owner.me.name)}"
  app_part_of    = "coder"
  app_managed_by = "coder"
  app_version    = "0.0.1"
}
