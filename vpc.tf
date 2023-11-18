#VPC
resource "ncloud_vpc" "vpc" {
  ipv4_cidr_block = var.vpc.ip
  name = var.vpc.name
}


#NACL
resource "ncloud_network_acl" "lb_nacl" {
  vpc_no = ncloud_vpc.vpc.id
  name   = var.nacl_name.lb
  description = "lb_nacl"
}

resource "ncloud_network_acl" "was_nacl" {
  vpc_no = ncloud_vpc.vpc.id
  name   = var.nacl_name.was
  description = "was_nacl"
}

resource "ncloud_network_acl" "db_nacl" {
  vpc_no = ncloud_vpc.vpc.id
  name   = var.nacl_name.db
  description = "db_nacl"
}

resource "ncloud_network_acl" "dp_nacl" {
  vpc_no = ncloud_vpc.vpc.id
  name   = var.nacl_name.dp
  description = "dp_nacl"
}


#SUBNET
resource "ncloud_subnet" "ld_subnet" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = var.lb_subnet.ip
  zone           = var.lb_subnet.zone
  network_acl_no = ncloud_network_acl.lb_nacl.id
  subnet_type    = var.lb_subnet.subnet_type
  name           = var.lb_subnet.name
  usage_type     = var.lb_subnet.usage_type
}

resource "ncloud_subnet" "was_subnet" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = var.was_subnet.ip
  zone           = var.was_subnet.zone
  network_acl_no = ncloud_network_acl.was_nacl.id
  subnet_type    = var.was_subnet.subnet_type
  name           = var.was_subnet.name
  usage_type     = var.was_subnet.usage_type
}

resource "ncloud_subnet" "db_subnet" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = var.db_subnet.ip
  zone           = var.db_subnet.zone
  network_acl_no = ncloud_network_acl.db_nacl.id
  subnet_type    = var.db_subnet.subnet_type
  name           = var.db_subnet.name
  usage_type     = var.db_subnet.usage_type
}


resource "ncloud_subnet" "dp_subnet" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = var.dp_subnet.ip
  zone           = var.dp_subnet.zone
  network_acl_no = ncloud_network_acl.dp_nacl.id
  subnet_type    = var.dp_subnet.subnet_type
  name           = var.dp_subnet.name
  usage_type     = var.dp_subnet.usage_type
}

