# S3 Bucket config#
resource "aws_iam_role" "allow_instance_s3" {
  name = "${var.name}_allow_instance_s3"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.name}_instance_profile"
  role = aws_iam_role.allow_instance_s3.name
}

resource "aws_iam_role_policy" "allow_s3_all" {
  name = "${var.name}_allow_all"
  role = aws_iam_role.allow_instance_s3.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
                "arn:aws:s3:::${var.name}",
                "arn:aws:s3:::${var.name}/*"
            ]
    }
  ]
}
EOF
}

# │ Error: Unsupported argument
# │   on modules/s3/main.tf line 53, in resource "aws_s3_bucket_acl" "web_bucket":
# │   53:   force_destroy = true
# │ An argument named "force_destroy" is not expected here.

# │ Error: Unsupported argument
# │
# │   on modules/s3/main.tf line 58, in resource "aws_s3_bucket_acl" "web_bucket":
# │   58:   tags   = merge(var.common_tags, { Name = "${var.name}-web-bucket" })
# │
# │ An argument named "tags" is not expected here.

resource "aws_s3_bucket_acl" "web_bucket" {
  bucket = var.name
  acl    = "private"
}
