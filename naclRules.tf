#LB
resource "ncloud_network_acl_rule" "lb_nacl_rule" {
  network_acl_no    = ncloud_network_acl.lb_nacl.id

  inbound {
    priority    = 0
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "22"
    description = "SSH"
  }

  inbound {
    priority    = 10
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "80"
    description = "HTTP"
  }

  inbound {
    priority    = 20
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "443"
    description = "HTTPS"
  }

  outbound {
    priority    = 0
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
    description = "ANY"
  }
}

#WAS
resource "ncloud_network_acl_rule" "was_nacl_rule" {
  network_acl_no    = ncloud_network_acl.was_nacl.id

  inbound {
    priority    = 0
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
    description = "ANY"
  }

  inbound {
    priority    = 10
    protocol    = "UDP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
    description = "ANY"
  }

  outbound {
    priority    = 0
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
    description = "ANY"
  }

  outbound {
    priority    = 10
    protocol    = "UDP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
    description = "ANY"
  }
}

#DB
resource "ncloud_network_acl_rule" "db_nacl_rule" {
  network_acl_no    = ncloud_network_acl.db_nacl.id

  inbound {
    priority    = 0
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = var.was_subnet.ip
    port_range  = "1-65535"
    description = "WAS"
  }

  inbound {
    priority    = 10
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = var.dp_subnet.ip
    port_range  = "1-65535"
    description = "DP"
  }

  outbound {
    priority    = 0
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = var.was_subnet.ip
    port_range  = "1-65535"
    description = "WAS"
  }

  outbound {
    priority    = 10
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = var.dp_subnet.ip
    port_range  = "1-65535"
    description = "DP"
  }
}

#DP
resource "ncloud_network_acl_rule" "dp_nacl_rule" {
  network_acl_no    = ncloud_network_acl.dp_nacl.id

  inbound {
    priority    = 0
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
    description = "ANY"
  }

  inbound {
    priority    = 10
    protocol    = "UDP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
    description = "ANY"
  }

  outbound {
    priority    = 0
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
    description = "ANY"
  }

  outbound {
    priority    = 10
    protocol    = "UDP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
    description = "ANY"
  }
}
