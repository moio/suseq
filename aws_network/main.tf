resource "aws_vpc" "main" {
  cidr_block = "172.16.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags {
    Name = "${var.name_prefix}-vpc"
  }
}

resource "aws_subnet" "subnet" {
  availability_zone = "${var.availability_zone}"
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "172.16.0.0/16"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.name_prefix}-subnet"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.name_prefix}-internet-gateway"
  }
}

resource "aws_route_table" "internet" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name = "${var.name_prefix}-internet-route-table"
  }
}

resource "aws_main_route_table_association" "vpc_internet" {
  vpc_id = "${aws_vpc.main.id}"
  route_table_id = "${aws_route_table.internet.id}"
}

resource "aws_security_group" "security_group" {
  name = "${var.name_prefix}-security-group"
  description = "Allow inbound connections on port 8080, 22, >32768; allow all outbound connections"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port = 32768
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name = "${var.name_prefix}-security-group"
  }
}

output "subnet_id" {
  value = "${aws_subnet.subnet.id}"
}

output "security_group_id" {
  value = "${aws_security_group.security_group.id}"
}
