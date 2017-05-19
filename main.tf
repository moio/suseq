provider "aws" {
  region = "us-east-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

module "aws_network" {
  source = "./aws_network"
  availability_zone = "us-east-1e"
  name_prefix = "${var.name_prefix}"
}

module "aws_eclipse_host" {
  source = "./aws_host"
  name = "eclipse-host"
  region = "us-east-1"
  availability_zone = "us-east-1e"
  ami = "ami-33ee1f25" // openSUSE-Leap-42.2-v20170118-hvm-ssd-x86_64-5535c495-72d4-4355-b169-54ffa874f849-ami-fded05eb.3
  instance_type = "t2.medium"
  volume_size = 10 // GiB
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

output "aws_eclipse_url" {
  value = "http://${module.aws_eclipse_host.public_name}/vnc.html"
}
