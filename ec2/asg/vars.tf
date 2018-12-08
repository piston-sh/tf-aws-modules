variable "cluster_name" {}
variable "vpc_id" {}

variable "subnet_ids" {
  type = "list"
}

variable "availability_zones" {
  type = "list"
}

variable "ami" {}
variable "user_data" {}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_group" {
  default = "default"
}

variable "min_size" {
  default = 1
}

variable "max_size" {
  default = 2
}

variable "desired_capacity" {
  default = 1
}

variable "security_group_ids" {
  type    = "list"
  default = []
}

variable "allowed_ssh_cidr_blocks" {
  type    = "list"
  default = []
}

variable "allowed_ssh_security_group_ids" {
  type    = "list"
  default = []
}

variable "associate_public_ip" {
  default = false
}

variable "ssh_key_name" {}