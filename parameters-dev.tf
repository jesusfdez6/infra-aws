resource "aws_ssm_parameter" "pica_dev_rate_table" {
  count       = var.environment == "dev" ? 1 : 0
  name        = "/pica/${var.environment}/interase-rate/table-dynamo"
  description = "Nombre de la tabla de tasas"
  type        = "String"
  value       = aws_dynamodb_table.pica_dev_interase_rate[0].name
}

resource "aws_ssm_parameter" "pica_dev_insurance_table" {
  count       = var.environment == "dev" ? 1 : 0
  name        = "/pica/${var.environment}/insurance/table-dynamo"
  description = "Nombre de la tabla de seguros"
  type        = "String"
  value       = aws_dynamodb_table.pica_dev_insurance[0].name
}

resource "aws_ssm_parameter" "pica_dev_customer_table" {
  count       = var.environment == "dev" ? 1 : 0
  name        = "/pica/${var.environment}/customer/table-dynamo"
  description = "Nombre de la tabla de clientes"
  type        = "String"
  value       = aws_dynamodb_table.pica_dev_customer[0].name
}

resource "aws_ssm_parameter" "pica_dev_loans_table" {
  count       = var.environment == "dev" ? 1 : 0
  name        = "/pica/${var.environment}/loans/table-dynamo"
  description = "Nombre de la tabla de pre aprobados"
  type        = "String"
  value       = aws_dynamodb_table.pica_dev_loans[0].name
}


resource "aws_ssm_parameter" "pica_dev_calculate_mock" {
  count       = var.environment == "dev" ? 1 : 0
  name        = "/pica/${var.environment}/calculate/mock"
  description = "mock de servicio"
  type        = "String"
  value       = 1
}