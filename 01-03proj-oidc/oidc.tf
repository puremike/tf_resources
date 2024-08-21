import {
  to = aws_iam_openid_connect_provider.this
  id = var.role_arn
}

resource "aws_iam_openid_connect_provider" "this" {
  client_id_list  = [var.terraform_cloud_audience]
  thumbprint_list = [var.thumbprint_list]
  url             = var.openIDURL
  tags = {
    Name = "Terraform Cloud"
  }
}


import {
  to = aws_iam_role.this
  id = "terraform-cloud-auto-role"
}

resource "aws_iam_role" "this" {
  name                = "terraform-cloud-auto-role"
  managed_policy_arns = [var.policy_arn]
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "app.terraform.io:aud" = "aws.workload.identity"
        }
        StringLike = {
          "app.terraform.io:sub" = "organization:Scophee:project:terraform-oidc:workspace:*:run_phase:*"
        }
      }
      Effect = "Allow"
      Principal = {
        Federated = var.role_arn
      }
    }]
    Version = "2012-10-17"
  })

  tags = {
    CreatedBy = "Terraform_Cloud"
  }
}


import {
  to = aws_iam_role_policy_attachment.this
  id = "terraform-cloud-auto-role/${var.policy_arn}"
}

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = var.policy_arn
  role       = "terraform-cloud-auto-role"
}


