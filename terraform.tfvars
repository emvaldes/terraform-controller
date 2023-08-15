aws_access_key = ""
aws_secret_key = ""

private_keypair_file = ""
private_keypair_name = ""

bucket_name_prefix = ""
billing_code_tag   = ""

corporate_title = "DevOps Team"
corporate_image = "corporate.jpg"

network_address_space = {
  dev  = "10.0.0.0/16"
  uat  = "10.1.0.0/16"
  prod = "10.2.0.0/16"
}

instance_size = {
  dev  = "t2.micro"
  uat  = "t2.small"
  prod = "t2.medium"
}

subnet_count = {
  dev  = 1
  uat  = 2
  prod = 2
}

instance_count = {
  dev  = 1
  uat  = 2
  prod = 4
}

zone_id        = ""
domain_name    = ""
route53_record = ""

custom_timestamp = ""
custom_engineer  = ""
custom_contact   = ""
custom_listset   = ""
custom_mapset    = ""

filebased_parameters = ""
