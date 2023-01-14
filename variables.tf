variable "region" {
    type    = string
    default = "us-east-1"
}

variable "profileaws" {
    type        = string
    default     = "crinoz"
    description = "Profile name AWS CLI"
}

//****************** Bucket S3 ******************//

variable "acl_s3" {
    type = list(string)
    default = ["private", "public-read", "public-read-write", "authenticated-read"]  
}

variable "versioning_s3" {
    type = list(string)
    default = ["Enabled", "Disabled"]  
}

//****************** CloudFront ******************//

variable "aliases" {
    type = string
    default = "cristiannoguera.com"
  
}

variable "is_ipv6_enabled" {
    type        = list(bool)
    default     = [true, false]
    description = "State of CloudFront IPv6"
}

variable "comment" {
    type = string
    default = "Distribution Cloudfront Test"
    description = "Comment for the origin access identity"
}

variable "default_root_object" {
  type        = string
  default     = "index.html"
  description = "Object that CloudFront return when requests the root URL"
}

variable "distribution_enabled" {
  type        = bool
  default     = true
  description = "Set to `true` if you want CloudFront to begin processing requests as soon as the distribution is created, or to false if you do not want CloudFront to begin processing requests after the distribution is created."
}

variable "default_ttl" {
  type        = number
  default     = 1800
  description = "Default amount of time (in seconds) that an object is in a CloudFront cache"
}

variable "min_ttl" {
  type        = number
  default     = 1800
  description = "Minimum amount of time that you want objects to stay in CloudFront caches"
}

variable "max_ttl" {
  type        = number
  default     = 1800
  description = "Maximum amount of time (in seconds) that an object is in a CloudFront cache"
}

variable "compress" {
  type        = bool
  default     = false
  description = "Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header (default: false)"
}

variable "allowed_methods" {
  type        = list(string)
  default     = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
  description = "List of allowed methods (e.g. ` GET, PUT, POST, DELETE, HEAD`) for AWS CloudFront"
}

variable "cached_methods" {
  type        = list(string)
  default     = ["GET", "HEAD"]
  description = "List of cached methods (e.g. ` GET, PUT, POST, DELETE, HEAD`)"
}

variable "forward_cookies" {
  type        = string
  description = "Specifies whether you want CloudFront to forward cookies to the origin. Valid options are all, none or whitelist"
  default     = "none"
}

variable "viewer_protocol_policy" {
  type        = list(string)
  default     = ["redirect-to-https","allow-all"]
  description = "allow-all, redirect-to-https"
}

variable "forward_query_string" {
  type        = bool
  default     = false
  description = "Forward query strings to the origin that is associated with this cache behavior"
}

# variable "forward_headers" {
#   type        = string
#   default     = "Origin"
#   description = "Specifies the Headers, if any, that you want CloudFront to vary upon for this cache behavior. Specify `*` to include all headers."
# }

variable "geo_restriction_type" {
  type        = list(string)
  default     = ["none", "whitelist"]
  description = "Method that use to restrict distribution of your content by country: `none`, `whitelist`, or `blacklist`"
}

variable "geo_restriction_locations" {
  type = list(string)
  default     = []
  description = "List of country codes for which CloudFront either to distribute content (whitelist) or not distribute your content (blacklist)"
}

variable "min_protocol_version" {
  type = list(string)
  default = ["TLSv1.1_2016", "TLSv1.2_2019", "TLSv1.2_2021"]
  description = "The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections"
}

//******************** Tags ********************//

variable "env_name" {
    type          = list(string)
    default       = ["dev", "qa", "pdn" ]
    description = "environment name"
}

variable "owner" {
    type    = string
    default = "Cristian-Noguera"
}

variable "project" {
    type    = string
    default = "test"
}

variable "provisioner" {
  type = string
  default = "Managed by Terraform"
}

locals {
    tags = {
        Environment = var.env_name[0]
        Owner       = var.owner
        Provisioner = var.provisioner
    }
}