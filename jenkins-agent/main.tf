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

resource "aws_instance" "jenkins_ec2_instance_ip" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = var.tag_name
  }
  key_name                    = "jenkins.pub"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.sg_for_jenkins
  associate_public_ip_address = var.enable_public_ip_address
  
  user_data = var.user_data_install_jenkins
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 25
    volume_type = "gp2"
  }
  metadata_options {
    http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
    http_tokens   = "required" # Require the use of IMDSv2 tokens

  
  }
}
