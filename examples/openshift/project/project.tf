provider "kubernetes-alpha" {
  server_side_planning = false
}

resource "kubernetes_manifest" "project_example" {
  provider = kubernetes-alpha

  open_api_path = "io.openshift.config.v1.Project"
  use_create_api = true

  manifest = {
    "apiVersion" = "project.openshift.io/v1"
    "kind" = "Project"
    "metadata" = {
      "name" = "example-project"
    }
  }
}
