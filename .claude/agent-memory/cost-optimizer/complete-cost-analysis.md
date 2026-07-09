---
name: complete-cost-analysis
description: Full cost review of portfolio-site Terraform configuration with all resources and optimization summary
metadata:
  type: project
---

**Analysis Date:** 2026-07-08

**All Cost-Incurring Resources Identified:**

1. **aws_s3_bucket** (terraform/main.tf:12-16)
   - Storage: ~$0.50/month (portfolio <50MB)
   - API requests: <$0.01/month
   - **Status:** OPTIMIZABLE — Add storage_class or lifecycle rule

2. **aws_cloudfront_distribution** (terraform/main.tf:72-110)
   - Data transfer: $0.85-2.00+/month depending on traffic (HIGHEST COST)
   - Requests: ~$0.05/month (negligible)
   - Configuration: PriceClass_200 (expensive), CachingOptimized TTL (good)
   - **Status:** URGENT OPTIMIZATION — Downgrade to PriceClass_100

3. **aws_cloudfront_origin_access_control** (terraform/main.tf:65-70)
   - Cost: None (control plane only)

4. **Backend S3 (commented out, terraform/backend.tf)**
   - If implemented: ~$1-2/month for state storage + DynamoDB locking
   - **Status:** Not yet deployed; low priority

**Resources NOT present (no cost concern):**
- No custom domain (no Route53 costs)
- No custom SSL cert (using CloudFront default)
- No WAF rules
- No Lambda@Edge
- No additional cache behaviors

**Total Estimated Monthly Cost (Current):** $1.50-2.50/month
**Estimated Monthly Cost (After PriceClass_100):** $1.00-1.50/month
**Estimated Savings:** $3-15/month depending on traffic

**Primary Optimization:** PriceClass_200 → PriceClass_100 (HIGH impact)
**Secondary Optimization:** Standard → Intelligent-Tiering (LOW impact but zero-cost change)

**No other cost optimizations recommended.** Site is already well-configured for a static portfolio.
