resource "aws_secretsmanager_secret" "My_Secret" {
  name                    = "My_Secret"
  recovery_window_in_days = 7

  tags = {
    Project     = "EKS_Secrets_Manager",
    Environment = "Dev"
  }
}

 # Manage Secret value
resource "aws_secretsmanager_secret_version" "API_Token" {
  secret_id     = aws_secretsmanager_secret.My_Secret.id
  secret_string = random_string.random.result
}

resource "random_string" "random" {
  length           = 16
  special          = true
  override_special = "/@£$"
}