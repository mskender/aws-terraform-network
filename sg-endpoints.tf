

resource "aws_security_group" "sgp_endpoints" {

  vpc_id = aws_vpc.main.id
  name   = "${local.sgp_prefix}-endpoints${local.suffix}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  tags = merge(var.tags, {
    Name = "${local.sgp_prefix}-outbound-default${local.suffix}"
  })
}