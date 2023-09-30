data "aws_partition" "current" {}

resource "aws_iam_openid_connect_provider" "oidc_provider" {
    client_id_list  = ["sts.${data.aws_partition.current.dns_suffix}"]
    # client_id_list = "sts.amazonaws.com"
    # thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
    thumbprint_list = var.thumbprint_list
    url             = aws_eks_cluster.sta_cluster.identity[0].oidc[0].issuer
}

# output "aws_iam_openid_connect_provider_arn" {
#   description = "AWS IAM Open ID Connect Provider ARN"
#   value       = aws_iam_openid_connect_provider.oidc_provider.arn
# }

locals {
  aws_iam_oidc_connect_provider_extract_from_arn = element(split("oidc-provider/", "${aws_iam_openid_connect_provider.oidc_provider.arn}"), 1)
}

# output "aws_iam_openid_connect_provider_extract_from_arn" {
#   description = "AWS IAM Open ID Connect Provider extract from ARN"
#   value       = local.aws_iam_oidc_connect_provider_extract_from_arn
# }