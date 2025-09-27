terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "web" {
  bucket = "${var.bucket_name_prefix}-${random_id.suffix.hex}"
  tags   = var.project_tags
}

resource "aws_s3_object" "cloudProgrammingV1" {
  bucket       = aws_s3_bucket.web.id
  key          = "cloudProgrammingV1.html"
  source       = var.html_file
  content_type = "text/html"
  tags         = var.project_tags
}

resource "aws_cloudfront_origin_access_identity" "web" {
  comment = "Access identity for S3 bucket"
}

resource "aws_cloudfront_distribution" "web" {
  origin {
    domain_name = aws_s3_bucket.web.bucket_regional_domain_name
    origin_id   = "s3-web-origin"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.web.cloudfront_access_identity_path
    }
  }

  enabled             = true
  default_root_object = "cloudProgrammingV1.html"

  default_cache_behavior {
    target_origin_id       = "s3-web-origin"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = var.project_tags
}

resource "aws_s3_bucket_policy" "web" {
  bucket = aws_s3_bucket.web.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.web.iam_arn
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.web.arn}/*"
      }
    ]
  })
}