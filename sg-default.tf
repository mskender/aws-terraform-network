  locals {

      sgp_prefix = "${var.prefix}-sgp"
  }

resource "aws_security_group" "sgp_outbound_default" {

  
  vpc_id = aws_vpc.main.id
  name   = "${local.sgp_prefix}-outbound-default${local.suffix}"

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  tags = {
    Name = "${local.sgp_prefix}-outbound-default${local.suffix}"
  }
}