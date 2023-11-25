resource "aws_iam_role" "lambda_role" {
  name = "Pica-lambda-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

}

resource "aws_iam_role" "step_role" {
  name = "pica-stepfunction-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      }
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "states.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy" "pica_stepfunction_policy" {
  name = "pica-stepfunction-policy"
  role = aws_iam_role.step_role.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "states:StartSyncExecution"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}


resource "aws_iam_policy_attachment" "lambda_execution_policy" {
  name       = "MyLambdaExecutionPolicy"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
  roles      = [aws_iam_role.lambda_role.name]
}



resource "aws_iam_policy" "lambda_execution_dynamodb_policy" {
  name        = "policy-dynamoDB"
  description = "Operaciones en la tabla de DynamoDB"
  policy      = data.aws_iam_policy_document.dynamodb_policy.json
}

resource "aws_iam_policy_attachment" "lambda_execution_dynamodb_policy" {
  name       = "policy-attachment-dynamoDB"
  policy_arn = aws_iam_policy.lambda_execution_dynamodb_policy.arn
  roles      = [aws_iam_role.lambda_role.name]
}

resource "aws_iam_policy" "lambda_parameter_access_policy" {
  name        = "lambda-parameter-access-policy"
  description = "Política que permite acceder a parámetros en Parameter Store"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = ["ssm:GetParameter",
        "ssm:GetParametersByPath"],
        Effect   = "Allow",
        Resource = "arn:aws:ssm:us-east-1:289333746714:parameter/*",
      }
    ],
  })
}

resource "aws_iam_policy_attachment" "lambda_parameter_access_attachment" {
  name       = "policy-attachment-parameters"
  policy_arn = aws_iam_policy.lambda_parameter_access_policy.arn
  roles      = [aws_iam_role.lambda_role.name]
}

resource "aws_iam_policy_attachment" "lambda_execution_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaRole"
  name       = "policy-attachment-lambda-execution"
  roles      = [aws_iam_role.step_role.name]
}

resource "aws_iam_role_policy" "step_function_logs_policy" {
  name = "step-function-logs-policy"
  role = aws_iam_role.step_role.name

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
     
    }
  ]
}
POLICY
}


