#
## NGINX Ingress Controller Chart
#
resource "helm_release" "nginx_ingress" {
  name = "ingress-nginx"

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"

  values = [file("k8s/ingress-controller-values.yaml")]

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-security-groups"
    value = var.security-group-id
    type  = "string"
  }
}

# BEGIN - Uncomment after first deploy
#data "kubernetes_service" "ingress-nginx-controller" {
#  metadata {
#    name = "ingress-nginx-controller"
#  }
#  depends_on = [kubernetes_ingress.kube-wp]
#}

#output "lb-hostname" {
#  value      = data.kubernetes_service.ingress-nginx-controller.status.0.load_balancer.0.ingress.0.hostname
#  depends_on = [kubernetes_ingress.kube-wp]
#}
# END - Uncomment after first deploy
