---
name: terraform-stack-overview
description: Structure and baseline security posture of the terraform/ directory for this static portfolio site (S3+CloudFront)
metadata:
  type: project
---

The `terraform/` directory provisions a static HTML/CSS portfolio site on AWS: one S3 bucket (`aws_s3_bucket.site`) served through CloudFront via Origin Access Control (OAC, not legacy OAI). Files: `main.tf` (all resources), `providers.tf`, `variables.tf`, `outputs.tf`, `backend.tf`.

Baseline security posture as of 2026-07-08 (good — do not re-flag these as issues unless the code changes):
- `aws_s3_bucket_public_access_block.site` blocks all four public-access vectors.
- `aws_s3_bucket_ownership_controls.site` uses `BucketOwnerEnforced` (ACLs disabled entirely).
- Bucket policy (`data.aws_iam_policy_document.site`) grants `s3:GetObject` only to the `cloudfront.amazonaws.com` service principal, scoped with an `AWS:SourceArn` condition to the specific distribution ARN — correctly scoped, no wildcard principal.
- CloudFront uses `aws_cloudfront_origin_access_control` (OAC) correctly, and `viewer_protocol_policy = "redirect-to-https"` enforces HTTPS.

No IAM roles/policies or OIDC trust resources exist anywhere in `terraform/` — there is nothing here to audit for the IAM/OIDC checklist items. If a GitHub Actions deploy role exists, it is managed outside this terraform directory (check `.github/workflows/` — none existed as of last audit) and should eventually be brought under Terraform per the project's "no manual AWS changes" convention ([[recurring_terraform_gaps]]).

`backend.tf` intentionally ships with the `backend "s3"` block commented out for bootstrap ordering reasons (documented inline) — local state is expected until the user manually migrates. Don't flag this as a surprising oversight; it's a deliberate bootstrap step, but the resulting local-state risk is still worth noting each audit until migration happens.
