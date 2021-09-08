terraform {
  required_providers {
    aviatrix = {
      source = "AviatrixSystems/aviatrix"
      version = "2.20"
    }
  }
}
variable "transit_gw" {}
variable "tag"        {}

resource "aviatrix_spoke_gateway" "spoke" {
   cloud_type         = var.tag.cloud_type
   account_name       = var.tag.account_name
   gw_name            = var.tag.gw_name
   vpc_reg            = var.tag.vpc_reg
   ha_gw_size         = var.tag.gw_size
   gw_size            = var.tag.gw_size
   vpc_id             = var.tag.vpc_id
   subnet             = var.tag.subnet
   ha_subnet          = var.tag.ha_subnet
   single_az_ha       = var.tag.single_az_ha
   enable_active_mesh = var.tag.active_mesh 
   transit_gw         = var.transit_gw
}
