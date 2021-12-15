resource "aws_route_table" "nat" {

    count = var.create_natgw ? 1 : 0
    vpc_id = aws_vpc.main.id

    route {

        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.natgw.id

    }
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.example.id
  subnet_id     = aws_subnet.example.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.example]
}