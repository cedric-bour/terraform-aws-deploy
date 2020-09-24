resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.cloud1-vpc.id
}

resource "aws_subnet" "subnet-public" {
  for_each                  = var.cloud1-subnet-public

  vpc_id                    = aws_vpc.cloud1-vpc.id
  cidr_block                = each.value.cidr_block
  availability_zone_id      = var.azs[each.value.availability_zone_id]
  map_public_ip_on_launch   = true
  tags = { Name = "cloud1-public-${var.aws_region}${each.value.availability_zone_id}" }
}

resource "aws_route_table" "route-table-public" {
  vpc_id = aws_vpc.cloud1-vpc.id
  tags = { Name = "cloud1-public" }
}

resource "aws_route_table_association" "route-table-association-public" {
  for_each         = aws_subnet.subnet-public
  
  subnet_id        = aws_subnet.subnet-public[each.key].id
  route_table_id   = aws_route_table.route-table-public.id
}

resource "aws_route" "route-public" {
  gateway_id              = aws_internet_gateway.internet-gateway.id
  route_table_id          = aws_route_table.route-table-public.id
  destination_cidr_block  = "0.0.0.0/0"
}

resource "aws_subnet" "subnet-private" {
  for_each                  = var.cloud1-subnet-private

  vpc_id                    = aws_vpc.cloud1-vpc.id
  cidr_block                = each.value.cidr_block
  availability_zone_id      = var.azs[each.value.availability_zone_id]
  tags = { Name = "cloud1-private-${var.aws_region}${each.value.availability_zone_id}" }
}

resource "aws_route_table" "route-table-private" {
  for_each                  = var.cloud1-subnet-private
  
  vpc_id     = aws_vpc.cloud1-vpc.id
  tags = { Name = "cloud1-private-${var.aws_region}${each.value.availability_zone_id}" }
}

resource "aws_route_table_association" "route-table-association-private" {
  for_each                = aws_subnet.subnet-private

  subnet_id      = aws_subnet.subnet-private[each.key].id
  route_table_id = aws_route_table.route-table-private[each.key].id
}

resource "aws_route" "route-private" {
  for_each                = aws_route_table.route-table-private

  route_table_id          = aws_route_table.route-table-private[each.key].id
  instance_id             = aws_instance.cloud1-instance-nat[lookup(var.cloud1-subnet-private[each.key], "passerel")].id
  destination_cidr_block  = "0.0.0.0/0"
}