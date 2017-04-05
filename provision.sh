
echo "debug: starting provision.sh"

# Update apt-get
sudo apt-get update -y
echo "debug: apt-get updadated"

# Install Docker's dependencies
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
echo "debug: docker's dependencies installeds" 

# Add Docker's GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "debug: docker's repository key added"

# Add Docker's repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
echo "debug: docker's respository added"

# Re-Update apt-get
sudo apt-get update -y
echo "debug: reupdated apt-get"

# Install Docker CE
sudo apt-get install docker-ce -y
echo "debug: docker-ce installed"

# Starts/Restarts Docker's Service to avoid troubles
sudo service docker restart
echo "debug: Docker is Running"

# Adds user to docker's group to allow access docker-daemon without sudo
# Then relogin to make changes take effect
sudo gpasswd -a $USER docker
sudo su $USER

