provider "kubernetes-alpha" {
  server_side_planning = false
  config_path = "~/.kube/config"
}

resource "kubernetes_manifest" "route_example" {
  provider = kubernetes-alpha

  open_api_path = "com.github.openshift.api.route.v1.Route"

  manifest = {
    "apiVersion" = "route.openshift.io/v1"
    "kind" = "Route"
    "metadata" = {
      "name" = "example-route"
      "namespace" = "default"
    }
    "spec" = {
      "path" = ""
      "port" = {
        "targetPort" = "api-server"
      }
      "tls" = {
        "termination" = "passthrough"
      }
      "to" = {
        "kind" = "Service"
        "name" = "example-service"
      }
    }
  }
}
