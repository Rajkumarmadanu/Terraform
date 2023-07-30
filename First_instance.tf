provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "intro" {
  ami                    = "ami-00c6c849418b7612c"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-2a"
  key_name               = "dove-key"
  vpc_security_group_ids = ["sg-03a0867be214fe719"]
  tags = {
    Name = "Dove Instance"
  }
}