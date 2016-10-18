provider "aws" {
  region = "eu-central-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

module "aws_network" {
  source = "./aws_network"
  availability_zone = "eu-central-1a"
  name_prefix = "${var.name_prefix}"
}

module "aws_eclipse_host" {
  source = "./aws_host"
  name = "eclipse-host"
  region = "eu-central-1"
  availability_zone = "eu-central-1a"
  ami = "ami-426a8f2d" // openSUSE-Leap-42-1-v20160301-hvm-ssd-x86_64 in eu-central-1
  instance_type = "t2.medium"
  volume_size = 20 // GiB
  key_name = "${var.key_name}"
  key_file = "${var.key_file}"
  monitoring = true
  subnet_id = "${module.aws_network.subnet_id}"
  security_group_id = "${module.aws_network.security_group_id}"
  name_prefix = "${var.name_prefix}"
}

output "aws_eclipse_host_public_name" {
  value = "${module.aws_eclipse_host.public_name}"
}


output "aws_eclipse_http_public_name" {
  value = "http://${module.aws_eclipse_host.public_name}/vnc.html"
}
