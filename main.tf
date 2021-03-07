#Squad12-Launch instances

locals {
vpc_id    = "vpc-b31390d8"
subnet_id = "subnet-1ee94375"
ssh_user  = "ubuntu"
pvt_key   = "~/dhaba/key/squad12.pem"
key_name  = "squad12key"
ubuntu184 = "ami-01e7ca2ef94a0ae86"
medium    = "t2.medium"
micro     = "t2.micro"
large     = "t2.large"
}

#### Cloud Provider ####

provider "aws" {
region = "us-east-2"
}

# Build Server

resource "aws_instance" "squad12Build" {
    ami = local.ubuntu184
    subnet_id = local.subnet_id
    instance_type = local.large
    associate_public_ip_address = true
security_groups=[aws_security_group.squad12sg.id]
key_name = local.key_name
        tags = {
        Name = "squad12-Build"
    }

provisioner "remote-exec" {
inline = ["echo wait for SSH","wget https://raw.githubusercontent.com/squad12-devops/case-study/main/tools.sh","bash tools.sh","echo Done!"]
connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.pvt_key)
      host        = aws_instance.squad12Build.public_ip
    }
  }

}

output "tomcat_login_ip" {
  value = aws_instance.squad12Build.public_ip
}

# Test Server

resource "aws_instance" "squad12Test" {
    ami = local.ubuntu184
    subnet_id = local.subnet_id
    instance_type = local.micro
    associate_public_ip_address = true
security_groups=[aws_security_group.squad12sg.id]
key_name = local.key_name
        tags = {
        Name = "squad12-Test"
    }
}
# Prod Server

# Test Server

resource "aws_instance" "squad12Prod" {
    ami = local.ubuntu184
    subnet_id = local.subnet_id
    instance_type = local.micro
    associate_public_ip_address = true
security_groups=[aws_security_group.squad12sg.id]
key_name = local.key_name
        tags = {
        Name = "squad12-Prod"
    }
}
