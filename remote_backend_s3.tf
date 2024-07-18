terraform {
  backend "s3" {
    bucket = "dev-proj-1-jenkins-remote-state-bucket-67584"
    key    = "terraform-jenkins/terraform.tfstate"
    region = "us-east-1"
    key_name   = jenkins.pub
      }
}