resource "aws_vpc_endpoint" "ssm" {
  count = var.create_ssm_endpoint ? 1 : 0
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type = "Interface" 
  security_group_ids = [
      aws_security_group.sgp_outbound_default.id,
      aws_security_group.sgp_ssm_endpoints.id
  ]
  subnet_ids = aws_subnet.private.*.id
  private_dns_enabled  = true
  tags = {
      "Name" = "${var.prefix}-ssm-endpoint${local.suffix}"
  }
}

resource "aws_vpc_endpoint" "ec2messages" {
  count = var.create_ssm_endpoint ? 1 : 0
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type = "Interface" 
    security_group_ids = [
      aws_security_group.sgp_outbound_default.id,
      aws_security_group.sgp_ssm_endpoints.id
  ]
  subnet_ids = aws_subnet.private.*.id
  private_dns_enabled  = true
  tags = {
       "Name" = "${var.prefix}-ec2messages-endpoint${local.suffix}"
  }
}

resource "aws_vpc_endpoint" "ssmmessages" {
  count = var.create_ssm_endpoint ? 1 : 0
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type = "Interface" 
    security_group_ids = [
      aws_security_group.sgp_outbound_default.id,
      aws_security_group.sgp_ssm_endpoints.id
  ]
  subnet_ids = aws_subnet.private.*.id
  private_dns_enabled  = true
    tags = {
       "Name" = "${var.prefix}-ssmmessages-endpoint${local.suffix}"
  }
}