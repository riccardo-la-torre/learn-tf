provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket = "riccardo-la-torre-tf-state"
    key = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "tf-locks"
    encrypt = true
  }
}

resource "aws_db_instance" "example" {
    identifier_prefix = "terraform-up-and-running"
    engine = "mysql"
    allocated_storage = 10
    instance_class = "db.t2.micro"
    name = "example_database"
    apply_immediately = true
    backup_retention_period = 0
    skip_final_snapshot = true
    username = "admin"
    password = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string)["mysql-master-password-stage"]
}

data "aws_secretsmanager_secret_version" "db_password" {
    secret_id = "mysql-master-password-stage"
}
