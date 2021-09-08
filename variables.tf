variable "controller_ip"       {default = "52.8.214.111"}
variable "controller_username" {default = "admin"}
variable "controller_password" {default = "Aviatrix123!"}
variable "account_name"        {default = "EdselAWS"}
variable "aws_access_key"      {}
variable "aws_secret_key"      {}
variable "ondemand_spoke_count"{default = 0}
variable "transit_region"      {default = "us-west-2"}
variable "spoke_region"        {default = "us-west-2"}
variable "onprem_region"       {default = "us-west-2"}
variable "cloud_type"          {default = "AWS"}
variable "active_mesh"         {default = "false"}
variable "spoke_vpc_id"        {}
variable "spoke_subnet"        {}
variable "spoke_ha_subnet"     {}
variable "onprem_vpc_id"       {}
variable "onprem_subnet"       {}
variable "vgw_id"              {}

locals {
  account_name     = var.account_name
  common_gw_size   = "t2.micro"
  cloud_type       = (var.cloud_type == "AWS" ? 1 : 0)
  connected_transit= "false"
  single_az_ha     = "false"
  transit_gateway_name    = "cluster0-transit"
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
    active_mesh    = var.active_mesh
  }

  spoke_tag        = {
    spoke_region   = var.spoke_region
    vpc_id         = var.spoke_vpc_id
    subnet         = var.spoke_subnet
    ha_subnet      = var.spoke_ha_subnet
    gw_size        = local.common_gw_size
    ha_gw_size     = local.common_gw_size
    cloud_type     = local.cloud_type
    account_name   = local.account_name
    gw_name        = "cluster-spoke"
    vpc_reg        = var.spoke_region
    gw_size        = local.common_gw_size
    ha_gw_size     = local.common_gw_size
    single_az_ha   = local.single_az_ha
    active_mesh    = var.active_mesh
  }
  onprem_tag = {
    cloud_type     = local.cloud_type
    vpc_id         = var.onprem_vpc_id
    subnet         = var.onprem_subnet
    transit_vpc_id = aviatrix_vpc.transit_vpc.vpc_id
    account_name   = var.account_name
    onprem_gw_name = "OnPrem"
    onprem_gw_size = local.common_gw_size
    remote_subnet  = "10.0.0.0/8"
    vgw_id         = var.vgw_id
    region         = var.onprem_region
    bgp_asn        = "6592"
    conn_name      = "vgw_transit_connection"
    bgp_local_as_num = "6535"
    static_routes1 = ["172.16.0.0/16"]
  }
}
