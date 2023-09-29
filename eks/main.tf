# role creation for eks
resource "aws_iam_role" "eks_master_role" {
  name = "eks-master-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_master_role.name
}

resource "aws_iam_role_policy_attachment" "eks_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_master_role.name
}

# eks cluster creation 

resource "aws_eks_cluster" "eks_cluster" {
  name = "eks-cluster"
  role_arn = aws_iam_role.eks_master_role.arn
  version  = var.my_version

  # security_groups  = [var.app_server_security_group_id]
  vpc_config {
    subnet_ids  = [var.private_app_subnet_az1_id, var.private_app_subnet_az2_id]
    endpoint_private_access = false
    endpoint_public_access  = true
    # public_access_cidrs     = ["0.0.0.0/0"]
    public_access_cidrs     = var.public_access_cidrs1
  }

kubernetes_network_config {
    # service_ipv4_cidr = "172.20.0.0/16"
    service_ipv4_cidr = var.service_ipv4
  }

# Enable EKS Cluster Control Plane Logging
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  depends_on = [
    aws_iam_role_policy_attachment.eks_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks_AmazonEKSVPCResourceController,
  ]
}