resource "aws_route_table" "tf_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "${var.pjt_name}-rt"
  }
}

resource "aws_route_table_association" "tf_rt_sn_ass" {
  for_each = var.sn_ids
  subnet_id      = each.value
  route_table_id = aws_route_table.tf_rt.id
}