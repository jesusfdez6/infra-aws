resource "aws_lambda_function" "lambda_dev_interase_rate" {
  count         = var.environment == "dev" ? 1 : 0
  function_name = "lambda-${var.environment}-interase-rate"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  s3_bucket     = "pica-hello-lambda"              # Reemplaza con el nombre de tu bucket S3
  s3_key        = "plantilla-node/hello-world.zip" # Ruta dentro del bucket al archivo ZIP
  timeout       = 120                              # Establece el tiempo de espera en 120 segundos (2 minutos)

  environment {
    variables = {
      "BASE_PATH"    = "/pica/${var.environment}/interase-rate/"
      "TABLE_DYNAMO" = "/pica/${var.environment}/interase-rate/table-dynamo"
    }
  }

  vpc_config {
    subnet_ids         = [aws_subnet.pica_subnet_private.id]
    security_group_ids = [aws_security_group.pica_lambda_sg.id]
  }
}

resource "aws_lambda_function" "lambda_dev_insurance" {
  count         = var.environment == "dev" ? 1 : 0
  function_name = "lambda-${var.environment}-insurance"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  s3_bucket     = "pica-hello-lambda"              # Reemplaza con el nombre de tu bucket S3
  s3_key        = "plantilla-node/hello-world.zip" # Ruta dentro del bucket al archivo ZIP
  timeout       = 120                              # Establece el tiempo de espera en 120 segundos (2 minutos)

  environment {
    variables = {
      "BASE_PATH"    = "/pica/${var.environment}/insurance/"
      "TABLE_DYNAMO" = "/pica/${var.environment}/insurance/table-dynamo"
    }
  }

  vpc_config {
    subnet_ids         = [aws_subnet.pica_subnet_private.id]
    security_group_ids = [aws_security_group.pica_lambda_sg.id]
  }
}

resource "aws_lambda_function" "lambda_dev_customer" {
  count         = var.environment == "dev" ? 1 : 0
  function_name = "lambda-${var.environment}-customer"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  s3_bucket     = "pica-hello-lambda"              # Reemplaza con el nombre de tu bucket S3
  s3_key        = "plantilla-node/hello-world.zip" # Ruta dentro del bucket al archivo ZIP
  timeout       = 120                              # Establece el tiempo de espera en 120 segundos (2 minutos)

  environment {
    variables = {
      "BASE_PATH"    = "/pica/${var.environment}/customer/"
      "TABLE_DYNAMO" = "/pica/${var.environment}/customer/table-dynamo"
    }
  }

  vpc_config {
    subnet_ids         = [aws_subnet.pica_subnet_private.id]
    security_group_ids = [aws_security_group.pica_lambda_sg.id]
  }
}

resource "aws_lambda_function" "lambda_dev_loans" {
  count         = var.environment == "dev" ? 1 : 0
  function_name = "lambda-${var.environment}-loans"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  s3_bucket     = "pica-hello-lambda"              # Reemplaza con el nombre de tu bucket S3
  s3_key        = "plantilla-node/hello-world.zip" # Ruta dentro del bucket al archivo ZIP
  timeout       = 120                              # Establece el tiempo de espera en 120 segundos (2 minutos)

  environment {
    variables = {
      "BASE_PATH"    = "/pica/${var.environment}/loans/"
      "TABLE_DYNAMO" = "/pica/${var.environment}/loans/table-dynamo"
    }
  }

  vpc_config {
    subnet_ids         = [aws_subnet.pica_subnet_private.id]
    security_group_ids = [aws_security_group.pica_lambda_sg.id]
  }
}

resource "aws_lambda_function" "lambda_dev_calculate" {
  count         = var.environment == "dev" ? 1 : 0
  function_name = "lambda-${var.environment}-calculate"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  s3_bucket     = "pica-hello-lambda"              # Reemplaza con el nombre de tu bucket S3
  s3_key        = "plantilla-node/hello-world.zip" # Ruta dentro del bucket al archivo ZIP
  timeout       = 120                              # Establece el tiempo de espera en 120 segundos (2 minutos)

  environment {
    variables = {
      "BASE_PATH" = "/pica/${var.environment}/calculate/"
      "MOCK"      = "/pica/${var.environment}/calculate/mock"
    }
  }

  vpc_config {
    subnet_ids         = [aws_subnet.pica_subnet_private.id]
    security_group_ids = [aws_security_group.pica_lambda_sg.id]
  }
}