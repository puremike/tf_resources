import {
  to = aws_iam_policy.lambda_execution
  id = "arn:aws:iam::533267037869:policy/service-role/AWSLambdaBasicExecutionRole-5b36b1d2-6c70-46c2-a8bf-c6c64987a9c4"
}

import {
  to = aws_iam_role.lambda_execution_role
  id = "manual4terraform-role-5tsqdxxf"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_iam_policy_document" "assume_lambda_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "lambda_execution_role" {
  assume_role_policy  = data.aws_iam_policy_document.assume_lambda_role.json
  managed_policy_arns = [aws_iam_policy.lambda_execution.arn]
  name                = "manual4terraform-role-5tsqdxxf"
  path                = "/service-role/"
}

resource "aws_iam_policy" "lambda_execution" {
  name = "AWSLambdaBasicExecutionRole-5b36b1d2-6c70-46c2-a8bf-c6c64987a9c4"
  path = "/service-role/"
  policy = jsonencode({
    Statement = [{
      Action   = "logs:CreateLogGroup"
      Effect   = "Allow"
      Resource = "arn:aws:logs:eu-north-1:533267037869:*"
      }, {
      Action   = ["logs:CreateLogStream", "logs:PutLogEvents"]
      Effect   = "Allow"
      Resource = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/manual4terraform:*"]
    }]
    Version = "2012-10-17"
  })
}