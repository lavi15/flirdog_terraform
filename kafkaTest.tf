#Interface
resource "ncloud_network_interface" "kafka_test_interface1" {
  name                  = "kafka-test-interface1"
  description           = "kafka-test-interface1"
  subnet_no             = ncloud_subnet.was_subnet.id
  private_ip            = "10.0.1.100"
  access_control_groups = [ncloud_access_control_group.was_acg.id]
}

resource "ncloud_network_interface" "kafka_test_interface2" {
  name                  = "kafka-test-interface2"
  description           = "kafka-test-interface2"
  subnet_no             = ncloud_subnet.was_subnet.id
  private_ip            = "10.0.1.101"
  access_control_groups = [ncloud_access_control_group.was_acg.id]
}

resource "ncloud_network_interface" "kafka_test_interface3" {
  name                  = "kafka-test-interface3"
  description           = "kafka-test-interface3"
  subnet_no             = ncloud_subnet.was_subnet.id
  private_ip            = "10.0.1.102"
  access_control_groups = [ncloud_access_control_group.was_acg.id]
}


#server
resource "ncloud_server" "kafkatest_server_1" {
  subnet_no = ncloud_subnet.was_subnet.id
  name      = "flirdogtest-kafka1"
  server_product_code = var.kafka_server.server_product_code
  member_server_image_no = var.kafka_server.kafka-cluster1-image
  login_key_name = var.loginkey
  init_script_no = ncloud_init_script.kafka-main-script.id
  network_interface {
    network_interface_no = ncloud_network_interface.kafka_test_interface1.id
    order                = 0
  }
}

resource "ncloud_server" "kafkatest_server_2" {
  subnet_no = ncloud_subnet.was_subnet.id
  name      = "flirdogtest-kafka2"
  server_product_code = var.kafka_server.server_product_code
  member_server_image_no = var.kafka_server.kafka-cluster2-image
  login_key_name = var.loginkey
  init_script_no = ncloud_init_script.kafka-init-script.id
  network_interface {
    network_interface_no = ncloud_network_interface.kafka_test_interface2.id
    order                = 0
  }
}

resource "ncloud_server" "kafkatest_server_3" {
  subnet_no = ncloud_subnet.was_subnet.id
  name      = "flirdogtest-kafka3"
  server_product_code = var.kafka_server.server_product_code
  member_server_image_no = var.kafka_server.kafka-cluster3-image
  login_key_name = var.loginkey
  init_script_no = ncloud_init_script.kafka-init-script.id
  network_interface {
    network_interface_no = ncloud_network_interface.kafka_test_interface3.id
    order                = 0
  }
}


resource "ncloud_public_ip" "test1_server_public_ip" {
  server_instance_no =ncloud_server.kafkatest_server_1.instance_no
}

resource "ncloud_public_ip" "test2_server_public_ip" {
  server_instance_no =ncloud_server.kafkatest_server_2.instance_no
}

resource "ncloud_public_ip" "test3_server_public_ip" {
  server_instance_no =ncloud_server.kafkatest_server_3.instance_no
}
