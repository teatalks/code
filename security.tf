# Squad12-security groups

# Allow all tcp traffic

resource "aws_security_group" "squad12sg" {
  name        = "squad12sg"
  description = "Allow all inbound traffic"
  vpc_id      = local.vpc_id

  ingress {
    description = "SSH All"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

ingress {
    description = "All traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

  egress {
    description = "All traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "squad12-all-traffic"
  }
}
