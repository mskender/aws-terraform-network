locals {
    public_subnet_offset = var.create_private_subnets ? 1*length(data.aws_availability_zones.available.names) :0
    vpc_subnet_mask = tonumber(split("/",var.cidr)[1])
    subnet_cidr_size =   var.subnet_size - local.vpc_subnet_mask 
    subnet_name = "${var.prefix}-subnet${local.suffix}"
}

resource "aws_subnet" "private" {

    count = var.create_private_subnets ? length(data.aws_availability_zones.available.names) : 0
    vpc_id     = aws_vpc.main.id    

    
    cidr_block = cidrsubnet(aws_vpc.main.cidr_block, local.subnet_cidr_size, count.index+1)

    tags = { Name = "${local.subnet_name}-${split("-",element(data.aws_availability_zones.available.names, count.index))[2]}${local.suffix}" }
    availability_zone = element(data.aws_availability_zones.available.names, count.index)
    
}


resource "aws_subnet" "public" {

    count = var.create_public_subnets ? length(data.aws_availability_zones.available.names) : 0
    vpc_id     = aws_vpc.main.id

    
    cidr_block = cidrsubnet(aws_vpc.main.cidr_block, local.subnet_cidr_size, count.index+1+local.public_subnet_offset)

    tags = { Name = "${local.subnet_name}-${element(data.aws_availability_zones.available.names, count.index)}${local.suffix}" }
    availability_zone = element(data.aws_availability_zones.available.names, count.index)
    map_public_ip_on_launch = var.map_public_ips
}

resource "aws_route_table_association" "gw1" {
  count = var.create_igw ? length(aws_subnet.public.*) : 0
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.gw1[0].id
}
