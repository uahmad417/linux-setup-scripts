#!/bin/bash
# This script sets up my linux environment
echo "Setting up your enivironment"
echo "Installing packages"
sudo apt-get update > /dev/null
sudo apt-get install -y \
    vim \
    python3 \
    python3-pip \
    git \
    tmux \
    ranger \
    net-tools \
    iputils-ping \
    traceroute \
    build-essential
    curl > /dev/null
echo "Installing essential python modules"
pip install virtualenv \
    bpython > /dev/null
echo "Installing Docker"
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release > /dev/null
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update > /dev/null
sudo apt-get install \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-compose-plugin > /dev/null
echo "Docker Installed"
echo "Starting Docker Service"
sudo service docker start
echo "Testing Docker"
sudo docker run hello-world > /dev/null
if [ $? -eq 0 ]; then
    echo "Docker is working"
else
    echo "Something went wrong with setting up Docker"
fi
echo "Setting up oh-my-fish shell prompt"
echo "Installing fish"
sudo apt-get install fish > /dev/null
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
echo "omf install lambda" | fish
echo "omf theme lambda" | fish
echo "Setting fish as the default shell"
chsh -s /usr/bin/fish
echo "Setting up colorscripts"
git clone https://gitlab.com/dwt1/shell-color-scripts.git
cd shell-color-scripts
sudo make install
# optional for fish shell completion
cp completions/colorscript.fish /usr/share/fish/vendor_completions.d
echo "Adding colorscripts to fish"
