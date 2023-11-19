variable "was_server" {
  type = map(string)

  default = {
    server_product_code = "SVR.VSVR.STAND.C032.M128.NET.SSD.B050.G002"
    member_server_image_no = "20610398"
  }
}

variable "acg_name" {
  type = map(string)

  default = {
    was  = "flirdog-was-acl"
    lb   = "flirdog-lb-acl"
    db   = "flirdog-db-acl"
    dp   = "flirdog-dp-acl"
  }
}

variable "was-init_script" {
  type = map(string)

  default = {
    name = "was-init-script"
    content = <<-EOF
#!/bin/bash
sudo apt-get update
sudo systemctl start nginx
/home/flirdog_be/deploy.sh
EOF
  }
}

variable "ssl" {
  default = {
    ssl_certificate_no = "21700"
  }
}