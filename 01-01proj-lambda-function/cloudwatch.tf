import {
  to = aws_cloudwatch_log_group.lambda_group
  id = "/aws/lambda/manual4terraform"
}

resource "aws_cloudwatch_log_group" "lambda_group" {
  log_group_class = "STANDARD"
  name            = "/aws/lambda/manual4terraform"
}
