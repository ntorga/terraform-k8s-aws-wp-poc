#
##
### EKS
##
#
data "aws_eks_cluster" "eks-cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "eks-cluster" {
  name = module.eks.cluster_id
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "14.0.0"

  cluster_name    = var.eks-cluster-name
  cluster_version = "1.18"
  subnets         = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  node_groups = {
    alpha = {
      desired_capacity = 1
      max_capacity     = 3
      min_capacity     = 1
      disk_size        = var.wn-disk-size
      instance_types   = var.wn-instance-types[var.stage]
      subnets          = [module.vpc.private_subnets[0]]
    }

    beta = {
      desired_capacity = 1
      max_capacity     = 3
      min_capacity     = 1
      disk_size        = var.wn-disk-size
      instance_types   = var.wn-instance-types[var.stage]
      subnets          = [module.vpc.private_subnets[1]]
    }

    gamma = {
      desired_capacity = 1
      max_capacity     = 3
      min_capacity     = 1
      disk_size        = var.wn-disk-size
      instance_types   = var.wn-instance-types[var.stage]
      subnets          = [module.vpc.private_subnets[2]]
    }
  }
  workers_additional_policies = ["arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess"]

  write_kubeconfig   = true
  config_output_path = "./"
}
