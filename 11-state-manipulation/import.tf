resource "aws_s3_bucket" "remote_state" {
  bucket = "bucket_nademsaed"

  tags = {
    ManagedBy = "Terraform"
  }
}

import {
  to = aws_s3_bucket_public_access_block.remote_state
  id = aws_s3_bucket.remote_state.bucket
}

resource "aws_s3_bucket_public_access_block" "remote_state" {
  bucket = aws_s3_bucket.remote_state.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# terraform state rm [options] ADDRESS...