data "aws_ami" "cloud1-ami-ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

data "aws_ami" "cloud1-ami-nat" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn-ami-vpc-nat-2018.03*"]
  }

  owners = ["137112412989"]
}
