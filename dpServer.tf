#Init Script
resource "ncloud_init_script" "kafka_init_script" {
  name    = var.kafka-init_script.name
  content = var.kafka-init_script.content
}

#Interface
resource "ncloud_network_interface" "dp_connect_server_interface" {
  name                  = "dp-connect-server-interface1"
  description           = "dp-connect-server-interface1"
  subnet_no             = ncloud_subnet.was_subnet.id
  access_control_groups = [ncloud_access_control_group.was_acg.id]
}

resource "ncloud_network_interface" "kafka_private_interface1" {
  name                  = "kafka-private-interface1"
  description           = "kafka-private-interface1"
  subnet_no             = ncloud_subnet.dp_subnet.id
  access_control_groups = [ncloud_access_control_group.dp_acg.id]
}

resource "ncloud_network_interface" "kafka_private_interface2" {
  name                  = "kafka-private-interface2"
  description           = "kafka-private-interface2"
  subnet_no             = ncloud_subnet.dp_subnet.id
  access_control_groups = [ncloud_access_control_group.dp_acg.id]
}

resource "ncloud_network_interface" "kafka_private_interface3" {
  name                  = "kafka-private-interface3"
  description           = "kafka-private-interface3"
  subnet_no             = ncloud_subnet.dp_subnet.id
  access_control_groups = [ncloud_access_control_group.dp_acg.id]
}

#server
resource "ncloud_server" "kafka_server_1" {
  subnet_no = ncloud_subnet.dp_subnet.id
  name      = "flirdog-kafka1"
  server_product_code = var.kafka_server.server_product_code
  server_image_product_code = var.kafka_server.server_image_product_code
  login_key_name = var.loginkey
  init_script_no = ncloud_init_script.kafka_init_script.id
  network_interface {
    network_interface_no = ncloud_network_interface.kafka_private_interface1.id
    order                = 0
  }
}

resource "ncloud_server" "kafka_server_2" {
  subnet_no = ncloud_subnet.dp_subnet.id
  name      = "flirdog-kafka2"
  server_product_code = var.kafka_server.server_product_code
  server_image_product_code = var.kafka_server.server_image_product_code
  login_key_name = var.loginkey
  init_script_no = ncloud_init_script.kafka_init_script.id
  network_interface {
    network_interface_no = ncloud_network_interface.kafka_private_interface2.id
    order                = 0
  }
}

resource "ncloud_server" "kafka_server_3" {
  subnet_no = ncloud_subnet.dp_subnet.id
  name      = "flirdog-kafka3"
  server_product_code = var.kafka_server.server_product_code
  server_image_product_code = var.kafka_server.server_image_product_code
  login_key_name = var.loginkey
  init_script_no = ncloud_init_script.kafka_init_script.id
  network_interface {
    network_interface_no = ncloud_network_interface.kafka_private_interface3.id
    order                = 0
  }
}

resource "ncloud_server" "dp_connect_server" {
  subnet_no = ncloud_subnet.was_subnet.id
  name      = "dp-connect-server"
  server_product_code = var.kafka_server.server_product_code
  server_image_product_code = var.kafka_server.server_image_product_code
  login_key_name = var.loginkey
  init_script_no = ncloud_init_script.kafka_init_script.id
  network_interface {
    network_interface_no = ncloud_network_interface.dp_connect_server_interface.id
    order                = 0
  }
}

resource "ncloud_public_ip" "dp_connect_server_public_ip" {
  server_instance_no =ncloud_server.dp_connect_server.instance_no
}
