provider "kubernetes-alpha" {
  server_side_planning = false
}

resource "kubernetes_manifest" "datavolume_example" {
  provider = kubernetes-alpha

  open_api_path = "io.kubevirt.cdi.v1alpha1.DataVolume"
  
  manifest = {               
    "apiVersion" = "cdi.kubevirt.io/v1alpha1"
    "kind" = "DataVolume"    
    "metadata" = {           
      "name" = "example-dv"
      "namespace" = "default"
    } 
    "spec" = {
      "pvc" = {
        "accessModes" = [    
          "ReadWriteMany",   
        ]
        "resources" = {      
          "requests" = {     
            "storage" = "10Gi"
          }
        }
      }
      "source" = {
        "http" = {           
          "url" = "https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2"
        }
      }
    }
  }
}
