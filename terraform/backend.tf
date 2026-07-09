# Backend configuration for storing Terraform state remotely in S3.
#
# Bootstrapping order:
#   1. Leave this block commented out and run `terraform init` using local state.
#   2. Run `terraform apply` to create your infrastructure (including, if you
#      manage it separately, the S3 bucket + DynamoDB table for state storage).
#   3. Uncomment the `backend "s3"` block below and fill in the bucket name,
#      key, region, and lock table.
#   4. Run `terraform init -migrate-state` to migrate local state into the
#      remote S3 backend.
#
# terraform {
#   backend "s3" {
#     bucket         = "REPLACE_WITH_YOUR_TF_STATE_BUCKET"
#     key            = "portfolio-site/terraform.tfstate"
#     region         = "ap-south-1"
#     dynamodb_table = "REPLACE_WITH_YOUR_TF_LOCK_TABLE"
#     encrypt        = true
#   }
# }
