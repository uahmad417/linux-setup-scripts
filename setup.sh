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
sudo pip install virtualenv \
    bpython > /dev/null
echo -n "Do you want to install Docker Engine?(y/n): "
read -r DOCKER
if [ "${DOCKER:-n}" = "y" ]; then
    echo "Installing Docker"
    sudo apt-get install \
        ca-certificates \
        curl \
        gnupg \
        lsb-release -y > /dev/null
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update > /dev/null
    sudo apt-get install \
        docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-compose-plugin -y > /dev/null
    echo "Docker Installed"
    echo "Starting Docker Service"
    sudo service docker start
fi
echo "Setting up oh-my-fish shell prompt"
echo "Installing fish"
sudo apt-get install fish -y > /dev/null
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install
fish install --noninteractive --yes 
echo "omf install lambda" | fish > /dev/null
echo "omf theme lambda" | fish > /dev/null
echo "Setting fish as the default shell"
chsh -s /usr/bin/fish
echo "Setting up colorscripts"
git clone https://gitlab.com/dwt1/shell-color-scripts.git > /dev/null
cd shell-color-scripts
sudo make install > /dev/null
# optional for fish shell completion
sudo cp completions/colorscript.fish /usr/share/fish/vendor_completions.d
echo "Adding colorscripts to fish"
echo "colorscript -r" > "${HOME}/.config/fish/config.fish"
echo "Your environment is all set!"