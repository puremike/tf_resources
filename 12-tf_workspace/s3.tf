resource "random_id" "bucket_suffix" {
  byte_length = 4
}

/*
dev     -> 1 bucket
int     -> 1 bucket
staging -> 2 buckets
prod    -> 3 buckets
*/

resource "aws_s3_bucket" "this" {
  count  = var.bucket_count
  bucket = "workspaces-demo-${terraform.workspace}-${count.index}-${random_id.bucket_suffix.hex}"
}


# Create a new folder to place the files of this section. Configure the Terraform required version and required providers, as well as the AWS provider region.

# Run terraform workspace -help, and have a look through the documentation around CLI workspaces.

# Run terraform workspace show and inspect which workspace we are working with.

# Run terraform workspace list to list all the available workspaces.

# terraform workspace -help