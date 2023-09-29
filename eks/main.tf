# eks cluster creation 

resource "aws_eks_cluster" "sta_cluster" {
  name = var.cluster_name
  role_arn = var.role_arn
  version  = var.cluster_version

  # security_groups  = [var.app_server_security_group_id]
  vpc_config {
    subnet_ids  = [var.private_app_subnet_az1_id, var.private_app_subnet_az2_id]
    endpoint_private_access = false
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
    security_groups = aws_security_group.app_server_security_group.id
    # public_access_cidrs     = var.public_access_cidrs1
  }

kubernetes_network_config {
    service_ipv4_cidr = "172.20.0.0/16"
    # service_ipv4_cidr = var.service_ipv4
  }

# Enable EKS Cluster Control Plane Logging
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  depends_on = [
    aws_iam_role_policy_attachment.eks_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks_AmazonEKSVPCResourceController,
  ]
}

