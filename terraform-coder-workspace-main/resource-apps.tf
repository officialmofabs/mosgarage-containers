resource "coder_app" "code-server" {
  count        = var.apps.vsweb ? 1 : 0
  agent_id     = coder_agent.main.id
  slug         = "code-server"
  display_name = "VS Code Web"
  url          = "http://localhost:13337/?folder=/home/coder"
  icon         = "/icon/code.svg"
  subdomain    = false
  share        = "owner"

  healthcheck {
    url       = "http://localhost:13337/healthz"
    interval  = 5
    threshold = 6
  }
}

resource "coder_app" "management" {
  count        = var.management.url == "" ? 0 : 1
  agent_id     = coder_agent.main.id
  slug         = "management"
  display_name = "Management"
  url          = var.management.url
  icon         = var.management.icon
  subdomain    = false
  share        = "owner"
}
