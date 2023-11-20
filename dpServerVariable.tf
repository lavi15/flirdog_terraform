variable "kafka_server" {
  type = map(string)

  default = {
    server_product_code = "SVR.VSVR.HICPU.C032.M064.NET.SSD.B050.G002"
    member_server_image_no = "20635034"
  }
}
