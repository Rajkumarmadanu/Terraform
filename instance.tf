resource "aws_key_pair" "dove-key" {
  key_name   = "dove-key"
  public_key = file("dovekey.pub")
}

resource "aws_instance" "dove_inst" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  key_name               = aws_key_pair.dove-key.key_name
  vpc_security_group_ids = ["sg-03a0867be214fe719"]
  tags = {
    Name    = "Dove-Instance"
    project = "Dove"
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote_exec" {

    inline = [
      "chmod u+x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }
  connection {
    user        = var.USER
    private_key = file("dovekey")
    host        = self.public_ip
  }

}