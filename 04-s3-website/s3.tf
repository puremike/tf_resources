resource "random_id" "bucket_suffix" {
  byte_length = 5
}

resource "aws_s3_bucket" "static-web-s3" {
  bucket = "terra-web-s3-${random_id.bucket_suffix.hex}"
}

resource "aws_s3_bucket_public_access_block" "static-web-s3" {
  bucket                  = aws_s3_bucket.static-web-s3.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# resource "aws_s3_bucket_policy" "static-web-s3-bucket-policy" {
#   bucket = aws_s3_bucket.static-web-s3.id
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Sid        = "Public Read Get Object"
#         Effect     = "Allow"
#         Principals = "*"
#         Action     = "s3:GetObject"
#         Resource   = "${aws_s3_bucket.static-web-s3.arn}/*"
#       }
#     ]
#   })
# }

resource "aws_s3_bucket_website_configuration" "static-web-s3" {
  bucket = aws_s3_bucket.static-web-s3.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.static-web-s3.id
  key          = "index.html"
  source       = "build/index.html"
  etag         = filemd5("build/index.html")
  content_type = "text/html"
}

resource "aws_s3_object" "error_html" {
  bucket       = aws_s3_bucket.static-web-s3.id
  key          = "error.html"
  source       = "build/error.html"
  etag         = filemd5("build/error.html")
  content_type = "text/html"
}