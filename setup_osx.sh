#!/bin/bash

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install things via homebrew
brew install wget tree curl tldr fish

# Setup python environment
pip install -r pip.txt

mkdir -p /tmp/homedir-setup
cd /tmp/homedir-setup

# Install atom text editor
wget https://atom.io/download/mac
unzip mac
rm mac
mv Atom.app /Applications/

# Install Slack
wget https://slack.com/ssb/download-osx
unzip download-osx
rm download-osx
mv Slack.app /Applications/

# Install npm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash


cd -
# Install fonts
cd fonts
./install.sh
cd -
