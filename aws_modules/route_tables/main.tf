resource "aws_route_table" "rt" {
    vpc_id = var.vpc_id
    
    route {
        cidr_block = var.cidr
        gateway_id = var.gateway_id
    }
}