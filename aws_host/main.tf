resource "aws_instance" "instance" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  availability_zone = "${var.availability_zone}"
  key_name = "${var.key_name}"
  monitoring = "${var.monitoring}"
  subnet_id = "${var.subnet_id}"
  vpc_security_group_ids = ["${var.security_group_id}"]

  root_block_device {
    volume_size = "${var.volume_size}"
  }

  tags {
    Name = "${var.name_prefix}-${var.name}"
  }
}

resource "null_resource" "instance_salt_configuration" {
  triggers {
    instance_id = "${aws_instance.instance.id}"
  }

  connection {
    host = "${aws_instance.instance.public_dns}"
    private_key = "${file(var.key_file)}"
  }

  provisioner "file" {
    source = "salt"
    destination = "/srv/salt"
  }

  provisioner "remote-exec" {
  inline = [
    "salt-call --local --file-root=/srv/salt/ --force-color state.highstate"
  ]
}

  provisioner "file" {
    content = <<EOF

hostname: ${aws_instance.instance.public_dns}

EOF

    destination = "/etc/salt/grains"
  }

  provisioner "remote-exec" {
    inline = [
      "salt-call --local state.highstate"
    ]
  }
}

output "public_name" {
  value = "${aws_instance.instance.public_dns}"
}
