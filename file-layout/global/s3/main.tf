provider "aws" {
    region = "us-east-2"
}

# terraform {
#   backend "s3" {
#     bucket = "riccardo-la-torre-tf-state"
#     key = "global/s3/terraform.tfstate"
#     region = "us-east-2"
#     dynamodb_table = "tf-locks"
#     encrypt = true
#   }
# }

resource "aws_s3_bucket" "terraform_state" {
    bucket = "riccardo-la-torre-tf-state"
    lifecycle {
        prevent_destroy = false
    }
    versioning {
        enabled = true
    }
    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
              sse_algorithm = "AES256"
            }
        }
    }        
}

resource "aws_dynamodb_table" "terraform_locks" {
    name = "tf-locks"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
    attribute {
      name = "LockID"
      type = "S"
    }
}
