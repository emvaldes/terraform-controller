##################################################################################
# OUTPUT
##################################################################################

output "aws_elb_public_dns" {
  value = aws_elb.web.dns_name
}

output "resources_index" {
  value = local.env_index
}

output "cname_record_url" {
  value = "http://${local.route53_record}.${var.domain_name}"
}

output "custom_timestamp" {
  value = var.custom_timestamp
}

output "custom_engineer" {
  value = var.custom_engineer
}

output "custom_contact" {
  value = var.custom_contact
}

output "custom_listset" {
  value = var.custom_listset
}

output "custom_mapset" {
  value = var.custom_mapset
}

output "filebased_parameters" {
  value = var.filebased_parameters
}
