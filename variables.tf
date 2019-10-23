variable "controller_ip"       {}
variable "controller_username" {}
variable "controller_password" {}
variable "controller_email"    {}
variable "aws_access_key"      {}
variable "aws_secret_key"      {}
variable "ondemand_spoke_count"{default = 0}
variable "transit_region"      {default = "us-west-2"}
variable "spoke_region"        {default = "us-west-2"}
variable "onprem_region"       {default = "us-west-2"}
variable "cloud_type"          {default = "AWS"}
variable "active_mesh"         {default = "false"}

locals {
  account_name     = "EdselAWS"
  common_gw_size   = "t2.micro"
  cloud_type       = (var.cloud_type == "AWS" ? 1 : 0)
  connected_transit= "false"
  single_az_ha     = "false"
  transit_gateway_name= "cluster0-transit"
  skip_version_validation = true
}
locals  {
  transit_region   = var.transit_region
  gw_size          = "t2.micro"
  transit_vpc_cidr = "10.100.0.0/16"

  ondemand_tag     = {
    spoke_count    = var.ondemand_spoke_count
    gw_size        = local.common_gw_size
    cloud_type     = local.cloud_type
    account_name   = local.account_name
    vpc_reg        = var.spoke_region
    single_az_ha   = local.single_az_ha
    active_mesh    = (var.active_mesh == true ? "true" : "false")
  }

  spoke_tag        = {
    spoke_region   = "us-west-2"
    vpc_id         = "vpc-0cc2849a14c185847"
    subnet         = "10.10.80.0/20"
    ha_subnet      = "10.10.96.0/20"
    gw_size        = local.common_gw_size
    ha_gw_size     = local.common_gw_size
    cloud_type     = local.cloud_type
    account_name   = local.account_name
    gw_name        = "cluster-spoke"
    vpc_reg        = var.spoke_region
    gw_size        = local.common_gw_size
    ha_gw_size     = local.common_gw_size
    single_az_ha   = local.single_az_ha
    active_mesh    = (var.active_mesh == true ? "true" : "false")
  }
  onprem_tag = {
    subnet         = "172.16.5.0/24"
    vpc_id         = "vpc-0f35d2839d5754ad8"
    account_name   = "EdselAWS"
    onprem_gw_name = "OnPrem"
    onprem_gw_size = "t2.micro"
    remote_subnet  = "10.0.0.0/8"
    vgw_id         = "vgw-07132d607eb041e4b"
    region         = "us-west-2"
    bgp_asn        = "6592"
    conn_name      = "vgw_transit_connection"
    bgp_local_as_num = "6535"
    static_routes1 = ["172.16.0.0/16"]
  }
}
