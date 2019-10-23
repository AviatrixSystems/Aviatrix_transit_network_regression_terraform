### Aviatrix_transit_network_regression_terraform
Automation script for end-to-end test by using Terraform
### Description
Launch transit gateway, spoke gateway, and onprem gateway to simulate VGW connections.

Notes:
1. Aviatrix Controller and admin user account is ready.
1. OnPrem VPC and Spoke VPC are static so that EC2 instances are ready to ping. 
2. Transit VPC is dynamic. 
3. All gateways default to ActiveMesh disabled.

#### 1. Setup provider credentials
**mysecret.tfvars**
``` hcl
aws_access_key      ="xxxxxxxxxxxxxxxxxxxx"
aws_secret_key      ="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
controller_ip       = "54.17.19.22"
controller_username = "admin"
controller_password = "password123"
controller_email    = "user@domain.com"
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
