resource "aws_s3_bucket_policy" "example" {
  bucket = aws_s3_bucket.bucket_s3.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Id": "CloudFrontOriginAccessIdentityPolicy",
    "Statement": [
        {
            "Sid": "1",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.oai.id}"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::s3-website-${var.project}-${var.env_name[0]}/*"
        }
    ]
}
EOF
}