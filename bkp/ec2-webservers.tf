resource "aws_instance" "web" {
  count           = length(var.subnets_cidr)
  ami             = var.web-ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.web_sg.id]
  subnet_id       = element(aws_subnet.tf_public.*.id, count.index)
  user_data       = file("install_apache.sh")

  tags = {
    Name = "webserver_tf-${count.index + 1}"
  }
}
