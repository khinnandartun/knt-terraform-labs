Description
=======================================

Terraform code will create 4 VPC ( VPC-A, VPC-B, VPC-C and VPC-D ) and one transist gateway which is attached with all VPC.Only VPC-D's subnet has the public network connection and the others are all private.
Private subnet from VPC-A,VPC-B, VPC-C has one instance and  public subnet from VPC has one instance to use a jump server and NAT gateway , EIP to send the trafffic to internet gateway.

The mission of this lab is to get the connection between 4 VPC and the private subnet from VPC-A , VPC-B , VPC-C reach out to internet via private subnet from VPC-D.

Architecture Design
=======================================

![transistGateway](https://github.com/khinnandartun/knt-terraform-labs/assets/79824409/38ce83f6-2885-49f8-b345-1dbea60700c5)


VPC Route Table
=======================================
VPC-A (subnet_a)

<img width="334" alt="image" src="https://github.com/khinnandartun/knt-terraform-labs/assets/79824409/2345e981-7218-4e9a-9d76-a227dd9a2f2e">

VPC-B (subnet_b)

<img width="333" alt="image" src="https://github.com/khinnandartun/knt-terraform-labs/assets/79824409/74395a4a-ccd1-4f16-adf3-5cc5a176c4bb">

VPC-C (subnet_c)

<img width="333" alt="image" src="https://github.com/khinnandartun/knt-terraform-labs/assets/79824409/4cbe6ad8-cff6-451a-bc69-b1eecb5c2bcd">

VPC-D (private_subnet_d)

<img width="334" alt="image" src="https://github.com/khinnandartun/knt-terraform-labs/assets/79824409/8c0c9622-644f-4123-9e3e-d0e2ca557722">

VPC-D (public_subnet_d)

<img width="333" alt="image" src="https://github.com/khinnandartun/knt-terraform-labs/assets/79824409/d7fab412-11bf-4bd8-8f92-a242b4df1a93">

Note
========================================
* For the subnet attachment of VPC-D, please attach with private subnet. So, the other vpc(VPC-A, VPC-B, VPC-C ) can connect internet via NAT route at private subnet


Reference Link
========================================

https://docs.aws.amazon.com/vpc/latest/tgw/transit-gateway-nat-igw.html
