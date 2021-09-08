terraform {
  required_providers {
    aviatrix = {
      source = "AviatrixSystems/aviatrix"
      version = "2.20"
    }
  }
}
variable "tag" {}
variable "transit_gw" {}

resource "aviatrix_vpc" "spoke_ondemand_vpc" {
  count               = var.tag.spoke_count
  cloud_type          = var.tag.cloud_type
  account_name        = var.tag.account_name
  region              = var.tag.vpc_reg
  name                = "spoke-ondemand-vpc${count.index}"
  cidr                = "10.250.${count.index}.0/24"
}

resource "aviatrix_spoke_gateway" "spoke_ondemand_gw" {
   count              = var.tag.spoke_count
   cloud_type         = var.tag.cloud_type
   account_name       = var.tag.account_name
   gw_name            = "var.tag.gw_name-${count.index}"
   vpc_reg            = var.tag.vpc_reg
   gw_size            = var.tag.gw_size
   ha_gw_size         = var.tag.gw_size
   vpc_id             = element(aviatrix_vpc.spoke_ondemand_vpc.*.vpc_id,count.index)
   subnet             = "10.250.${count.index}.80/28"
   ha_subnet          = "10.250.${count.index}.98/28"
   single_az_ha       = var.tag.single_az_ha
   enable_active_mesh = var.tag.active_mesh
   manage_transit_gateway_attachment = false
}

resource "aviatrix_spoke_transit_attachment" "spoke_transit_attachment_1" {
   count             = var.tag.spoke_count
   spoke_gw_name     = element(aviatrix_spoke_gateway.spoke_ondemand_gw.*.gw_name,count.index)
   transit_gw_name   = var.transit_gw
   depends_on        = [aviatrix_spoke_gateway.spoke_ondemand_gw]
}

