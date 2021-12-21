# Simple Network Module for AWS

## Description

This is a module to provide a cookie-cutter vpc layout, currently supporting following features:
- private subnet(s) creation
- public subnet(s) creation
- IGW and appropriate route table creation
- NATGW and appropriate route table creation
- SSM endpoints creation with appropriate security groups
- default tags
- custom subnet tags for i.e. EKS tagging

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=3.38.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=3.38.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.natgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.gw1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_main_route_table_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/main_route_table_association) | resource |
| [aws_nat_gateway.natgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.gw1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.gw1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.sgp_outbound_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.sgp_ssm_endpoints](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_endpoint.ec2messages](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ssmmessages](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | Main CIDR which we'll carve up into subnets. One per region | `string` | `"172.100.0.0/16"` | no |
| <a name="input_create_igw"></a> [create\_igw](#input\_create\_igw) | Whether to create Internet Gateway and attach it to the VPC | `bool` | `true` | no |
| <a name="input_create_natgw"></a> [create\_natgw](#input\_create\_natgw) | Whether to create NAT Gateway for private subnets and attach it to the VPC | `bool` | `false` | no |
| <a name="input_create_private_subnets"></a> [create\_private\_subnets](#input\_create\_private\_subnets) | Whether to create private subnets | `bool` | `false` | no |
| <a name="input_create_public_subnets"></a> [create\_public\_subnets](#input\_create\_public\_subnets) | Whether to create public-facing, igw-attached subnets. Also mandatory if you plan to use NAT gateways. | `bool` | `false` | no |
| <a name="input_create_ssm_endpoint"></a> [create\_ssm\_endpoint](#input\_create\_ssm\_endpoint) | Whether to create SSM endpoint in VPC | `bool` | `true` | no |
| <a name="input_map_public_ips"></a> [map\_public\_ips](#input\_map\_public\_ips) | Map public IP's to resources in public subnets | `string` | `false` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | A string to prefix all resource names for easier sorting | `string` | `""` | no |
| <a name="input_private_subnet_additional_tags"></a> [private\_subnet\_additional\_tags](#input\_private\_subnet\_additional\_tags) | Additional tags to be applied to private subnets, i.e. for purposes of EKS tagging. | `map(any)` | `null` | no |
| <a name="input_private_subnets_per_az"></a> [private\_subnets\_per\_az](#input\_private\_subnets\_per\_az) | Number of private subnets to create per AZ. | `number` | `1` | no |
| <a name="input_public_subnet_additional_tags"></a> [public\_subnet\_additional\_tags](#input\_public\_subnet\_additional\_tags) | Additional tags to be applied to public subnets, i.e. for purposes of EKS tagging. | `map(any)` | `null` | no |
| <a name="input_public_subnets_per_az"></a> [public\_subnets\_per\_az](#input\_public\_subnets\_per\_az) | Number of public subnets to create per AZ. | `number` | `1` | no |
| <a name="input_region"></a> [region](#input\_region) | Region in which to create resources. | `string` | `"eu-west-1"` | no |
| <a name="input_subnet_size"></a> [subnet\_size](#input\_subnet\_size) | CIDR (slash) size of (both) public and private subnets. Must be smaller than CIDR subnet size, i.e. 24 for class C subnet. | `number` | `24` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | A string to suffix all resource names. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all created objects (vpc, subnets, igw and natgw) | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | n/a |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | n/a |
