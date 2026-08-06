terraform {
  backend "s3" {
    bucket         = "pwabuthu-terraform-state"
    key            = "security-monitoring/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}
