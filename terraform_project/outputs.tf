output "bucket_name" {
  description = "An unique S3 bucket name"
  value       = aws_s3_bucket.web.bucket
}

output "cloudfront_url" {
  description = "CloudFront URL (HTTPS) to access the static site"
  value       = "https://${aws_cloudfront_distribution.web.domain_name}"
}
