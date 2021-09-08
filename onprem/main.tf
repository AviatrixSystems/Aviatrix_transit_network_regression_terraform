terraform {
  required_providers {
    aviatrix = {
      source = "AviatrixSystems/aviatrix"
      version = "2.20"
    }
  }
}
resource "aviatrix_gateway" "OnPrem-GW" {
    cloud_type             = var.tag.cloud_type
    account_name           = var.tag.account_name
    gw_name                = var.tag.onprem_gw_name
    vpc_id                 = var.tag.vpc_id
    vpc_reg                = var.tag.region
    gw_size                = var.tag.onprem_gw_size
    subnet                 = var.tag.subnet
    single_az_ha           = true
}
resource "aviatrix_vgw_conn" "vgw_to_transit" {
    bgp_vgw_account        = var.tag.account_name
    bgp_vgw_region         = var.tag.region
    vpc_id                 = var.tag.transit_vpc_id
    conn_name              = var.tag.conn_name
    gw_name                = var.transit_gw
    bgp_vgw_id             = var.tag.vgw_id
    bgp_local_as_num       = var.tag.bgp_local_as_num
}
resource "aws_customer_gateway" "customer_gateway" {
    bgp_asn                = var.tag.bgp_asn
    ip_address             = aviatrix_gateway.OnPrem-GW.eip
    type                   = "ipsec.1"
    tags                   = {
          Name = "onprem-gateway"
    }
}
resource "aws_vpn_connection" "onprem" {
    vpn_gateway_id         = var.tag.vgw_id
    customer_gateway_id    = aws_customer_gateway.customer_gateway.id
    type                   = "ipsec.1"
    static_routes_only     = true
    tags                   =    {
                   Name    = "site2cloud-to-vgw"
    }
    depends_on = [aviatrix_gateway.OnPrem-GW]
}
resource "aws_vpn_connection_route" "onprem1" {
    count                  = length(var.tag.static_routes1)
    destination_cidr_block = var.tag.static_routes1[count.index]
    vpn_connection_id      = aws_vpn_connection.onprem.id
}
resource "aviatrix_site2cloud" "onprem-vgw" {
    vpc_id                 = var.tag.vpc_id
    connection_name        = "site2cloud_to_vgw"
    connection_type        = "unmapped"
    tunnel_type            = "policy"
    remote_gateway_type    = "aws"
    remote_subnet_cidr     = var.tag.remote_subnet
    remote_gateway_ip      = aws_vpn_connection.onprem.tunnel1_address
    pre_shared_key         = aws_vpn_connection.onprem.tunnel1_preshared_key
    primary_cloud_gateway_name = aviatrix_gateway.OnPrem-GW.gw_name
    depends_on             = [aviatrix_gateway.OnPrem-GW]
}



