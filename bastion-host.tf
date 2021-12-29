resource "aws_instance" "vprofile-bastion" {
  ami                    = lookup(var.AMIs, var.REGION)
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.vprofilekey.key_name
  subnet_id              = module.vpc.public_subnets[0]
  count                  = var.INSTANCE_COUNT
  vpc_security_group_ids = [aws_security_group.vprofile-bastion-sg.id]
  tags = {
    Name    = "vprofile-bastion"
    Project = "vprofile"
  }

  provisioner "file" {
    content     = templatefile("templates/db-deploy.tmpl", { rds-endpoint = aws_db_instance.vprofile-rds.address, dbuser = var.DBUSER, dbpass = var.DBPASS })
    destination = "/tmp/vprofile-dbdeploy.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/vprofile-dbdeploy.sh",
      "/tmp/vprofile-dbdeploy.sh"
    ]
  }

  connection {
    type        = "ssh"
    user        = var.USERNAME
    private_key = file(var.PRIVATE_KEY_PATH)
    host        = self.public_ip
  }

  depends_on = [aws_db_instance.vprofile-rds]
}