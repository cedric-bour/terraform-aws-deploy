resource "aws_vpc" "cloud1-vpc" {
  cidr_block           = var.vpc-config["cidr_block"]
  enable_dns_hostnames = var.vpc-config["enable_dns_hostnames"]
  
  tags = {
    Name: "${var.vpc-config["name"]}-vpc"
  }
}