---
name: portfolio-s3-storage
description: S3 bucket for portfolio site using Standard storage class without lifecycle rules; Intelligent-Tiering recommended
metadata:
  type: project
---

**Current configuration (terraform/main.tf lines 12-16):** Standard storage class (default), no lifecycle rules, no versioning. Resource name: aws_s3_bucket.site

**Optimization opportunity:** Enable Intelligent-Tiering for automatic cost optimization

**Why:** Portfolio site is static, rarely updated. After initial upload, objects rarely change. Intelligent-Tiering automatically transitions objects to cheaper access tiers after 30/90 days of non-access. For a portfolio site accessed by humans (not crawled constantly), this is a natural fit.

**How to apply:** 
1. Add `storage_class = "INTELLIGENT_TIERING"` to aws_s3_bucket.site resource, or
2. Add aws_s3_bucket_intelligent_tiering_configuration resource with transitions

**Impact:** LOW — Portfolio sites typically <50MB total (few HTML + CSS files), so storage cost is ~$0.50/month. Intelligent-Tiering saves ~20-30% but floor is still <$0.15/month. Worth doing for completeness, but not a primary lever.

**Related:** [[static-site-patterns]]

**Verified:** 2026-07-08 — S3 bucket confirmed at terraform/main.tf lines 12-16, no storage_class specified
