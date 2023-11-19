#Init Script
resource "ncloud_init_script" "kafka-init-script" {
  name    = var.kafka-init_script.name
  content = var.kafka-init_script.content
}

#Interface
resource "ncloud_network_interface" "kafka_private_interface1" {
  name                  = "kafka-private-interface1"
  description           = "kafka-private-interface1"
  subnet_no             = ncloud_subnet.was_subnet.id
  access_control_groups = [ncloud_access_control_group.was_acg.id]
}

#server
resource "ncloud_server" "kafka_server_1" {
  subnet_no = ncloud_subnet.was_subnet.id
  name      = "flirdog-kafka1"
  server_product_code = var.kafka_server.server_product_code
  server_image_product_code = var.kafka_server.server_image_product_code
  login_key_name = var.loginkey
  init_script_no = ncloud_init_script.kafka-init-script.id
  network_interface {
    network_interface_no = ncloud_network_interface.kafka_private_interface1.id
    order                = 0
  }
}

resource "ncloud_public_ip" "kafka_public_ip1" {
  server_instance_no =ncloud_server.kafka_server_1.instance_no
}
