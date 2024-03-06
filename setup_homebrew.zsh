#!/usr/bin/env zsh
#
#  "Borrowed" from 
#  https://github.com/eieioxyz/dotfiles_macos/blob/master/setup_homebrew.zsh
#

# Update sudo timestamp to ensure sudo access without prompt
# in the middle of the script
sudo -v

echo "\n<<< Checking for Xcode Command Line Tools >>>\n"

##
##
##  Going to comment this out for now, as I don't think
##  it's working.
##
# Check if Xcode Command Line Tools are installed
#if xcode-select -p &>/dev/null; then
    #echo "Xcode Command Line Tools already installed, checking for updates..."
    ## Consider prompting for manual update check or automate updates if possible
#else
    #echo "Xcode Command Line Tools not found, installing..."
    #sudo xcode-select --install
    ## Wait until the Xcode Command Line Tools are installed
    #until xcode-select -p &>/dev/null; do
        #sleep 5
    #done
    #echo "Xcode Command Line Tools installed."
#fi

echo "\n<<< Starting Homebrew Setup >>>\n"

if type brew >/dev/null 2>&1; then
  echo "brew exists, checking for updates..."
  brew update-reset
else
  echo "brew doesn't exist, continuing with install"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi


# Depends on Brewfile here:
brew bundle --verbose

