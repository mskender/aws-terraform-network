

resource "aws_vpc" "main" {

    cidr_block = var.cidr
    enable_dns_hostnames = true
    enable_dns_support = true

}


resource "aws_internet_gateway" "gw1" {
  count = var.create_igw ? 1 : 0
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "default" {

    vpc_id = aws_vpc.main.id

    route {

        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw1.id

    }
}

resource "aws_main_route_table_association" "main" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.default.id

}


