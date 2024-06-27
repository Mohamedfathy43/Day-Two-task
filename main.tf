provider "aws" {
  region  = "us-east-1"
  profile = "default"
}
#deply staefile in s3 bucket
terraform {
  backend "s3" {
    bucket = "erakiterrafromstatefiles-704652"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}



#deploy s3 bucket 
resource "aws_s3_bucket" "mybucket" {
  bucket = "erakiterrafromstatefiles-704652"

  versioning {
    enabled = true
  }
  force_destroy = true
  

}

# content of policy.allow upload to logs folder 
data "aws_iam_policy_document" "allow_upload_to_logs_folder" {
  statement {
    actions = ["s3:PutObject"]
    effect  = "Allow"

    resources = [
      aws_s3_bucket.mybucket.arn,
    "${aws_s3_bucket.mybucket.arn}/logs/*"]


    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.user_id}:user/${var.user_name}"]
    }

  }

}



#deploy policy 
resource "aws_s3_bucket_policy" "allow_upload_to_logs_folder" {
  bucket = aws_s3_bucket.mybucket.id
  policy = data.aws_iam_policy_document.allow_upload_to_logs_folder.json
}
#deploy folder in s3 bucket 
resource "aws_s3_bucket_object" "logs_folder" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "logs/"
}
#If you are enabling versioning on the bucket 
  resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.mybucket.id
  versioning_configuration {
    status = "Enabled"
  }
}






