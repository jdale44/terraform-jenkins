variable "ami_id" {}
variable "instance_type" {}
variable "tag_name" {}
variable "subnet_id" {}
variable "sg_for_jenkins" {}
variable "enable_public_ip_address" {}
variable "user_data_install_jenkins" {}
variable "key_name" {}

output "ssh_connection_string_for_ec2" {
  value = format("%s%s", "ssh -i /Users/place/Downloads/linux.pem ubuntu@", aws_instance.jenkins_ec2_instance_ip.public_ip)
}

output "jenkins_ec2_instance_ip" {
  value = aws_instance.jenkins_ec2_instance_ip.id
}

output "dev_proj_1_ec2_instance_public_ip" {
  value = aws_instance.jenkins_ec2_instance_ip.public_ip
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = var.key_name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDE6TLRIKhnKNustP3QUjdTNfOU7s+atK1mswEI7tuKhDHYp4fG62FfooXZDyQPEHsrDUtZDPxfXcRJgXM6RowfiBZx17N7lw3IJTRO/4dHjanpUuqCAP1DcnpnwywjwJwRpuxGp1BKmSygBJhESHLjZf3yej3DiV/KSYRyG002HT/NM0NIr/qGxQsA7XwD2tQrJuY0xG7FDDxjMJBEoqSLiHRj9qprEMJEC2DzR5hVIrC1IH396+afqlo4sm/zU7ul8zbgMAAdp7DJqgNA7q0HiufPAjRISEutaZXif5G83dIxhUR8nx7jJ1CJbZl/fpuA7xmCIEymcrj35YX1vGEBcsrbvcd0SaTB/hgHmTS66kd2enkaXHv1enNxjoCDjPT2yoYaG6WZjXmCwAma6Q70FocSsSw2vO+o/S/yOhsJl+MUcG2TgIewJoSFpO8pyUROB9Y+bwmyiTE2jHVH7NdrguYWtPYdIldlFabQlO8eclm3gZSkfnrq36WrCh1+BkM= place@DESKTOP-CV5UP5E"
}

resource "aws_instance" "jenkins_ec2_instance_ip" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = var.tag_name
  }
  key_name                    = aws_key_pair.my_key_pair.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.sg_for_jenkins
  associate_public_ip_address = var.enable_public_ip_address

  user_data = var.user_data_install_jenkins

  metadata_options {
    http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
    http_tokens   = "required" # Require the use of IMDSv2 tokens
    
  }
}
