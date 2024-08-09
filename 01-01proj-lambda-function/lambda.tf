import {
  to = aws_lambda_function.this
  id = "manual4terraform"
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.root}/build/index.mjs"
  output_path = "${path.root}/lambda_fn_payload.zip"
}


resource "aws_lambda_function" "this" {
  description      = "Lambda function - Terraform"
  filename         = "lambda_fn_payload.zip"
  function_name    = "manual4terraform"
  handler          = "index.handler"
  role             = "arn:aws:iam::533267037869:role/service-role/manual4terraform-role-5tsqdxxf"
  runtime          = "nodejs20.x"
  source_code_hash = data.archive_file.lambda.output_base64sha256

  tags = {
    "lambda-console:blueprint" = "hello-world"
  }

  logging_config {
    log_format = "Text"
    log_group  = aws_cloudwatch_log_group.lambda_group.name
  }
}

resource "aws_lambda_function_url" "this" {
  function_name      = aws_lambda_function.this.function_name
  authorization_type = "NONE"
}