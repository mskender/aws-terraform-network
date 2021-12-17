locals {

suffix = var.suffix == "" ? "" : "-${var.suffix}"
vpc_name = "${var.prefix}-vpc${local.suffix}"
igw_name = "${var.prefix}-igw${local.suffix}"
rt_name = "${var.prefix}-rt${local.suffix}"




}

resource "aws_vpc" "main" {

    cidr_block = var.cidr
    enable_dns_hostnames = true
    enable_dns_support = true
    tags =  { 
      "Name" = local.vpc_name 
    }

}


resource "aws_internet_gateway" "gw1" {
  count = var.create_igw ? 1 : 0
  vpc_id = aws_vpc.main.id
  tags = {
    "Name" = local.igw_name
  }
}

resource "aws_route_table" "gw1" {

    count = var.create_igw ? 1 : 0
    vpc_id = aws_vpc.main.id

    route {

        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw1[count.index].id

    }
  tags = {
    "Name" = local.rt_name
  }
}

resource "aws_main_route_table_association" "main" {
  count = var.create_igw ? 1 : 0
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.gw1[count.index].id

}


