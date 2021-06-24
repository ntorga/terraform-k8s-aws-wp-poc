#
##
### Security Groups & ACLs
##
#

#
## EKS SG
#
resource "aws_security_group" "kube-wp-sg" {
  name        = "kube-wp-sg"
  description = "Control incoming and outgoing traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow traffic from within the VPC"
    from_port   = 0
    to_port     = 65535
    protocol    = "all"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  ingress {
    description = "Allow team to communicate via SSH to cluster"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.team-ips
  }

  ingress {
    description = "Allow HTTP communication to the world"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS communication to the world"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kube-wp-sg"
  }
}
