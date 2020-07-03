provider "aws" {
region = "us-east-2"
access_key = "${var.cle_acces}"
secret_key = "${var.cle_secret}"

}
resource "aws_instance" "serveur"{
ami = "ami-0fc20dd1da406780b"
instance_type = "t2.micro"
key_name = "mor"
vpc_security_group_ids = ["${aws_security_group.projet-GS.id}"]
user_data = <<-EOF
            #!/bin/bash
            sudo apt-get update -y
	    sudo mkdir /tmp/mor
	    git clone "https://github.com/fallmor/IAC-projet/tree/master/deployondocker" /tmp/mor 
            cd /tmp/mor
            sudo chmod +x *.sh
            ./ansible.sh
            sudo ansible-playbook provision.yml
EOF
tags = {
    Name = "serveur"
}

}
resource "aws_security_group" "projet-GS" {
name ="acces-ssh"
ingress{
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress{
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
ingress{
from_port = 443
to_port = 443
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
egress{
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}
