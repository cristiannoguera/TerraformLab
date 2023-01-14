# output "account_id" {
#   description = "Account which terraform was run on"
#   value       = data.aws_caller_identity.current.account_id
# }

# output "cf_arn" {
#   value       = try(aws_cloudfront_distribution.default[0].arn, "")
#   description = "ARN of CloudFront distribution"
# }