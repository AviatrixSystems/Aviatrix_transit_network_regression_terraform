output "TRANSIT_PUBLIC_SUBNET1" {
  value = aviatrix_vpc.transit_vpc.public_subnets[0].cidr
}
output "TRANSIT_PUBLIC_SUBNET2" {
  value = aviatrix_vpc.transit_vpc.public_subnets[1].cidr
}
output "STATIC_SPOKE_VPC" {
  value = local.spoke_tag.vpc_id
}
output "ONPREM_SPOKE_VPC" {
  value = local.onprem_tag.vpc_id
}
output "STATIC_SPOKE_VPC_CIDR" {
  value = local.spoke_tag.subnet
}
output "ONPREM_SPOKE_VPC_CIDR" {
  value = local.onprem_tag.subnet
}

