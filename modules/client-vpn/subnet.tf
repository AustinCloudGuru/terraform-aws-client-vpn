data "aws_availability_zones" "available" {}

resource "aws_subnet" "vpn-1" {
  count                   = "${var.vpn-1_create}"
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = "${var.vpn-1_subnet_cidr}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"
  tags {
    Name                  = "vpn-1"
    Description           = "VPN Subnet ${data.aws_availability_zones.available.names[0]}"
    Terraform             = "true"
  }
}

resource "aws_route_table" "vpn-1" {
  count                   = "${var.vpn-1_create}"
  vpc_id                  = "${var.vpc_id}"
  route {
    cidr_block            = "0.0.0.0/0"
    gateway_id            = "${var.internet-gateway}"
  }
  tags {
    Name                  = "vpn-1 Subnet"
    Description           = "VPN Subnet ${data.aws_availability_zones.available.names[0]}"
    Terraform             = "true"
  }
}

resource "aws_route_table_association" "vpn-1-rta" {
  count                   = "${var.vpn-1_create}"
  subnet_id               = "${aws_subnet.vpn-1.id}"
  route_table_id          = "${aws_route_table.vpn-1.id}"
}
