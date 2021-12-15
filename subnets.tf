locals {
    public_subnet_offset = var.create_private_subnets ? 1*length(data.aws_availability_zones.available.names) :0
    cidr_size = 24 - var.subnet_size
}

resource "aws_subnet" "private" {

    count = var.create_private_subnets ? length(data.aws_availability_zones.available.names) : 0
    vpc_id     = var.vpc.id    

    
    cidr_block = cidrsubnet(var.vpc.cidr_block, 8, count.index+1+var.cidr_offset)

    tags = { Name = "${var.subnet_name}-${element(data.aws_availability_zones.available.names, count.index)}" }
    availability_zone = element(data.aws_availability_zones.available.names, count.index)
    
}


resource "aws_subnet" "public" {

    count = var.create_public_subnets ? length(data.aws_availability_zones.available.names) : 0
    vpc_id     = var.vpc.id    

    
    cidr_block = cidrsubnet(var.vpc.cidr_block, local.cidr_size, count.index+1+local.public_subnet_offset)

    tags = { Name = "${var.subnet_name}-${element(data.aws_availability_zones.available.names, count.index)}" }
    availability_zone = element(data.aws_availability_zones.available.names, count.index)
    map_public_ip_on_launch = var.map_public
}

resource "aws_route_table_association" "gw1" {
  count = length(aws_subnet.main.*)
  subnet_id      = aws_subnet.main[count.index].id
  route_table_id = aws_route_table.default.id
}
