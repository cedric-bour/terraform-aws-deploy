resource "aws_security_group" "cloud1-security-group-allow-ssh" {
  name        = "allow-ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.cloud1-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "cloud1-security-group-allow-ssh"
    Location = "Paris"
    Author   = "Cédric B."
    Email    = "cedric.bour@live.fr"
  }
}

resource "aws_security_group" "cloud1-security-group-allow-nat" {
  name        = "allow-nat"
  description = "Allow NAT inbound traffic"
  vpc_id      = aws_vpc.cloud1-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.cloud1-vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "cloud1-security-group-allow-nat"
    Location = "Paris"
    Author   = "Cédric B."
    Email    = "cedric.bour@live.fr"
  }
}