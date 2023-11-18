variable "region" {
  default = "KR"
}

variable "site" {
  default = "public"
}

variable "support_vpc" {
  default = "true"
}

#VPC
variable "vpc" {
  type = map(string)

  default = {
    name = "flirdog-vpc"
    ip   = "10.0.0.0/16"
  }
}

#NACL
variable "nacl_name" {
  type = map(string)

  default = {
    was = "flirdog-was-nacl"
    lb  = "flirdog-lb-nacl"
    db  = "flirdog-db-nacl"
    dp  = "flirdog-db-nacl"
  }
}

#LB Subnet
variable "lb_subnet" {
  type = map(string)

  default = {
    name = "flirdog-lb-subnet"
    ip   = "10.0.0.0/24"
    zone = "KR-2"
    subnet_type = "PRIVATE"
    usage_type  = "LOADB"
  }
}




variable "was_subnet" {
  type = map(string)

  default = {
    name = "flirdog-was-subnet"
    ip   = "10.0.1.0/24"
    zone = "KR-2"
    subnet_type = "PUBLIC"
    usage_type  = "GEN"
  }
}


variable "db_subnet" {
  type = map(string)

  default = {
    name = "flirdog-db-subnet"
    ip   = "10.0.2.0/24"
    zone = "KR-2"
    subnet_type = "PRIVATE"
    usage_type  = "GEN"
  }
}

variable "dp_subnet" {
  type = map(string)

  default = {
    name = "flirdog-dp-subnet"
    ip   = "10.0.3.0/24"
    zone = "KR-2"
    subnet_type = "PRIVATE"
    usage_type  = "GEN"
  }
}
