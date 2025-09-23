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
  description = "Prefix for the S3 bucket name"
  type        = string
  default     = "cucurucu"
}


variable "html_file" {
  description = "Path to the simple HTML file to upload"
  type        = string
  default     = "Cloud_Programming_V1.html"
}

variable "project_tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {
    Project = "StaticWebsite"
  }
}
