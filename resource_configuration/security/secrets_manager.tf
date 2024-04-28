resource "aws_secretsmanager_secret" "My_Secret" {
  name                    = "My_Secret"
  recovery_window_in_days = 7

  tags = {
    Project     = "EKS_Secrets_Manager",
    Environment = "Dev"
  }
}

 # Manage Secret value
resource "aws_secretsmanager_secret_version" "service_user" {
  secret_id     = aws_secretsmanager_secret.My_Secret.id
  secret_string = var.api_username
}