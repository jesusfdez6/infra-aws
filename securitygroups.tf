resource "aws_security_group" "pica_lambda_sg" {
  name        = "pica-lambda-sg"
  description = "Security group for Lambda in public subnet"
  vpc_id      = aws_vpc.pica.id



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}