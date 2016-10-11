variable "name" {
  description = "Symbolic name of this host for terraform use"
  type = "string"
}

variable "region" {
  description = "Region where the instance is created"
  type = "string"
}

variable "availability_zone" {
  description = "Availability zone where the instance is created"
  type = "string"
}

variable "ami" {
  description = "AMI of the custom openSUSE Terraform image for the us-east-1 region, see aws_images"
  type = "string"
}

variable "instance_type" {
  description = "Instance type, see a list at: https://aws.amazon.com/ec2/instance-types/"
  default = "t2.nano"
}

variable "volume_size" {
  description = "Size of the root volume in GiB"
  default = 10
}

variable "monitoring" {
  description = "Wether to enable AWS's Detailed Monitoring"
  default = false
}

variable "key_name" {
  description = "Name of the SSH key for the instance"
  type = "string"
}

variable "key_file" {
  description = "Path to the private SSH key"
  type = "string"
}

variable "subnet_id" {
  description = "ID of the subnet, see aws_network"
  type = "string"
}

variable "security_group_id" {
  description = "ID of the security group, see aws_network"
  type = "string"
}

variable "name_prefix" {
  description = "A prefix for names of objects created by this module"
  type = "string"
}
