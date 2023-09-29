# eks iam output variables

output "cluster_iam_role_name" {
  description = "IAM role name of the EKS cluster"
  value       = aws_iam_role.eks_master_role.name
}

output "cluster_iam_role_arn" {
    value = aws_iam_role.eks_master_role.arn
}

output "policy_attach" {
    value = aws_iam_role_policy_attachment.eks_AmazonEKSClusterPolicy.name
}

output "eks_policy_attach" {
  value = aws_iam_role_policy_attachment.eks_AmazonEKSVPCResourceController.name
}


output "cluster_id" {
  description = "The name/id of the EKS cluster."
  value       = aws_eks_cluster.eks_cluster.id
}

output "eks_name" {
    value = aws_eks_cluster.eks_cluster.name 
}

output "cluster_arn" {
    value = aws_eks_cluster.eks_cluster.arn
}

output "cluster_endpoint" {
    value = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_version" {
    value = aws_eks_cluster.eks_cluster.version
}



# output "cluster_certificate_authority_data" {
#   description = "Nested attribute containing certificate-authority-data for your cluster. This is the base64 encoded certificate data required to communicate with your cluster."
#   value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
# }



# output "cluster_oidc_issuer_url" {
#   description = "The URL on the EKS cluster OIDC Issuer"
#   value       = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
# }


# # output  "identity"  { 
# #   value = aws_eks_cluster.demo.identity[0].oidc[0].issuer
# # }

# # output "thumb" {
# #   value = aws_iam_openid_connect_provider.oidc_provider
# # }