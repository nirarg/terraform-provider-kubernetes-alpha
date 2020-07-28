provider "kubernetes-alpha" {
  server_side_planning = false
}

resource "kubernetes_manifest" "virtualmachine_example" {
  provider = kubernetes-alpha

  open_api_path = "io.kubevirt.v1alpha3.VirtualMachine"

  manifest = {
    "kind" = "VirtualMachine"
    "apiVersion" = "kubevirt.io/v1alpha3"
    "metadata" = {
      "name" = "example"
      "namespace" = "default"
    }
    "spec" = {
      "running" = true
      "template" = {
        "spec" = {
          "domain" = {
            "devices" = {
              "disks" = [
                {
                  "disk" = {
                    "bus" = "virtio"
                  }
                  "name" = "containerdisk"
                },
                {
                  "disk" = {
                    "bus" = "virtio"
                  }
                  "name" = "cloudinitdisk"
                },
              ]
              "interfaces" = [
                {
                  "masquerade" = {}
                  "model" = "virtio"
                  "name" = "default"
                },
              ]
            }
            "resources" = {
              "requests" = {
                "memory" = "64M"
              }
            }
          }
          "networks" = [
            {
              "name" = "default"
              "pod" = {}
            },
          ]
          "volumes" = [
            {
              "containerDisk" = {
                "image" = "kubevirt/cirros-registry-disk-demo"
              }
              "name" = "containerdisk"
            },
            {
              "cloudInitNoCloud" = {
                "userDataBase64" = "SGkuXG4="
              }
              "name" = "cloudinitdisk"
            },
          ]
        }
      }
    }
  }
}
