#
## Kubernetes Provider
#
provider "kubernetes" {
  host                   = var.eks-endpoint
  cluster_ca_certificate = var.eks-ca
  token                  = var.eks-token
}

#
## Helm Provider
#
provider "helm" {
  kubernetes {
    host                   = var.eks-endpoint
    cluster_ca_certificate = var.eks-ca
    token                  = var.eks-token
  }
}
