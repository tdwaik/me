# AWS GitHub OIDC Deploy Role (Terraform)

Creates:
- GitHub OIDC provider (optional, one per AWS account)
- IAM role trusted by GitHub Actions OIDC tokens for specific repo/branches
- IAM policy for S3 deploy and optional CloudFront invalidation

## 1) Configure inputs

```powershell
cd terraform
```

Edit `vars/prod.tfvars`:
- `github_owner`
- `github_repo`
- `s3_bucket_name`
- optional `cloudfront_distribution_id`
- optional `site_domain` (for example `thaer.dev`)
- optional `www_domain` (for example `www.thaer.dev`)

If your AWS account already has the GitHub OIDC provider:
- set `create_oidc_provider = false`

## 2) Apply

```powershell
terraform init
terraform plan -var-file=vars/prod.tfvars
terraform apply -var-file=vars/prod.tfvars
```

## 3) Wire outputs into GitHub repo

- Secret `AWS_DEPLOY_ROLE_ARN` = output `aws_deploy_role_arn`
- Variable `AWS_S3_BUCKET` = output `aws_s3_bucket_variable`
- Optional variable `AWS_CLOUDFRONT_DISTRIBUTION_ID` = output `aws_cloudfront_distribution_variable`

## 4) Cloudflare DNS for custom domain

If `cloudfront_distribution_id` is set, Terraform also outputs DNS targets for Cloudflare.

Create the following DNS records in Cloudflare (proxied):
- `cloudflare_apex_record_name` -> `cloudflare_apex_record_target` (CNAME)
- `cloudflare_www_record_name` -> `cloudflare_www_record_target` (CNAME)

Notes:
- For apex (`thaer.dev`), Cloudflare supports CNAME flattening.
- Keep SSL/TLS mode in Cloudflare as `Full (strict)` when your origin cert is valid.
