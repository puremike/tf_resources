output "bucket" {
  value       = aws_s3_bucket.project_bucket.bucket
  description = "Bucket name"
#   sensitive = true
}
# To retrieve the output value outside terraform, run the command "terraform output <output name>". In our case, this would be "terraform output s3_bucket_name"