### Aviatrix_transit_network_regression_terraform
Automation script for end-to-end test by using Terraform
### Description
Launch transit gateway, spoke gateway, and onprem gateway to simulate VGW connections.

Notes:
1. Aviatrix Controller and admin user account is ready.
2. Assume two (onprem and spoke) VPCs already exists with instances. 
3. Transit VPC is dynamically created by this test script.
4. All gateways default to ActiveMesh disabled.

#### 1. Setup provider credentials
**mysecret.tfvars**
``` hcl
aws_access_key      ="xxxxxxxxxxxxxxxxxxxx"
aws_secret_key      ="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
controller_ip       = "54.17.19.22"
controller_username = "admin"
controller_password = "password123"
controller_email    = "user@domain.com"

# spoke VPC
spoke_vpc_id         = "vpc-0cc2849a14c185847"
spoke_subnet         = "10.10.80.0/20"
spoke_ha_subnet      = "10.10.80.0/20"
# onprem VPC
onprem_vpc_id        = "vpc-0f35d2839d5754ad8"
onprem_subnet        = "172.16.5.0/24"
vgw_id               = "vgw-07132d607eb041e4b"
``` 

#### 2. Initialize and Execute 
``` shell
> terraform init
> terraform validate
> terraform plan -var-file=mysecret.tfvars
> terraform apply -auto-approve -var-file=mysecret.tfvars
```
#### 3. Verify forwarding path from OnPrem to Spoke VPC
** Ping from OnPrem Linux to Spoke Linux **

#### 4. Cleanup Transit Network
**Destroy**
``` shell
> terraform init
> terraform show
> terraform destroy -force -var-file=mysecret.tfvars
```
#### Thank you
**Aviatrix Engineering Team**
