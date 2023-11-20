resource "ncloud_subnet" "nat_subnet" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = "10.0.4.0/24"
  zone           = "KR-2"
  network_acl_no = ncloud_network_acl.was_nacl.id
  subnet_type    = "PUBLIC"
  usage_type     = "NATGW"
}

resource "ncloud_nat_gateway" "nat_gateway" {
  vpc_no      = ncloud_vpc.vpc.id
  subnet_no   = ncloud_subnet.nat_subnet.id
  zone        = "KR-2"
  name        = "nat-gw"
  description = "description"
}

resource "ncloud_route_table" "nat_route_table" {
  vpc_no                = ncloud_vpc.vpc.id
  supported_subnet_type = "PRIVATE"
  name                  = "nat-route-table"
}

resource "ncloud_route_table_association" "nat_route_table_subnet" {
  route_table_no        = ncloud_route_table.nat_route_table.id
  subnet_no             = ncloud_subnet.dp_subnet.id
}

resource "ncloud_route" "dp_nat_route" {
  route_table_no         = ncloud_route_table.nat_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  target_type            = "NATGW"
  target_name            = ncloud_nat_gateway.nat_gateway.name
  target_no              = ncloud_nat_gateway.nat_gateway.id
}