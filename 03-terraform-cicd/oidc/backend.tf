terraform {
  backend "s3" {
    bucket         = "pwabuthu-terraform-state"
    key            = "cicd-oidc/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}
