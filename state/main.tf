provider "aws" {
    region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket = "riccardo-la-torre-tf-state"
    key = "workspaces-example/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "tf-locks"
    encrypt = true
  }
}

resource "aws_instance" "example" {
  ami = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
