resource "aws_dynamodb_table" "pica_dev_interase_rate" {
  count            = var.environment == "dev" ? 1 : 0
  name             = "pica-${var.environment}-interase-rate"
  hash_key         = "id"
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "id"
    type = "S"
  }

}

resource "aws_dynamodb_table" "pica_dev_insurance" {
  count            = var.environment == "dev" ? 1 : 0
  name             = "pica-${var.environment}-insurance"
  hash_key         = "id"
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "id"
    type = "S"
  }

}

resource "aws_dynamodb_table" "pica_dev_customer" {
  count            = var.environment == "dev" ? 1 : 0
  name             = "pica-${var.environment}-customer"
  hash_key         = "id"
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "id"
    type = "S"
  }

}

resource "aws_dynamodb_table" "pica_dev_loans" {
  count            = var.environment == "dev" ? 1 : 0
  name             = "pica-${var.environment}-loans"
  hash_key         = "id"
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "id"
    type = "S"
  }

}