# eks cluster creation 

resource "aws_eks_cluster" "sta_cluster" {
  # name = "sta_cluster"
  name = var.cluster_name
  role_arn = var.role_arn
  version  = var.cluster_version

  # security_groups  = [var.app_server_security_group_id]
  vpc_config {
    subnet_ids  = [var.private_app_subnet_az1_id, var.private_app_subnet_az2_id]
    endpoint_private_access = false
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
    security_group_ids = [var.sec]
    # security_group_ids = ["sg-0f69dfe8f34710506"]
    # public_access_cidrs     = var.public_access_cidrs1
  }

kubernetes_network_config {
    service_ipv4_cidr = "172.20.0.0/16"
    # service_ipv4_cidr = var.service_ipv4
  }

# # Enable EKS Cluster Control Plane Logging
#   enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

#   depends_on = [
#     aws_iam_role_policy_attachment.eks_AmazonEKSClusterPolicy,
#     aws_iam_role_policy_attachment.eks_AmazonEKSVPCResourceController,
#   ]
}

# node group creation

resource "aws_eks_node_group" "eks_ng_public" {
  cluster_name    = aws_eks_cluster.sta_cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  

  subnet_ids = [
    var.private_app_subnet_az1_id,
    var.private_app_subnet_az2_id
  ]

  capacity_type  = var.capacity_type
  ami_type = var.ami_type
  instance_types = var.instance_types
  disk_size = 20

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  update_config {
    max_unavailable = var.max_unavailable
  }
}


data "aws_partition" "current" {}

resource "aws_iam_openid_connect_provider" "oidc_provider" {
    client_id_list  = ["sts.${data.aws_partition.current.dns_suffix}"]
    thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
    url             = aws_eks_cluster.sta_cluster.identity[0].oidc[0].issuer
}

locals {
  aws_iam_oidc_connect_provider_extract_from_arn = element(split("oidc-provider/", "${aws_iam_openid_connect_provider.oidc_provider.arn}"), 1)
}

