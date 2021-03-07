# Ansible installation
sudo apt -y update
sudo apt-add repository ppa:ansible/ansible
sudo apt-get -y install ansible
ansible --version

# Docker installation and setup
sudo apt-get -y update
sudo apt -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt -y update
apt-cache policy docker-ce
sudo apt -y install docker-ce
trap
sudo systemctl status docker

#cocker ps permissions to ubuntu 
sudo chmod 777 /var/run/docker.sock
docker ps
#Ansible environment setup
sudo cp /etc/ansible/hosts /etc/ansible/hosts_"$(date +"%Y_%m_%d_%I_%M_%p")"
