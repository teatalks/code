# Ansible installation
sudo apt update
sudo apt-add repository ppa:ansible/ansible -y
sudo apt-get install ansible -y
ansible --version

# Docker installation and setup
sudo apt-get -y update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce
sudo systemctl status docker
