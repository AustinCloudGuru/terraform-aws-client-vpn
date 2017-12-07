data "aws_ami" "amazon_ami" {
  most_recent = true
  owners = ["aws-marketplace"]
  filter {
    name = "product-code"
    values = ["aw0evgkw8e5c1q413zgy5pjce"]
  }
}

resource "aws_instance" "vpn" {
  ami = "${data.aws_ami.amazon_ami.image_id}"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = "${aws_subnet.vpn-1.id}"
  key_name = "ml-aws-prototype"
  vpc_security_group_ids = ["${aws_security_group.vpn.id}"]
  user_data = "${file("${path.module}/bootstrap.sh")}"
  tags {
    Name = "vpn"
    ansibleFilter = "VpnServer"
    ansibleNodeType = "vpn"
    ansibleNodeName = "vpn"
    Terraform = "True"
  }
}
