#!/usr/bin/env zsh
#
#  "Borrowed" from 
#  https://github.com/eieioxyz/dotfiles_macos/blob/master/setup_homebrew.zsh
#
echo "\n<<< Starting Homebrew Setup >>>\n"

if exists brew; then
  echo "brew exists, skipping install"
else
  echo "brew doesn't exist, continuing with install"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Depends on Brewfile here:
brew bundle --verbose

