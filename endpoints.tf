resource "aws_vpc_endpoint" "ssm" {
  count = var.create_ssm_endpoint ? 1 : 0
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type = "Interface"
  security_group_ids = [
      aws_security_group.sgp_outbound_default.id,
      aws_security_group.sgp_endpoints.id
  ]
  subnet_ids = aws_subnet.private.*.id
  private_dns_enabled  = true
  tags = merge(var.tags, {
      "Name" = "${var.prefix}-ssm-endpoint${local.suffix}"
  })
}

resource "aws_vpc_endpoint" "ec2messages" {
  count = var.create_ssm_endpoint ? 1 : 0
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type = "Interface"
    security_group_ids = [
      aws_security_group.sgp_outbound_default.id,
      aws_security_group.sgp_endpoints.id
  ]
  subnet_ids = aws_subnet.private.*.id
  private_dns_enabled  = true
  tags = merge(var.tags, {
       "Name" = "${var.prefix}-ec2messages-endpoint${local.suffix}"
  })
}

resource "aws_vpc_endpoint" "ssmmessages" {
  count = var.create_ssm_endpoint ? 1 : 0
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type = "Interface"
    security_group_ids = [
      aws_security_group.sgp_outbound_default.id,
      aws_security_group.sgp_endpoints.id
  ]
  subnet_ids = aws_subnet.private.*.id
  private_dns_enabled  = true
    tags = merge(var.tags, {
       "Name" = "${var.prefix}-ssmmessages-endpoint${local.suffix}"
  })
}

resource "aws_vpc_endpoint" "s3" {
  count = var.create_s3_endpoint ? 1:0
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = var.create_igw ? [
     aws_route_table.gw1[0].id 
  ] : []
  
  tags = merge(var.tags, {
      "Name" = "${var.prefix}-s3-endpoint${local.suffix}"
  })
}