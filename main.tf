terraform {
  required_providers {
    minio = {
      source = "terraform-provider-minio/minio"
      version = ">= 3.1.0"
    }
  }
}

provider "minio" {
  minio_server   = "127.0.0.1:9000"
  minio_user     = var.minio_user
  minio_password = var.minio_password
  minio_ssl      = false
}

resource "minio_s3_bucket" "tp1_bucket" {
  bucket = "tp1-cloud-bucket"
  acl    = "private"
}

resource "minio_s3_object" "index_html" {
  bucket_name  = minio_s3_bucket.tp1_bucket.bucket
  object_name  = "index.html"
  source       = "index.html"
  content_type = "text/html"
}

resource "minio_s3_object" "blocked_html" {
  bucket_name  = minio_s3_bucket.tp1_bucket.bucket
  object_name  = "blocked.html"
  source       = "blocked.html"
  content_type = "text/html"
}

resource "minio_s3_object" "style_css" {
  bucket_name  = minio_s3_bucket.tp1_bucket.bucket
  object_name  = "style.css"
  source       = "style.css"
  content_type = "text/css"
}

resource "minio_s3_bucket_policy" "public_policy" {
  bucket = minio_s3_bucket.tp1_bucket.bucket

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": ["s3:GetObject"],
      "Resource": [
        "arn:aws:s3:::tp1-cloud-bucket/index.html",
        "arn:aws:s3:::tp1-cloud-bucket/style.css"
      ]
    }
  ]
}
EOF
}
