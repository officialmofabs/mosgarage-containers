resource "coder_agent" "main" {
  arch                    = data.coder_provisioner.me.arch
  os                      = "linux"
  startup_script_behavior = "blocking"
  startup_script          = var.pod.start_script
  env                     = merge(var.pod.env, local.env_default)

  display_apps {
    vscode                 = var.apps.vscode
    vscode_insiders        = false
    ssh_helper             = false
    port_forwarding_helper = false
    web_terminal           = var.apps.terminal
  }

  dynamic "metadata" {
    for_each = var.workspace.metadata

    content {
      key          = metadata.value.key
      display_name = metadata.value.description
      script       = metadata.value.script
      interval     = metadata.value.interval
      timeout      = metadata.value.timeout
    }
  }
}

locals {
  env_default = {
    GIT_DOMAIN          = var.git.domain
    GIT_AUTHOR_NAME     = data.coder_workspace_owner.me.name
    GIT_COMMITTER_NAME  = data.coder_workspace_owner.me.name
    GIT_AUTHOR_EMAIL    = data.coder_workspace_owner.me.email
    GIT_COMMITTER_EMAIL = data.coder_workspace_owner.me.email
    GIT_PAT             = var.params.pat ? data.coder_parameter.git_pat[0].value : ""
    DOCKER_MODE         = "off"
  }
}
