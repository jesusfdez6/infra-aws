
resource "aws_cognito_user_pool" "pica_dev_pool" {
  count                    = var.environment == "dev" ? 1 : 0
  name                     = "pica-${var.environment}-pool"
  auto_verified_attributes = ["email"]
  username_attributes      = ["email"]
  schema {
    attribute_data_type = "String"
    name                = "email"
    required            = true
  }
  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

}

resource "aws_cognito_user_pool_domain" "pica_dev_api_domain" {
  count        = var.environment == "dev" ? 1 : 0
  domain       = "pica-${var.environment}"
  user_pool_id = aws_cognito_user_pool.pica_dev_pool[0].id
}


resource "aws_cognito_resource_server" "pica_dev_server" {
  count        = var.environment == "dev" ? 1 : 0
  identifier   = "pica-${var.environment}-server"
  user_pool_id = aws_cognito_user_pool.pica_dev_pool[0].id
  name         = "Example Resource Server"
  scope {
    scope_name        = "read"
    scope_description = "Read access"
  }
  scope {
    scope_name        = "write"
    scope_description = "Write access"



  }
}

resource "aws_cognito_user_pool_client" "pica_dev_client" {
  count                                = var.environment == "dev" ? 1 : 0
  name                                 = "pica-${var.environment}-client"
  user_pool_id                         = aws_cognito_user_pool.pica_dev_pool[0].id
  allowed_oauth_flows                  = ["client_credentials"]
  explicit_auth_flows                  = ["ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_CUSTOM_AUTH", "ALLOW_USER_SRP_AUTH"]
  allowed_oauth_scopes                 = ["pica-${var.environment}-server/read", "pica-${var.environment}-server/write"]
  allowed_oauth_flows_user_pool_client = true
  generate_secret                      = true
  token_validity_units {
    access_token  = "hours"
    id_token      = "hours"
    refresh_token = "days"
  }
}


