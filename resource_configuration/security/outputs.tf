output "secrets_manager_arn" {
  value = aws_secretsmanager_secret.My_Secret.arn
}