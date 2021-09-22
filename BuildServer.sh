wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
echo deb http://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
sudo apt-get -y update && sudo apt-get -y upgrade
sudo apt -y install openjdk-8-jdk
sudo apt-get -y install jenkins
sudo systemctl start jenkins
