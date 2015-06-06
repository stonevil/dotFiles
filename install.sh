#!/usr/bin/env bash

# Install dotFiles
if [[ -d $HOME/.Files ]]; then
  echo "dotFiles already installed"
else
  cd $HOME && git clone https://github.com/stonevil/dotFiles.git $HOME/.Files
fi
