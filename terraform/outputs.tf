output "aws_deploy_role_arn" {
  description = "Set this as GitHub secret AWS_DEPLOY_ROLE_ARN."
  value       = aws_iam_role.github_deploy.arn
}

output "aws_s3_bucket_variable" {
  description = "Set this as GitHub variable AWS_S3_BUCKET."
  value       = var.s3_bucket_name
}

output "aws_cloudfront_distribution_variable" {
  description = "Set this as GitHub variable AWS_CLOUDFRONT_DISTRIBUTION_ID when used."
  value       = local.effective_cloudfront_distribution_id
}

output "github_oidc_provider_arn" {
  description = "GitHub OIDC provider ARN used in trust relationship."
  value       = local.github_oidc_provider_arn
}

output "cloudflare_apex_record_name" {
  description = "Cloudflare DNS record name for apex domain."
  value       = var.site_domain == "" ? null : var.site_domain
}

output "cloudflare_apex_record_type" {
  description = "Cloudflare DNS record type for apex domain."
  value       = var.site_domain == "" || local.cloudfront_domain_name == "" ? null : "CNAME"
}

output "cloudflare_apex_record_target" {
  description = "Cloudflare apex CNAME target (enable proxy in Cloudflare)."
  value       = var.site_domain == "" || local.cloudfront_domain_name == "" ? null : local.cloudfront_domain_name
}

output "cloudflare_www_record_name" {
  description = "Cloudflare DNS record name for www domain."
  value       = var.www_domain == "" ? null : var.www_domain
}

output "cloudflare_www_record_type" {
  description = "Cloudflare DNS record type for www domain."
  value       = var.www_domain == "" || local.cloudfront_domain_name == "" ? null : "CNAME"
}

output "cloudflare_www_record_target" {
  description = "Cloudflare www CNAME target (enable proxy in Cloudflare)."
  value       = var.www_domain == "" || local.cloudfront_domain_name == "" ? null : local.cloudfront_domain_name
}

output "cloudfront_distribution_domain_name" {
  description = "CloudFront domain name."
  value       = local.cloudfront_domain_name
}
