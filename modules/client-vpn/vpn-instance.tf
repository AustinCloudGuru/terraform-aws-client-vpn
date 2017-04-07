resource "aws_instance" "vpn" {
  ami = "ami-6d1c2007"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = "${aws_subnet.vpn-1a.id}"
  key_name = "bosh"
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
