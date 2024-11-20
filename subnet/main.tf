resource "aws_subnet" "tf_subnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.sn_cidr_block
  availability_zone = var.az_name

  tags = {
    Name = "${var.pjt_name}-${var.sn_cidr_block}-sn"
  }
}