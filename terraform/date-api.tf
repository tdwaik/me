# ── DynamoDB ─────────────────────────────────────────────────────────────────

resource "aws_dynamodb_table" "date_responses" {
  name         = "date-responses"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

# ── IAM role for Lambda ───────────────────────────────────────────────────────

resource "aws_iam_role" "date_api_lambda" {
  name = "date-api-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "sts:AssumeRole"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy" "date_api_lambda" {
  name = "date-api-lambda-policy"
  role = aws_iam_role.date_api_lambda.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect   = "Allow"
        Action   = ["dynamodb:PutItem"]
        Resource = aws_dynamodb_table.date_responses.arn
      }
    ]
  })
}

# ── Lambda ────────────────────────────────────────────────────────────────────

data "archive_file" "date_api" {
  type        = "zip"
  source_file = "${path.module}/lambda/save_date_response.js"
  output_path = "${path.module}/lambda/save_date_response.zip"
}

resource "aws_lambda_function" "date_api" {
  function_name    = "date-api-save-response"
  role             = aws_iam_role.date_api_lambda.arn
  runtime          = "nodejs22.x"
  handler          = "save_date_response.handler"
  filename         = data.archive_file.date_api.output_path
  source_code_hash = data.archive_file.date_api.output_base64sha256

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.date_responses.name
    }
  }
}

# ── HTTP API Gateway ──────────────────────────────────────────────────────────

resource "aws_apigatewayv2_api" "date_api" {
  name          = "date-api"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = ["https://thaer.dev", "http://localhost:5173"]
    allow_methods = ["POST", "OPTIONS"]
    allow_headers = ["content-type"]
    max_age       = 86400
  }
}

resource "aws_apigatewayv2_integration" "date_api" {
  api_id                 = aws_apigatewayv2_api.date_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.date_api.invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "date_api" {
  api_id    = aws_apigatewayv2_api.date_api.id
  route_key = "POST /response"
  target    = "integrations/${aws_apigatewayv2_integration.date_api.id}"
}

resource "aws_apigatewayv2_stage" "date_api" {
  api_id      = aws_apigatewayv2_api.date_api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_lambda_permission" "date_api" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.date_api.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.date_api.execution_arn}/*/*"
}
