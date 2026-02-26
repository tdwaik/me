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
  count = var.cloudfront_distribution_id == "" ? 0 : 1
  id    = var.cloudfront_distribution_id
}

locals {
  github_oidc_provider_arn = var.create_oidc_provider ? aws_iam_openid_connect_provider.github[0].arn : data.aws_iam_openid_connect_provider.github[0].arn
  cloudfront_domain_name   = var.cloudfront_distribution_id == "" ? "" : data.aws_cloudfront_distribution.selected[0].domain_name
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
    for_each = var.cloudfront_distribution_id == "" ? [] : [1]
    content {
      sid = "AllowCloudFrontInvalidation"
      actions = [
        "cloudfront:CreateInvalidation",
        "cloudfront:GetInvalidation"
      ]
      resources = ["arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${var.cloudfront_distribution_id}"]
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
