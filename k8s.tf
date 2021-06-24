#
##
### K8S
##
#
module "k8s" {
  source            = "./k8s"
  eks-endpoint      = data.aws_eks_cluster.eks-cluster.endpoint
  eks-ca            = base64decode(data.aws_eks_cluster.eks-cluster.certificate_authority.0.data)
  eks-token         = data.aws_eks_cluster_auth.eks-cluster.token
  eks-cluster-name  = var.eks-cluster-name
  stage             = var.stage
  stage-domain      = var.stage-domain[var.stage]
  aws-region        = var.aws-region
  security-group-id = aws_security_group.kube-wp-sg.id
  kubewpdb-host     = module.kubewpdb.endpoint
  kubewpdb-name     = local.kubewpdb-name
  kubewpdb-creds    = local.kubewpdb-creds
  efs-wp-content-id = module.efs-wp-content.id
}
