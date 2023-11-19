variable "kafka_server" {
  type = map(string)

  default = {
    server_product_code = "SVR.VSVR.HICPU.C032.M064.NET.SSD.B050.G002"
    server_image_product_code = "SW.VSVR.OS.LNX64.UBNTU.SVR2004.B050"
  }
}


variable "kafka-init_script" {
  type = map(string)

  default = {
    name = "kafka-init-script"
    content = <<-EOF
#!/bin/bash
sudo apt-get update
EOF
  }
}
