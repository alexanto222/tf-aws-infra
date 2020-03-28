resource "aws_elb" "tf_web_elb" {
  name = "webserver-elb"
  #  availability_zones = ["var.azs"]
  subnets         = ["aws_subnet.tf_public.*.id"]
  security_groups = ["aws_security_group.web_sg.id"]
  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.html"
    interval            = 10
  }

  instances                   = ["aws_instance.web.*.id"]
  cross_zone_load_balancing   = true
  idle_timeout                = 100
  connection_draining         = true
  connection_draining_timeout = 300

  tags = {
    Name = "tf-webserver-elb"
  }
}

output "elb-dns-name" {
  value = aws_elb.tf_web_elb.dns_name
}

