#resource "aws_s3_bucket" "bkt" {
#  bucket = var.BUCKET_NAME
#  acl    = "private"
#
#  tags = {
#    Name        = "My bucket"
#    Environment = "Dev"
#  }
#  force_destroy = true
#}
#
#resource "aws_dynamodb_table" "state-locking" {
#  name         = "state-locking"
#  billing_mode = "PAY_PER_REQUEST"
#  hash_key     = "LockID"
#  attribute {
#    name = "LockID"
#    type = "S"
#  }
#}

resource "aws_s3_bucket_object" "s3_key" {
  bucket = var.BUCKET_NAME
  acl    = "private"
  key    = "key/vprofilekey"
  source = "vprofilekey"
}

resource "aws_s3_bucket_object" "s3_key1" {
  bucket     = var.BUCKET_NAME
  acl        = "private"
  key        = "key/vprofilekey.pub"
  source     = "vprofilekey.pub"
}

terraform {
  backend "s3" {
    bucket         = "vprofile-terraform"
    key            = "terraform/backend"
    region         = "us-east-1"
    dynamodb_table = "state-locking"
  }
}



