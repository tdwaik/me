variable "aws_region" {
  description = "AWS region used by provider and deployment workflow."
  type        = string
  default     = "us-west-2"
}

variable "github_owner" {
  description = "GitHub organization or username that owns the repository."
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name (without owner)."
  type        = string
}

variable "allowed_branches" {
  description = "Git branches allowed to assume the role via OIDC."
  type        = list(string)
  default     = ["main", "master"]
}

variable "allowed_environments" {
  description = "Optional GitHub environments allowed to assume the role."
  type        = list(string)
  default     = []
}

variable "create_oidc_provider" {
  description = "Create the GitHub OIDC provider in this account. Set false if it already exists."
  type        = bool
  default     = true
}

variable "role_name" {
  description = "IAM role name used by GitHub Actions."
  type        = string
  default     = "github-actions-deploy-role"
}

variable "s3_bucket_name" {
  description = "S3 bucket where site assets are deployed."
  type        = string
}

variable "create_s3_bucket" {
  description = "Create the deploy S3 bucket in this Terraform stack."
  type        = bool
  default     = true
}

variable "s3_bucket_force_destroy" {
  description = "Allow Terraform to delete non-empty bucket contents on destroy."
  type        = bool
  default     = false
}

variable "cloudfront_distribution_id" {
  description = "Optional existing CloudFront distribution ID (used when not creating one here)."
  type        = string
  default     = ""
}

variable "create_cloudfront_distribution" {
  description = "Create a CloudFront distribution in this Terraform stack."
  type        = bool
  default     = true
}

variable "cloudfront_price_class" {
  description = "CloudFront price class."
  type        = string
  default     = "PriceClass_100"
}

variable "site_domain" {
  description = "Primary custom domain for the site, managed in Cloudflare (e.g. thaer.dev)."
  type        = string
  default     = ""
}

variable "www_domain" {
  description = "Optional www domain in Cloudflare (e.g. www.thaer.dev)."
  type        = string
  default     = ""
}

variable "github_oidc_thumbprints" {
  description = "Thumbprint list for the GitHub OIDC provider."
  type        = list(string)
  default     = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

variable "default_tags" {
  description = "Default AWS resource tags applied by the provider."
  type        = map(string)
  default = {
    ManagedBy   = "terraform"
    Project     = "me"
    Environment = "prod"
  }
}
