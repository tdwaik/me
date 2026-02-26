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

output "acm_certificate_arn_us_east_1" {
  description = "ACM certificate ARN used for CloudFront aliases."
  value       = local.requested_acm_certificate_arn == "" ? null : local.requested_acm_certificate_arn
}

output "acm_dns_validation_records" {
  description = "Create these CNAME records in Cloudflare, then wait for ACM to issue."
  value = var.create_acm_certificate ? [
    for dvo in aws_acm_certificate.site[0].domain_validation_options : {
      domain_name  = dvo.domain_name
      record_name  = dvo.resource_record_name
      record_type  = dvo.resource_record_type
      record_value = dvo.resource_record_value
    }
  ] : []
}
