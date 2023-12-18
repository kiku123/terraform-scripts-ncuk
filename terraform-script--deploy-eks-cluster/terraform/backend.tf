terraform {
  backend "s3" {
    bucket = "mention-the-bucket-name"
    region = "mention-the-region"
    key = "eks/terraform.tfstate"
  }
}

