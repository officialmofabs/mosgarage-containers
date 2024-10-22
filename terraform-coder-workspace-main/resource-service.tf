resource "kubernetes_service" "service" {
  count = length(local.pod_ports) > 0 ? data.coder_workspace.me.start_count : 0

  metadata {
    name      = "${var.workspace.type}-${lower(data.coder_workspace_owner.me.name)}-${lower(data.coder_workspace.me.name)}"
    namespace = var.coder.namespace
    labels = {
      "app.kubernetes.io/name"       = local.app_name
      "app.kubernetes.io/instance"   = local.app_instance
      "app.kubernetes.io/part-of"    = local.app_part_of
      "app.kubernetes.io/component"  = "${var.workspace.type}-service"
      "app.kubernetes.io/managed-by" = local.app_managed_by
      "app.kubernetes.io/version"    = local.app_version

      // Coder specific labels
      "com.coder.resource"       = "true"
      "com.coder.workspace.id"   = data.coder_workspace.me.id
      "com.coder.workspace.name" = data.coder_workspace.me.name
      "com.coder.user.id"        = data.coder_workspace_owner.me.id
      "com.coder.user.username"  = data.coder_workspace_owner.me.name
    }

  }
  spec {
    selector = {
      "com.coder.workspace.id" = data.coder_workspace.me.id
    }

    dynamic "port" {
      for_each = local.pod_ports

      content {
        name        = "port-${port.value}"
        port        = port.value
        target_port = port.value
      }
    }

    type = "ClusterIP"
  }
}
