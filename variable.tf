variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "vpc-config" {
  type = object({
    name                     = string
    cidr_block               = string
    enable_dns_hostnames     = bool
  })
  default = {
        name                    = "cloud1",
        cidr_block              = "10.0.0.0/16",
        enable_dns_hostnames    = true
    }
}

variable "azs" {
  type = map(string)
  default = {
    "a" : "use1-az1"
    "b" : "use1-az2"
    "c" : "use1-az3"
  }
}

variable "cloud1-subnet-public" {
  type = map(object({
    availability_zone_id          = string
    cidr_block                    = string
  }))
  default = {
    "public1" = {
        availability_zone_id          = "a",
        cidr_block                    = "10.0.100.0/24"
    },
    "public2" = {
        availability_zone_id          = "b",
        cidr_block                    = "10.0.102.0/24"
    },
    "public3" = {
        availability_zone_id          = "c",
        cidr_block                    = "10.0.104.0/24"
    }
  }
}

variable "cloud1-subnet-private" {
  type = map(object({
    availability_zone_id          = string
    cidr_block                    = string
    passerel                      = string
  }))
  default = {
    "private1" = {
        availability_zone_id          = "a",
        cidr_block                    ="10.0.101.0/24"
        passerel                      = "nat1"
    },
    "private2" = {
        availability_zone_id          = "b",
        cidr_block                    ="10.0.103.0/24"
        passerel                      = "nat2"
    },
    "private3" = {
        availability_zone_id          = "c",
        cidr_block                    = "10.0.105.0/24"
        passerel                      = "nat3"
    }
  }
}

variable "cloud1-hosts-public" {
  type = map(object({
    instance_type  = string
    network = string
  }))
  default = {
    "nat1" = {
        instance_type      = "t2.micro",
        network            = "public1"
    },
    "nat2" = {
        instance_type      = "t2.micro",
        network            = "public2"
    },
    "nat3" = {
        instance_type      = "t2.micro",
        network            = "public3"
    }
  }
}

variable "cloud1-hosts-private" {
  type = map(object({
    instance_type  = string
    network = string
  }))
  default = {
    "ub1" = {
        instance_type      = "t2.micro",
        network            = "private1"
    },
    "ub2" = {
        instance_type      = "t2.micro",
        network            = "private2"
    },
    "ub3" = {
        instance_type      = "t2.micro",
        network            = "private3"
    }
  }
}