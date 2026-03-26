provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow SSH and HTTP inbound traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

resource "aws_instance" "aws_web" {
  ami           = "ami-0010deabdfbaf9637" 
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "AWS-Web-Server"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum install -y nginx
              systemctl enable nginx
              systemctl start nginx
              echo "Welcome to AWS with Multi-Cloud Deployment" > /usr/share/nginx/html/index.html
              EOF
}





provider "google" {
  project = 267813738003
  region  = "us-central1"
  zone    = "us-central1-a"
  credentials = <<EOF
{
  "type": "service_account",
  "project_id": "parabolic-might-474607-m6",
  "private_key_id": "c711aac829c88d9c94c9898e7b7f665488fb3035",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCOUtCjaV4WnWbH\ns49eMIj8OeXlQsnRj700HaKxy+0IdwpIgAAkwIM79rbIK8amfg5MidOD8cfsyGN4\n6fMWgQ9HRGZ0CmreVn1EExFy5Q45UlW4DZKjfxY9riU7/75g3cbygu4uSLSe2xRp\novw/LTEOj0881g8Lr3yDm75v1rhnM2PDyHJdvXFoM+Ql8z94OuEhLbFkG93qyT6s\ne+fyUEducBe+0RcySSZZ6+r/UEEr71j41f5yLSW8TM0p8bUSKYnoVSEHqe4GtqiR\nzK3ehuGqcBvMVLZ3BwWNDTOcjPkPQ0TU1Cz3KJZ4UHDnGa0RZ6CEOkJWttDsjR8c\nr62oQlotAgMBAAECggEADcwuiOESq4uX5r1cJUv8Q8OTK441hZjzRUWoO6di8+Ki\nfxPVr7pwHpSU9MP1rrdiyH3GITED6kslBZhcpi5d3lFdw1stMB/fZgWZN/PH1LvM\nLps2P552+ATVfEMXYEmv21vhHmCTDiF8EZ+o57EIY/p1upaf/8iEADhNlocQ+oQm\nYRm3q8MAzPhUmdS486UHUpw2L5RLekdAdExV9an5YR65vJ/7p6/ITevEGsyTgwNf\nT9ULNOSBCBYyuNgEmj6rQ/gdlBqif21TdOoUsTlo7oo6tXR0bcs/O306EA/rqyb7\nJZhfk+6+cMYjbGYQFE6PtYOZ7AePWHCfcSk263wJewKBgQDBGznBp1gvnCGfz6er\nvRostPq66pfc9DpN0WHme7gz1YXDCmPFvJZEJ0+qNEho0sPwtKSont0d52htP16B\n6v7HrzSN1Wtu3jDSPTN0RKM6jNCsGAS/raqOqqot8HQIaN4OgunuySRj2QtQjsYC\nvVARUWl+6Vv8vR5Eknu3w86eCwKBgQC8rW3M6xJAXirnMaLMq4Pd1oe/OLnFq1zj\nS5t/CR8ONuYlbWHNp8PY4cKXMsHNxJMWbG5L76Zr2s5NTKNMht8bzvsUpeVYSx8I\n8tjIU27rHJvmlKfjMbuDkSiD1l19Jdr++Y1ccoqZbaqdp2wLGMaChfzEAZKJ4q02\nIk1C1/FjpwKBgQCPQEwrPaIsx20mKZyfyUumiKdLjAYWUlMCMWan3XW7dhWhp452\nPL1YV7VAdUKWCGx0nv1bXWZ47ZbJHG5WgGZ66Z1Z7k2hVFDxVZdbFCPmplmSoMq9\nCu7woOhX5f2d03WPXEx/6FUHgRZkr1Vy6M+B2VwiWqjzp7PReL0wiKA5GwKBgDmz\n5I+2GLfc1MwuDvb/QW337T4bEB2XAep1thGM7ZWATrSFllK6CxhqOwPYvxK6Gq3R\n7Y2FtmTn3w4e8RY3bUZo77rp3ZE6MDyhYJErixGWh0tmjU3baNic7UIcrizXBfnS\nwlvSn/a6ZmKe0Fk4c4V5iss7G+DVlVmn9e8KccWjAoGAYbFEYUSwu4hR0eB0RvGK\nVR9PmsWwt2nSxA3ex6KOxLV/PbBdkMxEcDAFA5YWMUqqQYjC+5SBLkqskY0vMThr\nS1Qcjnd5XvnTS75Cb849bxsZnjJ7KhE1cMlTVlLfdfprRQzEIaSlWs52n4uemhDQ\nAIjbTRlQLsqVW3cOVZiU2b0=\n-----END PRIVATE KEY-----\n",
  "client_email": "267813738003-compute@developer.gserviceaccount.com",
  "client_id": "102812662012550594094",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/267813738003-compute%40developer.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
EOF
}

resource "google_compute_instance" "gcp_web" {
  name         = "gcp-web-server"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y nginx
              systemctl enable nginx
              systemctl start nginx
              echo "Welcome to GCP with Multi-Cloud Deployment" > /var/www/html/index.nginx-debian.html
              EOF
}

