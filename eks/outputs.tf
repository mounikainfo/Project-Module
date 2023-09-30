# eks iam output variables
output "cluster_id" {
  description = "The name/id of the EKS cluster."
  value       = aws_eks_cluster.sta_cluster.id
}

output "eks_name" {
    value = aws_eks_cluster.sta_cluster.name 
}

output "cluster_arn" {
    value = aws_eks_cluster.sta_cluster.arn
}

output "cluster_endpoint" {
    value = aws_eks_cluster.sta_cluster.endpoint
}

output "cluster_version" {
    value = aws_eks_cluster.sta_cluster.version
}



output "cluster_certificate_authority_data" {
  description = "Nested attribute containing certificate-authority-data for your cluster. This is the base64 encoded certificate data required to communicate with your cluster."
  value       = aws_eks_cluster.sta_cluster.certificate_authority[0].data
}



output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster OIDC Issuer"
  value       = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

# output "aws_iam_openid_connect_provider_arn" {
#   description = "AWS IAM Open ID Connect Provider ARN"
#   value       = aws_iam_openid_connect_provider.oidc_provider1.arn
# }


output  "identity"  { 
  value = aws_eks_cluster.sta_cluster.identity[0].oidc[0].issuer
}

output "thumb" {
  value = aws_iam_openid_connect_provider.oidc_provider1
}


output "identity_all" {
  value = aws_eks_cluster.sta_cluster.identity
}

# output "aws_iam_openid_connect_provider_extract_from_arn" {
#   description = "AWS IAM Open ID Connect Provider extract from ARN"
#   value       = local.aws_iam_oidc_connect_provider_extract_from_arn
# }