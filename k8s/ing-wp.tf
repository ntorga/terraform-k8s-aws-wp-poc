#
## WordPress Ingress
#
resource "kubernetes_ingress" "kube-wp" {

  metadata {
    name = "kube-wp"
    annotations = {
      "kubernetes.io/ingress.class"                    = "nginx"
      "nginx.ingress.kubernetes.io/backend-protocol"   = "HTTP"
      "nginx.ingress.kubernetes.io/ssl-redirect"       = "false"
      "nginx.ingress.kubernetes.io/force-ssl-redirect" = "false"
    }
  }

  spec {
    rule {
      host = "blog.${var.stage-domain}"

      http {
        path {
          path = "/"
          backend {
            service_name = "kube-wp"
            service_port = 8080
          }
        }
      }
    }
  }
}
