variable "kafka_server" {
  type = map(string)

  default = {
    server_product_code = "SVR.VSVR.HICPU.C032.M064.NET.SSD.B050.G002"
    kafka-cluster1-ip = "10.0.3.16"
    kafka-cluster2-ip = "10.0.3.17"
    kafka-cluster3-ip = "10.0.3.18"
    kafka-cluster1-image = "20655426"
    kafka-cluster2-image = "20655428"
    kafka-cluster3-image = "20655430"
  }
}

variable "kafka_main_script" {
  type = map(string)

  default = {
    name = "kafka-main-script"
    content = <<-EOF
#!/bin/bash
nohup ~/confluent-7.0.1/bin/zookeeper-server-start -daemon ~/confluent-7.0.1/etc/kafka/zookeeper.properties
nohup ~/confluent-7.0.1/bin/kafka-server-start -daemon ~/confluent-7.0.1/etc/kafka/server.properties
nohup ~/confluent-7.0.1/bin/connect-distributed -daemon ~/confluent-7.0.1/etc/kafka/connect-distributed.properties
~/confluent-7.0.1/bin/kafka-topics --create --bootstrap-server 10.0.3.16:9092 --topic chat
EOF
  }
}

variable "kafka_init_script" {
  type = map(string)

  default = {
    name = "kafka-init-script"
    content = <<-EOF
#!/bin/bash
nohup ~/confluent-7.0.1/bin/zookeeper-server-start -daemon ~/confluent-7.0.1/etc/kafka/zookeeper.properties
nohup ~/confluent-7.0.1/bin/kafka-server-start -daemon ~/confluent-7.0.1/etc/kafka/server.properties
nohup ~/confluent-7.0.1/bin/connect-distributed -daemon ~/confluent-7.0.1/etc/kafka/connect-distributed.properties
EOF
  }
}