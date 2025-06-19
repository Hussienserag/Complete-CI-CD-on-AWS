# Backup Plan Resource 

# Create backup vault first
resource "aws_backup_vault" "my_backup_vault" {
  name        = "my-backup-vault"
  kms_key_arn = aws_kms_key.backup_key.arn
  
  tags = {
    Name        = "ITI-Backup-Vault"
    Environment = "production"
    Project     = "ITI-ecommerce"
  }
}

# Create KMS key for backup vault encryption
resource "aws_kms_key" "backup_key" {
  description             = "KMS key for backup vault encryption"
  deletion_window_in_days = 7
  
  tags = {
    Name        = "ITI-Backup-Key"
    Environment = "production"
    Project     = "ITI-ecommerce"
  }
}

resource "aws_backup_plan" "my_back_plan" {
  name = "my-backup-plan"

  rule {
    rule_name         = "my-backup-rule"
    target_vault_name = aws_backup_vault.my_backup_vault.name
    schedule          = "cron(35 19 * * ? *)"
    completion_window = 120

    lifecycle {
      delete_after = 14
    }
  }
}