aws_access_key = ""
aws_secret_key = ""

private_keypair_file = ""
private_keypair_name = ""

bucket_name_prefix = "terraform"
billing_code_tag   = "ACCT8675309"

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
  dev  = 2
  uat  = 2
  prod = 3
}

instance_count = {
  dev  = 2
  uat  = 4
  prod = 6
}

custom_timestamp = "Today Is A Good Day To ..."
custom_engineer  = "DevOps Team"
custom_contact   = "emvaldes@yahoo.com"
custom_listset   = "Proving Nothing"
custom_mapset    = "Testing Something"

filebased_parameters = ""
