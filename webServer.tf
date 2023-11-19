#ACG
resource "ncloud_access_control_group" "was_acg" {
  name        = var.acg_name.was
  description = "was_acg"
  vpc_no      = ncloud_vpc.vpc.id
}

resource "ncloud_access_control_group" "lb_acg" {
  name        = var.acg_name.lb
  description = "lb_acg"
  vpc_no      = ncloud_vpc.vpc.id
}

resource "ncloud_access_control_group" "db_acg" {
  name        = var.acg_name.db
  description = "db_acg"
  vpc_no      = ncloud_vpc.vpc.id
}

resource "ncloud_access_control_group" "dp_acg" {
  name        = var.acg_name.dp
  description = "dp_acg"
  vpc_no      = ncloud_vpc.vpc.id
}

#Interface
resource "ncloud_network_interface" "was_private_interface1" {
  name                  = "was-private-interface1"
  description           = "was-private-interface1"
  subnet_no             = ncloud_subnet.was_subnet.id
  access_control_groups = [ncloud_access_control_group.was_acg.id]
}

resource "ncloud_network_interface" "was_private_interface2" {
  name                  = "was-private-interface2"
  description           = "was-private-interface2"
  subnet_no             = ncloud_subnet.was_subnet.id
  access_control_groups = [ncloud_access_control_group.was_acg.id]
}

resource "ncloud_network_interface" "was_private_interface3" {
  name                  = "was-private-interface3"
  description           = "was-private-interface3"
  subnet_no             = ncloud_subnet.was_subnet.id
  access_control_groups = [ncloud_access_control_group.was_acg.id]
}

#Init Script
resource "ncloud_init_script" "was-init-script" {
  name    = var.was-init_script.name
  content = var.was-init_script.content
}

#WAS
resource "ncloud_server" "was_server_1" {
  subnet_no = ncloud_subnet.was_subnet.id
  name      = "flirdog-was1"
  server_product_code = var.was_server.server_product_code
  member_server_image_no = var.was_server.member_server_image_no
  login_key_name = var.loginkey
  init_script_no = ncloud_init_script.was-init-script.id
  network_interface {
    network_interface_no = ncloud_network_interface.was_private_interface1.id
    order                = 0
  }
}

resource "ncloud_server" "was_server_2" {
  subnet_no = ncloud_subnet.was_subnet.id
  name      = "flirdog-was2"
  server_product_code = var.was_server.server_product_code
  member_server_image_no = var.was_server.member_server_image_no
  login_key_name = var.loginkey
  init_script_no = ncloud_init_script.was-init-script.id
  network_interface {
    network_interface_no = ncloud_network_interface.was_private_interface2.id
    order                = 0
  }
}

resource "ncloud_server" "was_server_3" {
  subnet_no = ncloud_subnet.was_subnet.id
  name      = "flirdog-was3"
  server_product_code = var.was_server.server_product_code
  member_server_image_no = var.was_server.member_server_image_no
  login_key_name = var.loginkey
  init_script_no = ncloud_init_script.was-init-script.id
  network_interface {
    network_interface_no = ncloud_network_interface.was_private_interface3.id
    order                = 0
  }
}


#LB
resource "ncloud_lb" "was_lb" {
  name = "was-lb"
  network_type = "PUBLIC"
  type = "APPLICATION"
  subnet_no_list = [ ncloud_subnet.ld_subnet.subnet_no ]
  throughput_type = "MEDIUM"
}

resource "ncloud_lb_target_group" "was_lb_target_group" {
  vpc_no   = ncloud_vpc.vpc.vpc_no
  protocol = "HTTPS"
  port        = 443
  target_type = "VSVR"
  health_check {
    protocol = "HTTPS"
    http_method = "GET"
    port           = 443
    cycle          = 30
    up_threshold   = 2
    down_threshold = 2
  }
  algorithm_type = "RR"
}


resource "ncloud_lb_listener" "was_lb_listener_https" {
  load_balancer_no = ncloud_lb.was_lb.load_balancer_no
  protocol = "HTTPS"
  port = 443
  target_group_no = ncloud_lb_target_group.was_lb_target_group.target_group_no
  ssl_certificate_no = var.ssl.ssl_certificate_no
  use_http2 = "true"
}

resource "ncloud_lb_listener" "was_lb_listener_http" {
  load_balancer_no = ncloud_lb.was_lb.load_balancer_no
  protocol = "HTTP"
  port = 80
  target_group_no = ncloud_lb_target_group.was_lb_target_group.target_group_no
  ssl_certificate_no = var.ssl.ssl_certificate_no
  use_http2 = "true"
}

resource "ncloud_lb_target_group_attachment" "was_lb_target_group_attachment" {
  target_group_no = ncloud_lb_target_group.was_lb_target_group.target_group_no
  target_no_list = [ncloud_server.was_server_1.instance_no, ncloud_server.was_server_2.instance_no, ncloud_server.was_server_3.instance_no]
}
