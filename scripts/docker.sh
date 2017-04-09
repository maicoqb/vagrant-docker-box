
echo "debug: starting docker.sh"

# Update apt-get
sudo apt-get update -y && sudo apt-get clean
echo "debug: apt-get updadated"

# Install Docker's dependencies
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
echo "debug: Docker's dependencies installeds" 

# Add Docker's repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
echo "debug: Docker's respository added"

# Re-Update apt-get
sudo apt-get update -y && sudo apt-get clean
echo "debug: reupdated apt-get"

# Install Docker CE
sudo apt-get install docker-ce -y
echo "debug: docker-ce installed"

# Install docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo "debug: Docker Compose Installed"

# Adds user to docker's group to allow access docker-daemon without sudo
# Then relogin to make changes take effect
sudo gpasswd -a vagrant docker
sudo su vagrant
echo "debug: Add vagrant to docker group"

# Starts/Restarts Docker's Service to avoid troubles
sudo service docker restart
echo "debug: Docker is Running"
