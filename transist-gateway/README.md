Description
=======================================

Terraform code will create 4 VPC ( VPC-A, VPC-B, VPC-C and VPC-D ) and one transist gateway which is attached with all VPC.Only VPC-D's subnet has the public network connection and the others are all private.
Private subnet from VPC-A,VPC-B, VPC-C has one instance and  public subnet from VPC has one instance to use a jump server and NAT gateway , EIP to send the trafffic to internet gateway.

The mission of this lab is to get the connection between 4 VPC and the private subnet from VPC-A , VPC-B , VPC-C reach out to internet via private subnet from VPC-D.

Architecture Design
=======================================

![transistGateway](https://github.com/khinnandartun/knt-terraform-labs/assets/79824409/38ce83f6-2885-49f8-b345-1dbea60700c5)


