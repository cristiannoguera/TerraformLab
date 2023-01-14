resource "aws_s3_bucket" "bucket_s3" {
  bucket = "s3-website-${var.project}-${var.env_name[0]}"
}

resource "aws_s3_bucket_acl" "acl_s3" {
  bucket = aws_s3_bucket.bucket_s3.id
  acl    = var.acl_s3[0]
}

resource "aws_s3_bucket_website_configuration" "website_s3" {
  bucket = aws_s3_bucket.bucket_s3.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_account_public_access_block" "access_s3" {
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "versioning_s3" {
  bucket = aws_s3_bucket.bucket_s3.id
  versioning_configuration {
    status = var.versioning_s3[1]
  }
}

######################### Cloudfront Distribution ##############################

locals {
  s3_origin_id = "s3-microfront-${var.project}-${var.env_name[0]}"
}

resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "s3-microfront-${var.project}-${var.env_name[0]}}"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.bucket_s3.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity  = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  enabled             = var.distribution_enabled
  is_ipv6_enabled     = var.is_ipv6_enabled[0]
  comment             = var.comment
  default_root_object = var.default_root_object

  #   logging_config {
  #   include_cookies = false
  #   bucket          = "mylogscfn.s3.amazonaws.com"
  #   prefix          = "myprefixlogs"
  # }

  # aliases = ["mysite.example.com", "yoursite.example.com"]

  default_cache_behavior {
    allowed_methods  = var.allowed_methods
    cached_methods   = var.cached_methods
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = var.forward_query_string

      cookies {
        forward = var.forward_cookies
      }
    }

    default_ttl            = var.default_ttl
    min_ttl                = var.min_ttl
    max_ttl                = var.max_ttl
    viewer_protocol_policy = var.viewer_protocol_policy[1]
  }

  ordered_cache_behavior {
### Falta definir variables
    path_pattern     = "/content/immutable/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
### Falta definir variables
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = var.forward_query_string
      headers      = ["Origin"]

      cookies {
        forward = var.forward_cookies
      }
    }

    default_ttl            = var.default_ttl
    min_ttl                = var.min_ttl
    max_ttl                = var.max_ttl
    compress               = var.compress
    viewer_protocol_policy = var.viewer_protocol_policy[0]
  }

  ordered_cache_behavior {
### Falta definir variables
    path_pattern     = "/content/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
### Falta definir variables
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = var.forward_query_string

      cookies {
        forward = var.forward_cookies
      }
    }
    default_ttl            = var.default_ttl
    min_ttl                = var.min_ttl
    max_ttl                = var.max_ttl
    compress               = var.compress
    viewer_protocol_policy = var.viewer_protocol_policy[0]
  }
    restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type[0]
      locations        = var.geo_restriction_locations
    }
  }

    viewer_certificate {
    cloudfront_default_certificate = true
    minimum_protocol_version = var.min_protocol_version[0]
  }
}