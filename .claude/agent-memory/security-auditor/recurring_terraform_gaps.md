---
name: recurring-terraform-gaps
description: Open security gaps identified in terraform/ for the portfolio site as of the 2026-07-08 audit — recheck on future audits to see if resolved
metadata:
  type: project
---

Findings from the 2026-07-08 audit of [[terraform_stack_overview]] that were still open. Recheck these first on the next audit — if fixed, remove from this list; if still present, they're recurring and worth flagging prominently:

- No `.gitignore` anywhere in the repo root — `.terraform/` provider binaries and any future `terraform.tfstate` are at risk of being committed (state can contain bucket names/ARNs).
- `backend.tf` remote S3 backend still commented out — state is local, unencrypted, unlocked.
- No `aws_s3_bucket_server_side_encryption_configuration` on the site bucket.
- No `aws_s3_bucket_versioning` on the site bucket.
- No CloudFront `logging_config` block and no S3 access logging configured.
- No `aws_cloudfront_response_headers_policy` attached to the default cache behavior (missing CSP, X-Frame-Options, HSTS, etc.).
- `viewer_certificate` uses `cloudfront_default_certificate = true` — fine while only using the default `*.cloudfront.net` domain, but means `minimum_protocol_version` can't be pinned above the legacy default. `variable "domain_name"` is declared in `variables.tf` but unused in `main.tf`/`outputs.tf`, suggesting custom-domain support is half-wired — worth asking the user if that's planned before recommending ACM changes.

**Why:** these were flagged as MEDIUM/LOW rather than CRITICAL/HIGH because the site is a public static portfolio with no sensitive data and the bucket-policy/OAC/public-access-block fundamentals are already solid — don't over-escalate severity here relative to a site actually holding sensitive data.
**How to apply:** on future audits of this repo, check these six items first before doing a full re-read, since they're the known outstanding gaps.
