##################################################################################
# VARIABLES
##################################################################################

variable "custom_timestamp" {}
variable "custom_engineer" {}
variable "custom_contact" {}
variable "custom_listset" {}
variable "custom_mapset" {}

variable "filebased_parameters" {}

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "private_keypair_file" {}
variable "private_keypair_name" {}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable network_address_space {
  type = map(string)
}
variable "instance_size" {
  type = map(string)
}
variable "subnet_count" {
  type = map(number)
}

variable "instance_count" {
  type = map(number)
}

variable "corporate_title" {}
variable "corporate_image" {}

variable "billing_code_tag" {}
variable "bucket_name_prefix" {}

##################################################################################
# LOCALS
##################################################################################
## randint = "${format("%05d",floor(${random_integer.rand.result}))}"
## s3_bucket_name = "${var.bucket_name_prefix}-${local.env_name}-${random_integer.rand.result}"

locals {
  env_name        = lower(terraform.workspace)
  corporate_title = var.corporate_title
  corporate_image = var.corporate_image
  common_tags = {
    BillingCode = var.billing_code_tag
    Environment = local.env_name
  }
  s3_bucket_name = "${var.bucket_name_prefix}-${local.env_name}-${local.env_index}"
}
