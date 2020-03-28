variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "20.0.0.0/16"
}

variable "subnets_cidr" {
  type    = list
  default = ["20.0.1.0/24", "20.0.2.0/24", "20.0.3.0/24"]
}

variable "azs" {
  type    = list
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

#EC2 variables

variable "web-ami" {
  default = "ami-0fc61db8544a617ed"
}

variable "instance_type" {
  default = "t2.micro"
}

