aws_access_key      ="xxxxxxxxxxxxxxxxxxxx"
aws_secret_key      ="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
controller_ip       = "54.176.159.229"
controller_username = "admin"
controller_password = "password123"
controller_email    = "user@domain.com"

# 
# Assume two VPCs (onprem and spoke)
# already exists with instances
#
spoke_vpc_id         = "vpc-0cc2849a14c185847"
spoke_subnet         = "10.10.80.0/20"
spoke_ha_subnet      = "10.10.80.0/20"
onprem_vpc_id        = "vpc-0f35d2839d5754ad8"
onprem_subnet        = "172.16.5.0/24"
vgw_id               = "vgw-07132d607eb041e4b"
