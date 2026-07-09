---
name: static-site-patterns
description: Cost patterns for static HTML/CSS sites: storage is negligible, CloudFront price class is primary lever, caching is already optimized
metadata:
  type: reference
---

**Static site cost structure:**
- S3 storage: ~$0.50/month for typical portfolio (<50MB) — negligible
- CloudFront data transfer: $0.085/GB for PriceClass_100, $0.120+/GB for PriceClass_200 (varies by edge) — this is the primary cost
- CloudFront request: $0.0075/10k requests (negligible)
- Origin requests to S3: Only cache misses, easily <1% of traffic if TTL >300s — negligible

**Optimization priorities (for static sites):**
1. **Price class** (HIGH impact: 30-40% savings) — downgrade if geographic distribution permits
2. **Storage class** (LOW impact: 20-30% savings on storage but storage is tiny) — use Intelligent-Tiering or cheaper tiers if available
3. **Caching TTL** (MEDIUM impact if TTL is low) — use high TTL (1-30 days) for content rarely changes; managed policies like CachingOptimized already do this
4. **Data transfer patterns** — for static content, consider pre-compression (gzip/brotli headers set by CloudFront automatically)

**Not worth optimizing:**
- Request costs (cloudfront/S3 API) — negligible
- Lifecycle rules for versioning — unnecessary unless actively versioning content
- Object metadata — doesn't affect cost
