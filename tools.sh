#Ansible installation
sudo apt update
sudo apt-add repository ppa:ansible/ansible -y
sudo apt-get install ansible -y
ansible --version
# Ansible environment setup
sudo cp /etc/ansible/hosts /etc/ansible/hosts_"$(date +"%Y_%m_%d_%I_%M_%p")"
