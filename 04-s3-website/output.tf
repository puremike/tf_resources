output "s3-static-website-endpoint" {
  value = aws_s3_bucket_website_configuration.static-web-s3.website_endpoint
}