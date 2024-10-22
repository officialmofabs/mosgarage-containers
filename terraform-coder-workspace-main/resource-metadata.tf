data "coder_workspace" "me" {}
data "coder_provisioner" "me" {}
data "coder_workspace_owner" "me" {}

resource "coder_metadata" "pod_info" {
  count       = data.coder_workspace.me.start_count
  resource_id = kubernetes_pod.main[0].id

  dynamic "item" {
    # If the workspace has TCP ports, show the hostname in the pod information
    for_each = length(local.pod_ports) > 0 ? [1] : []
    content {
      key   = "hostname"
      value = kubernetes_service.service[0].metadata[0].name
    }
  }
}

resource "coder_metadata" "service_info" {
  count       = length(local.pod_ports) > 0 ? data.coder_workspace.me.start_count : 0
  resource_id = kubernetes_service.service[0].id
  hide        = true
}
