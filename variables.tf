# AWS Account Settings
variable "aws_account" {}
variable "aws_region" {}

variable "aws-base-bucket" {}
variable "aws-base-state-file" {}

# Apps Subnets
variable "vpn-1_subnet_cidr" {}

variable "nat-gw-1" {default=0}
