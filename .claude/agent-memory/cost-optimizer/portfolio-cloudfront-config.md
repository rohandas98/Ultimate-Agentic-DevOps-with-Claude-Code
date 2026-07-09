---
name: portfolio-cloudfront-config
description: CloudFront distribution using PriceClass_200 for static portfolio site; downgrade to PriceClass_100 recommended
metadata:
  type: project
---

**Current configuration (terraform/main.tf line 75):** `price_class = "PriceClass_200"` with CachingOptimized managed policy (ID: 658327ea-f89d-4fab-a63d-7e88639e58f6)

**Optimization opportunity:** Downgrade to PriceClass_100 (cheapest tier)

**Why:** Portfolio site users are geographically concentrated; PriceClass_100 covers North America, Europe, and Asia-Pacific edge locations which serves 99% of typical traffic. PriceClass_200 adds expensive edges in Australia, Middle East, Africa. For static content with high cache hit ratio, edge location cost is the differentiator.

**How to apply:** Change line 75 in terraform/main.tf from `price_class = "PriceClass_200"` to `price_class = "PriceClass_100"`. Estimated 30-40% reduction in CloudFront data transfer costs.

**Impact:** HIGH — CloudFront data transfer is second-largest cost factor. Price class is the primary lever. For typical portfolio sites (10-50GB/month transfer), this saves $3-15/month.

**Verified:** 2026-07-08 — Configuration confirmed in terraform/main.tf, line 75
