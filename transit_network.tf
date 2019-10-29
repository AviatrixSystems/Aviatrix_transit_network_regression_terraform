resource "aviatrix_vpc" "transit_vpc" {
  cloud_type          = local.cloud_type
  account_name        = local.account_name
  region              = local.transit_region
  name                = "avx-transit-vpc"
  cidr                = local.transit_vpc_cidr
}

resource "aviatrix_transit_gateway" "transit_gw" {
   cloud_type         = local.cloud_type
   account_name       = local.account_name
   gw_name            = local.transit_gateway_name
   vpc_id             = aviatrix_vpc.transit_vpc.vpc_id
   vpc_reg            = local.transit_region
   gw_size            = local.gw_size
   ha_gw_size         = local.gw_size
   subnet             = aviatrix_vpc.transit_vpc.subnets[4].cidr
   ha_subnet          = aviatrix_vpc.transit_vpc.subnets[5].cidr
   single_az_ha       = local.single_az_ha
   connected_transit  = local.connected_transit
   enable_active_mesh = var.active_mesh
}

module "ondemand_spoke" {
   source             = "./ondemand_spoke"
   providers          = {
      aws = "aws.us-west-2"
   }
   tag                = local.ondemand_tag
   transit_gw         = aviatrix_transit_gateway.transit_gw.gw_name
}

module "spoke" {
   source             = "./spoke"
   providers          = {
      aws = "aws.us-west-2"
   }
   tag                = local.spoke_tag
   transit_gw         = aviatrix_transit_gateway.transit_gw.gw_name
}

module "simulated_onprem" {
   source             = "./onprem"
   providers          = {
      aws = "aws.us-west-2"
   }
   tag                = local.onprem_tag
   transit_gw         = aviatrix_transit_gateway.transit_gw.gw_name
}
