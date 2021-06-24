#
##
### GENERAL
##
#
variable "stage" {
  default = "dev"
  type    = string
}

variable "stage-domain" {
  default = {
    dev  = "kubewp.tk"
    prod = "kubewp.com"
  }
  type = object({
    dev  = string
    prod = string
  })
}

variable "aws-region" {
  default = "us-east-1"
  type    = string
}

#
##
### EC2, EKS & K8s
##
#
variable "eks-cluster-name" {
  default = "kube-wp"
  type    = string
}

variable "wn-disk-size" {
  default = 30
  type    = number
}

variable "wn-instance-types" {
  default = {
    dev  = ["t3a.medium"]
    prod = ["m5a.2xlarge"]
  }
  type = object({
    dev  = list(string)
    prod = list(string)
  })
}

#
##
### SECURITY GROUPS & ACLS
##
#
variable "team-ips" {
  default = [
    "1.1.1.1/32",
    "8.8.8.8/32"
  ]
  type = list(string)
}

#
##
### RDS
##
#
variable "rds-instance-type" {
  default = {
    dev  = "db.t3.small"
    prod = "db.m6g.2xlarge"
  }
  type = object({
    dev  = string
    prod = string
  })
}
