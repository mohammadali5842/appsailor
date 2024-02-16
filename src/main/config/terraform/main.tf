terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
provider "aws" {
  access_key = "AKIAQ3EGP6ZUDRKEZSIR"
}

resource "aws_vpc" "sailorvpc" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "sailorsubnet" {
  vpc_id = aws_vpc.sailorvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
}

resource "aws_key_pair" "sailor_kp" {
  key_name = "sailor_kp"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCffnvTTAkamy2Kv/4YTyrZwTsvOkf8U7HgGzcLrWnsiY6cuPWGgQXDsWnLgpNv2deNECqQ/McJRrLci0En9gfpSlrhMglx5I2CEsjYe0f7S1argp5HcBpIIHEBigHhdif3xxChOKUcq99e5YADNaZ/nvRYiSQ4atM7KleTSLYTMD1CdSuGkKsN3fIcG366+jRzi6XsU/jUOUOsDFBMiIg1954PA/cycTyMQiFnuImez5AfbASSM6i9PXBGxGeImlAAMHkVx3qrwny4qB/z4P3JUwMZYU7l+p2sx0+n40GcmUeIrlB5YabthcohgyCjtKFPqlg9jWzRhPedFrtMD1FaHlpCFRzvORARP6ELUd4Vz5Vw+6egz6Ei5+hyvhyQdTcQVrDg8obGbO4lDd7weeX0u8W7kut5CkqoSU26BpY3YXEMy+Y1/RPrESNN8gPfrBWywcTBUv7YKRVgcdhp6xJCirtZPUcFcvMC1POXYvFxqOx3hXQcHU+WMOktn6i00J0= dell@DESKTOP-TI131FD"
}
resource "aws_instance" "sailor_instance" {
  subnet_id = aws_subnet.sailorsubnet.id
  ami = "ami-03f4878755434977f"
  instance_type = "t2.micro"
  key_name = aws_key_pair.sailor_kp.key_name
  tags = {
    "name" = "sailor_instance"
  }
}