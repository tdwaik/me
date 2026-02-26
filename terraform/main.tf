locals {
  repo_full_name = "${var.github_owner}/${var.github_repo}"

  branch_subjects = [
    for branch in var.allowed_branches :
    "repo:${local.repo_full_name}:ref:refs/heads/${branch}"
  ]

  environment_subjects = [
    for env_name in var.allowed_environments :
    "repo:${local.repo_full_name}:environment:${env_name}"
  ]

  allowed_subjects = concat(local.branch_subjects, local.environment_subjects)
}

resource "aws_s3_bucket" "site" {
  count = var.create_s3_bucket ? 1 : 0

  bucket        = var.s3_bucket_name
  force_destroy = var.s3_bucket_force_destroy
}

resource "aws_s3_bucket_versioning" "site" {
  count = var.create_s3_bucket ? 1 : 0

  bucket = aws_s3_bucket.site[0].id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "site" {
  count = var.create_s3_bucket ? 1 : 0

  bucket = aws_s3_bucket.site[0].id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "site" {
  count = var.create_s3_bucket ? 1 : 0

  bucket                  = aws_s3_bucket.site[0].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "site" {
  count = var.create_s3_bucket ? 1 : 0

  bucket = aws_s3_bucket.site[0].id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

data "aws_s3_bucket" "site_existing" {
  count  = var.create_cloudfront_distribution && !var.create_s3_bucket ? 1 : 0
  bucket = var.s3_bucket_name
}

locals {
  s3_bucket_regional_domain_name = var.create_s3_bucket ? aws_s3_bucket.site[0].bucket_regional_domain_name : data.aws_s3_bucket.site_existing[0].bucket_regional_domain_name
}

resource "aws_cloudfront_origin_access_control" "site" {
  count = var.create_cloudfront_distribution ? 1 : 0

  name                              = "${var.s3_bucket_name}-oac"
  description                       = "OAC for ${var.s3_bucket_name}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "site" {
  count = var.create_cloudfront_distribution ? 1 : 0

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Static site distribution for ${var.s3_bucket_name}"
  default_root_object = "index.html"
  price_class         = var.cloudfront_price_class

  origin {
    domain_name              = local.s3_bucket_regional_domain_name
    origin_id                = "s3-${var.s3_bucket_name}"
    origin_access_control_id = aws_cloudfront_origin_access_control.site[0].id
  }

  default_cache_behavior {
    target_origin_id       = "s3-${var.s3_bucket_name}"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    compress               = true

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

data "aws_iam_policy_document" "site_bucket_policy_cloudfront" {
  count = var.create_cloudfront_distribution ? 1 : 0

  statement {
    sid    = "AllowCloudFrontReadOnly"
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]
    resources = ["arn:aws:s3:::${var.s3_bucket_name}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.site[0].arn]
    }
  }
}

resource "aws_s3_bucket_policy" "site_cloudfront" {
  count = var.create_cloudfront_distribution ? 1 : 0

  bucket = var.s3_bucket_name
  policy = data.aws_iam_policy_document.site_bucket_policy_cloudfront[0].json
}

resource "aws_iam_openid_connect_provider" "github" {
  count = var.create_oidc_provider ? 1 : 0

  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = var.github_oidc_thumbprints
}

data "aws_iam_openid_connect_provider" "github" {
  count = var.create_oidc_provider ? 0 : 1
  url   = "https://token.actions.githubusercontent.com"
}

data "aws_cloudfront_distribution" "selected" {
  count = var.create_cloudfront_distribution || var.cloudfront_distribution_id == "" ? 0 : 1
  id    = var.cloudfront_distribution_id
}

locals {
  github_oidc_provider_arn = var.create_oidc_provider ? aws_iam_openid_connect_provider.github[0].arn : data.aws_iam_openid_connect_provider.github[0].arn
  effective_cloudfront_distribution_id = var.create_cloudfront_distribution ? aws_cloudfront_distribution.site[0].id : var.cloudfront_distribution_id
  cloudfront_domain_name               = var.create_cloudfront_distribution ? aws_cloudfront_distribution.site[0].domain_name : (var.cloudfront_distribution_id == "" ? "" : data.aws_cloudfront_distribution.selected[0].domain_name)
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    sid     = "AllowGitHubActionsAssumeRoleWithOIDC"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [local.github_oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = local.allowed_subjects
    }
  }
}

resource "aws_iam_role" "github_deploy" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "deploy" {
  statement {
    sid = "AllowBucketList"
    actions = [
      "s3:ListBucket"
    ]
    resources = ["arn:aws:s3:::${var.s3_bucket_name}"]
  }

  statement {
    sid = "AllowObjectDeployOps"
    actions = [
      "s3:DeleteObject",
      "s3:DeleteObjectVersion",
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = ["arn:aws:s3:::${var.s3_bucket_name}/*"]
  }

  dynamic "statement" {
    for_each = local.effective_cloudfront_distribution_id == "" ? [] : [1]
    content {
      sid = "AllowCloudFrontInvalidation"
      actions = [
        "cloudfront:CreateInvalidation",
        "cloudfront:GetInvalidation"
      ]
      resources = ["arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${local.effective_cloudfront_distribution_id}"]
    }
  }
}

data "aws_caller_identity" "current" {}

resource "aws_iam_policy" "deploy" {
  name   = "${var.role_name}-policy"
  policy = data.aws_iam_policy_document.deploy.json
}

resource "aws_iam_role_policy_attachment" "deploy" {
  role       = aws_iam_role.github_deploy.name
  policy_arn = aws_iam_policy.deploy.arn
}
