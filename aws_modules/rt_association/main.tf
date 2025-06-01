resource "aws_route_table_association" "rt_association" {
  route_table_id = var.rt_id
  subnet_id = var.subnet_id
}