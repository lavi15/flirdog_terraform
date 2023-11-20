#WAS
resource "ncloud_access_control_group_rule" "was_acg_rule" {
  access_control_group_no = ncloud_access_control_group.was_acg.id

  inbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "22"
    description = "accept SSH"
  }

  inbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "80"
    description = "accept HTTP"
  }

  inbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "443"
    description = "accept HTTPS"
  }

  outbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
    description = "accept ANY port"
  }
}

#LB
resource "ncloud_access_control_group_rule" "lb_acg_rule" {
  access_control_group_no = ncloud_access_control_group.lb_acg.id

  inbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "22"
    description = "accept SSH"
  }

  inbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "80"
    description = "accept HTTP"
  }

  inbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "443"
    description = "accept HTTPS"
  }

  outbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
    description = "accept ANY port"
  }
}

#DB
resource "ncloud_access_control_group_rule" "db_acg_rule" {
  access_control_group_no = ncloud_access_control_group.db_acg.id

  inbound {
    protocol    = "TCP"
    ip_block    = var.was_subnet.ip
    port_range  = "1-65535"
    description = "accept WAS"
  }

  inbound {
    protocol    = "TCP"
    ip_block    = var.dp_subnet.ip
    port_range  = "1-65535"
    description = "accept DP"
  }

  outbound {
    protocol    = "TCP"
    ip_block    = var.was_subnet.ip
    port_range  = "1-65535"
    description = "accept WAS"
  }

  outbound {
    protocol    = "TCP"
    ip_block    = var.dp_subnet.ip
    port_range  = "1-65535"
    description = "accept DP"
  }
}

#DP
resource "ncloud_access_control_group_rule" "dp_acg_rule" {
  access_control_group_no = ncloud_access_control_group.dp_acg.id

  inbound {
    protocol    = "TCP"
    ip_block    = var.was_subnet.ip
    port_range  = "1-65535"
    description = "accept WAS"
  }

  inbound {
    protocol    = "TCP"
    ip_block    = var.db_subnet.ip
    port_range  = "1-65535"
    description = "accept DB"
  }

  inbound {
    protocol    = "TCP"
    ip_block    = var.dp_subnet.ip
    port_range  = "1-65535"
    description = "accept DP"
  }

  outbound {
    protocol    = "TCP"
    ip_block    = var.was_subnet.ip
    port_range  = "1-65535"
    description = "accept WAS"
  }

  outbound {
    protocol    = "TCP"
    ip_block    = var.db_subnet.ip
    port_range  = "1-65535"
    description = "accept DB"
  }

  outbound {
    protocol    = "TCP"
    ip_block    = var.dp_subnet.ip
    port_range  = "1-65535"
    description = "accept DP"
  }
}