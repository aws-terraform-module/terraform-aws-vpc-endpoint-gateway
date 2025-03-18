data "aws_route_tables" "network" {
  vpc_id = var.vpc_id
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = var.service_name
  route_table_ids   =  length(var.route_table_ids) > 0 ? var.route_table_ids : data.aws_route_tables.network.ids
  vpc_endpoint_type = "Gateway"

  policy = var.vpc_endpoint_policy

  tags = {
    Name = var.vpc_gateway_endpoint_name != "" ? "${var.vpc_gateway_endpoint_name}-${var.service_name}" : var.service_name
  }
}