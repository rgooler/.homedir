#!/bin/bash

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install things via homebrew
brew install wget tree curl tldr fish

# Setup python environment
pip install -r pip.txt
