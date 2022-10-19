resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "${var.department}-tf-locks"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    "ManagedBy" = "Terraform"
    "Project"   = "Department bootstrap"
    "Department"     = var.department
  }
}