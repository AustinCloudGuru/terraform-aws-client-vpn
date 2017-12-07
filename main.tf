data "terraform_remote_state" "aws-base" {
  backend = "s3"
  config = {
    bucket = "${var.aws-base-bucket}"
    key    = "${var.aws-base-state-file}"
    region = "${var.aws_region}"
  }
}

module "client-vpn" {
  source                   = "./modules/client-vpn"
  vpn-1_create           = true
  vpn-1_subnet_cidr      = "${var.vpn-1_subnet_cidr}"
  vpc_id                   = "${data.terraform_remote_state.aws-base.vpc_id}"
  nat-gw-1                = "${data.terraform_remote_state.aws-base.nat-gw-1}"
  internet-gateway         = "${data.terraform_remote_state.aws-base.internet-gateway}"
}
