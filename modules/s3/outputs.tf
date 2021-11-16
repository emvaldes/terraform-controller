output "bucket" {
  value = aws_s3_bucket_acl.web_bucket
}

output "instance_profile" {
  value = aws_iam_instance_profile.instance_profile
}
