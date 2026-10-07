data "aws_secretsmanager_secret" "flask" {
  name = var.secret_name
}

data "aws_secretsmanager_secret_version" "flask" {
  secret_id = data.aws_secretsmanager_secret.flask.id
}


