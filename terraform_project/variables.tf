variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "eu-north-1"
}

variable "bucket_name_prefix" {
  description = "Prefix for the S3 bucket name"
  type        = string
  default     = "cloudprogramming"
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "bucketIU2025"
}


variable "html_file" {
  description = "Path to the static page to upload"
  type        = string
  default     = "cloudProgrammingV1.html"
}

variable "project_tags" {
  description = "Tags of the resources"
  type        = map(string)
  default     = {
    Project = "StaticWebsite"
  }
}
