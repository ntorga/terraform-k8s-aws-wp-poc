#
## wp-content Persistent Volume
#
resource "kubernetes_persistent_volume_claim" "wp-content" {
  metadata {
    name = "wp-content-pvc"
  }
  spec {
    access_modes       = ["ReadWriteMany"]
    storage_class_name = "efs-sc"
    resources {
      requests = {
        storage = "10Gi"
      }
    }
  }
  depends_on = [
    helm_release.aws-efs-csi-driver
  ]
}

#
## EFS Storage Class
#
resource "kubernetes_storage_class" "efs-sc" {
  metadata {
    name = "efs-sc"
  }
  storage_provisioner = "efs.csi.aws.com"
  parameters = {
    provisioningMode = "efs-ap"
    fileSystemId     = var.efs-wp-content-id
    directoryPerms   = 700
  }
  depends_on = [
    helm_release.aws-efs-csi-driver
  ]
}
