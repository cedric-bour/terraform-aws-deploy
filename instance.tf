resource "aws_instance" "cloud1-instance-nat" {
  for_each = var.cloud1-hosts-public

  ami           = data.aws_ami.cloud1-ami-nat.id
  instance_type = each.value.instance_type

  subnet_id = aws_subnet.subnet-public[each.value.network].id
  vpc_security_group_ids = [
    aws_security_group.cloud1-security-group-allow-ssh.id,
    aws_security_group.cloud1-security-group-allow-nat.id
  ]
  key_name               = aws_key_pair.cloud1-key-pair-1.key_name

  source_dest_check = false
  tags = { Name = "cloud1-public-${each.key}" }
}

resource "aws_instance" "cloud1-instance-private" {
  for_each = var.cloud1-hosts-private
  
  ami           = data.aws_ami.cloud1-ami-ubuntu.id
  instance_type = each.value.instance_type

  subnet_id = aws_subnet.subnet-private[each.value.network].id
  vpc_security_group_ids = [aws_security_group.cloud1-security-group-allow-ssh.id]
  key_name               = aws_key_pair.cloud1-key-pair-1.key_name
  tags = { Name = "cloud1-private-${each.key}" }
}