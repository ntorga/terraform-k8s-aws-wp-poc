#
## WordPress Deployment
#
resource "kubernetes_deployment" "kube-wp" {
  metadata {
    name = "kube-wp"
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "kube-wp"
      }
    }
    template {
      metadata {
        labels = {
          app = "kube-wp"
        }
      }
      spec {
        volume {
          name = "wp-content"
          persistent_volume_claim {
            claim_name = "wp-content-pvc"
          }
        }
        container {
          name  = "kube-wp"
          image = "bitnami/wordpress:latest"
          volume_mount {
            name       = "wp-content"
            mount_path = "/opt/bitnami/wordpress/wp-content/"
          }
          port {
            container_port = 8080
          }
          env {
            name  = "WORDPRESS_DATABASE_HOST"
            value = var.kubewpdb-host
          }
          env {
            name  = "WORDPRESS_DATABASE_USER"
            value = var.kubewpdb-creds.user
          }
          env {
            name  = "WORDPRESS_DATABASE_PASSWORD"
            value = var.kubewpdb-creds.pass
          }
          env {
            name  = "WORDPRESS_DATABASE_NAME"
            value = var.kubewpdb-name
          }
          env {
            name  = "WORDPRESS_SKIP_BOOTSTRAP"
            value = "yes"
          }
          env {
            name  = "WORDPRESS_DATA_TO_PERSIST"
            value = "wp-config.php"
          }
        }
      }
    }
  }
}

#
## WordPress Service
#
resource "kubernetes_service" "kube-wp" {
  metadata {
    name = "kube-wp"
  }
  spec {
    selector = {
      app = "kube-wp"
    }
    port {
      port        = 8080
      target_port = 8080
    }
  }
}
