aws_region = "us-west-2"

github_owner = "tdwaik"
github_repo  = "me"

allowed_branches     = ["main", "master"]
allowed_environments = []

create_oidc_provider = true
role_name            = "github-actions-deployer-prod"

s3_bucket_name             = "thaer-me"
create_s3_bucket           = true
s3_bucket_force_destroy    = false
create_cloudfront_distribution = true
cloudfront_distribution_id = ""

site_domain = "thaer.dev"
www_domain  = "www.thaer.dev"

github_oidc_thumbprints = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
