terraform {
  required_providers {
    coder = {
      source = "coder/coder"
      version = "1.0.2"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}
