resource "aws_sfn_state_machine" "pica_pro_preaproved_machine" {
  count    = var.environment == "pro" ? 1 : 0
  name     = "machine-${var.environment}-preaproved"
  role_arn = aws_iam_role.step_role.arn # Ajusta con el ARN de tu rol IAM
  type     = "EXPRESS"
  lifecycle {
    ignore_changes = [definition]
  }
  definition = <<DEFINITION
{
  "Comment": "A Hello World example of the Amazon States Language using a Pass state",
  "StartAt": "HelloWorld",
  "States": {
    "HelloWorld": {
      "Type": "Pass",
      "Result": "Hello, World!",
      "End": true
    }
  }
}
DEFINITION
}