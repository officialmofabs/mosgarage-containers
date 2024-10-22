resource "kubernetes_pod" "main" {
  count = data.coder_workspace.me.start_count

  metadata {
    name      = "${var.workspace.type}-${lower(data.coder_workspace_owner.me.name)}-${lower(data.coder_workspace.me.name)}"
    namespace = var.coder.namespace
    labels = merge({
      "app.kubernetes.io/name"       = local.app_name
      "app.kubernetes.io/instance"   = local.app_instance
      "app.kubernetes.io/part-of"    = local.app_part_of
      "app.kubernetes.io/component"  = var.workspace.type
      "app.kubernetes.io/managed-by" = local.app_managed_by
      "app.kubernetes.io/version"    = local.app_version

      // Coder specific labels
      "com.coder.resource"       = "true"
      "com.coder.workspace.id"   = data.coder_workspace.me.id
      "com.coder.workspace.name" = data.coder_workspace.me.name
      "com.coder.user.id"        = data.coder_workspace_owner.me.id
      "com.coder.user.username"  = data.coder_workspace_owner.me.name
    }, var.pod.labels)
    annotations = merge({ "com.coder.user.email" = data.coder_workspace_owner.me.email }, var.pod.annotations)
  }

  spec {
    dynamic "image_pull_secrets" {
      for_each = var.image.pull_secrets != "" ? [1] : []
      content {
        name = var.image.pull_secrets
      }
    }

    container {
      name              = "main"
      image             = "${var.image.name}:${var.image.tag}"
      image_pull_policy = "Always"
      command           = ["sh", "-c", replace(local.init_script, "sleep 30", "sleep 5")]

      security_context {
        run_as_user = "1000"
        privileged  = var.pod.privileged
      }

      env {
        name  = "CODER_AGENT_TOKEN"
        value = coder_agent.main.token
      }

      env {
        name  = "CODER_SESSION_TOKEN"
        value = data.coder_workspace_owner.me.session_token
      }

      # NFS related environment variables
      dynamic "env" {
        for_each = var.nfs.enabled ? local.env_nfs : []
        content {
          name  = env.value.name
          value = env.value.value
        }
      }

      env {
        name  = "CODER_URL"
        value = var.coder.url
      }

      env {
        name  = "WORKSPACE_NAME"
        value = lower(data.coder_workspace.me.name)
      }

      env {
        name  = "WORKSPACE_ID"
        value = lower(data.coder_workspace.me.id)
      }

      dynamic "port" {
        for_each = local.pod_ports

        content {
          container_port = port.value
          name           = "port-${port.value}"
          protocol       = "TCP"
        }
      }

      resources {
        requests = {
          cpu    = var.resources.request_cpu
          memory = var.resources.request_memory
        }
        limits = {
          cpu    = var.resources.limit_cpu
          memory = var.resources.limit_memory
        }
      }

      dynamic "volume_mount" {
        for_each = (var.nfs.enabled && var.nfs.mount_user) ? [1] : []
        content {
          name       = "nfs"
          sub_path   = "users/${data.coder_workspace_owner.me.name}"
          mount_path = var.nfs.user
        }
      }

      dynamic "volume_mount" {
        for_each = (var.nfs.enabled && var.nfs.mount_common) ? [1] : []
        content {
          name       = "nfs"
          sub_path   = "common"
          mount_path = var.nfs.common
          read_only  = true
        }
      }

      dynamic "volume_mount" {
        for_each = (var.nfs.enabled && var.nfs.mount_root) ? [1] : []
        content {
          name       = "nfs"
          mount_path = "${var.nfs.root}/root"
          read_only  = false
        }
      }

      dynamic "volume_mount" {
        for_each = (var.nfs.enabled && var.nfs.path != "") ? [1] : []
        content {
          name       = "nfs"
          sub_path   = "users/${data.coder_workspace_owner.me.name}/${var.workspace.class}/${data.coder_workspace.me.name}/${var.nfs.sub}"
          mount_path = var.nfs.path
        }
      }

      dynamic "volume_mount" {
        for_each = var.aws.use_token ? [1] : []
        content {
          name       = "aws-iam-token"
          mount_path = "/var/run/secrets/eks.amazonaws.com/serviceaccount"
          read_only  = true
        }
      }
    }

    dynamic "volume" {
      for_each = var.nfs.enabled ? [1] : []
      content {
        name = "nfs"
        persistent_volume_claim {
          claim_name = var.nfs.claim_name
        }
      }
    }

    dynamic "volume" {
      for_each = var.aws.use_token ? [1] : []
      content {
        name = "aws-iam-token"
        projected {
          sources {
            service_account_token {
              audience           = "sts.amazonaws.com"
              expiration_seconds = 86400
              path               = "token"
            }
          }
        }
      }
    }

    affinity {
      dynamic "node_affinity" {
        for_each = length(var.pod.node_group) > 0 ? [1] : []
        content {
          required_during_scheduling_ignored_during_execution {
            node_selector_term {
              match_expressions {
                key      = "node.kubernetes.io/node-group"
                operator = "In"
                values   = var.pod.node_group
              }
            }
          }
        }
      }
    }
  }
}
