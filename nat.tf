locals {

  natgw_name = "${var.prefix}-natgw${local.suffix}"
  nat_rt_name = "${var.prefix}-nat-rt${local.suffix}"
}

resource "aws_route_table" "nat" {

    count = var.create_natgw && var.create_public_subnets ? length(aws_subnet.private) : 0
    vpc_id = aws_vpc.main.id

    route {

        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.natgw[count.index].id

    }

      tags = {
        "Name" = "${local.nat_rt_name}-${element(data.aws_availability_zones.available.names, count.index)}-${var.suffix}"
  }
  }

resource "aws_route_table_association" "nat" {
  count = var.create_natgw && var.create_public_subnets ? length(aws_subnet.private) : 0
  subnet_id         = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.nat[count.index].id

}
resource "aws_nat_gateway" "natgw" {
  
  count = var.create_natgw && var.create_public_subnets  ? length(aws_subnet.private) : 0
  allocation_id = aws_eip.natgw[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  
  tags = {
    "Name" = "${local.natgw_name}-${element(data.aws_availability_zones.available.names, count.index)}-${var.suffix}"
  }


  depends_on = [
    aws_internet_gateway.gw1,
    aws_eip.natgw
    ]
}

resource "aws_eip" "natgw" {
  count = var.create_natgw && var.create_public_subnets ? length(aws_subnet.private) : 0
  vpc      = true
}