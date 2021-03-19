locals {
vpc_id    = "vpc-b31390d8"
subnet_id = "subnet-1ee94375"
ssh_user  = "ubuntu"
pvt_key   = "~/dhaba/key/squad12.pem"
key_name  = "squad12key"
ubuntu184 = "ami-01e7ca2ef94a0ae86"
medium    = "t2.medium"
micro     = "t2.micro"
large     = "t2.2xlarge"
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
inline = ["echo wait for SSH","wget https://raw.githubusercontent.com/squad12-devops/case-study/main/build.sh","sudo bash build.sh","sudo wget http://www-us.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz","sudo tar -xvf apache-maven-3.5.4-bin.tar.gz -C /root","docker pull squad12devops/squad12-jenkins-docker-image:latest","echo Done!"] 

connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.pvt_key)
      host        = aws_instance.squad12Build.public_ip
    }
  }

}

# Test Server

resource "aws_instance" "squad12Test" {
    ami = local.ubuntu184
    subnet_id = local.subnet_id
    instance_type = local.large
    associate_public_ip_address = true
security_groups=[aws_security_group.squad12sg.id]
key_name = local.key_name
        tags = {
        Name = "squad12-Test"
    }

provisioner "remote-exec" {
inline = ["echo wait for SSH","wget https://raw.githubusercontent.com/squad12-devops/case-study/main/nodes.sh","sudo bash nodes.sh","echo Done!"]
connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.pvt_key)
      host        = aws_instance.squad12Test.public_ip
    }
  }
}

# Prod Server

resource "aws_instance" "squad12Prod" {
    ami = local.ubuntu184
    subnet_id = local.subnet_id
    instance_type = local.large
    associate_public_ip_address = true
security_groups=[aws_security_group.squad12sg.id]
key_name = local.key_name
        tags = {
        Name = "squad12-Prod"
    }

provisioner "remote-exec" {
inline = ["echo wait for SSH","wget https://raw.githubusercontent.com/squad12-devops/case-study/main/nodes.sh","sudo bash nodes.sh","echo Done!"]
connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.pvt_key)
      host        = aws_instance.squad12Prod.public_ip
    }
  }
}

output "JIRA" {
  value = "https://12squaddevops.atlassian.net/"
}
output "GitHub" {
  value = "https://github.com/squad12-devops/case-study"
}
output "Jenkins" {
  value = aws_instance.squad12Build.public_ip
}
output "SonarQube" {
  value = "SonarQube URL"
}
output "Slack" {
  value = "https://https://app.slack.com/client/T01PFJ01H51/C01PFJ2AZ0B"
}
output "Artifactory" {
  value = "https://squad12devops.jfrog.io/ui/login/"
}
output "Blazemeter" {
  value = "blazemeter URL"
}

output "QAWebapp" {
  value = aws_instance.squad12Test.public_ip
}
output "ProdWebapp" {
  value = aws_instance.squad12Prod.public_ip
}
