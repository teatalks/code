# Ansible installation
sudo apt -y update
sudo apt-add repository ppa:ansible/ansible
sudo apt-get -y install ansible
ansible --version
ssh-keygen -t rsa -N '' -f /tmp/ssh_sq12 -q
ansible -m ping localhost
cat ~/.ssh/id_rsa.pub

# Docker installation and setup
sudo apt-get -y update
sudo apt -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt -y update
apt-cache policy docker-ce
sudo apt -y install docker-ce

#cocker ps permissions to ubuntu 
sudo chmod 777 /var/run/docker.sock
docker ps

#Ansible environment setup
#sudo cp /etc/ansible/hosts /etc/ansible/hosts_"$(date +"%Y_%m_%d_%I_%M_%p")"

#Maven Installation is part of main.tf

# ELK Dashboard Installation and Setup
sudo apt-get -y update
sudo apt-get -Y install default-jre
sudo wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get -y update && sudo apt-get -y install elasticsearch
sudo service elasticsearch start
sudo systemctl enable elasticsearch
sudo apt-get -y install kibana
sudo service kibana start
sudo systemctl enable kibana
